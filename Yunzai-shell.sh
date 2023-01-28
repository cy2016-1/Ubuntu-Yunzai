#!/bin/bash
pushd $HOME
Ubuntuv=$(lsb_release -r | awk '{print $2}')
architecture=$(uname -m)
ver=1.1.4
if [ ! -f "/usr/bin/bhyz" ]; then
    wget -O bhyz https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/Yunzai-shell.sh >> log.txt 2>&1 &
    {
       for ((i = 0 ; i <= 100 ; i+=1)); do
          sleep 0.01s
          echo $i
       done
    } | whiptail --gauge "检测到新版本 正在更新" 6 60 0
    mv bhyz /usr/bin
    chmod +x /usr/bin/bhyz
    bhyz
    rm log.txt
fi
version=`curl -s https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/version-bhyz.sh`
if [ "$version" != "$ver" ]; then
    rm -rf /usr/bin/bhyz
    wget -O bhyz https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/Yunzai-shell.sh >> log.txt 2>&1 &
    {
       for ((i = 0 ; i <= 100 ; i+=1)); do
          sleep 0.01s
          echo $i
       done
    } | whiptail --gauge "检测到新版本 正在更新" 6 60 0
    mv bhyz /usr/bin
    chmod +x /usr/bin/bhyz
    bhyz
    rm log.txt
fi

while true
do
baihu=$(whiptail \
--title "白狐≧▽≦" \
--menu "${ver}" \
17 40 7 \
"1" "管理Yunzai-Bot" \
"2" "安装Yunzai-Bot" \
"3" "安装Yunzai插件" \
"4" "打开附加安装菜单" \
"5" "帮助" \
"0" "退出" \
3>&1 1>&2 2>&3)

feedback=$?
if [ $feedback = 0 ];then
  #调用管理脚本
  if [[ ${baihu} = 1 ]]
   then
     if [ -d "/root/Yunzai-Bot" ];then
       admin=$(whiptail \
       --title "白狐≧▽≦" \
       --menu "${ver}" \
       17 40 10 \
       "1" "启动Yunzai-Bot" \
       "2" "停止Yunzai-Bot" \
       "3" "查看Yunzai-Bot日志" \
       "4" "后台启动Yunzai-Bot" \
       "5" "完全重置账号" \
       "6" "修复QQ版本过低" \
       "7" "修复redis报错" \
       "8" "修复py服务器启动失败" \
       "9" "修复puppeteer Chromium 启动失败" \
       "0" "打开安装脚本" \
       3>&1 1>&2 2>&3 )
          #启动
           if [[ ${admin} = 1 ]];then
              pushd ~/Yunzai-Bot
              redis-server --daemonize yes --save 900 1 --save 300 10
              node app
           fi
           
           #停止
           if [[ ${admin} = 2 ]];then
              pushd ~/Yunzai-Bot
              pnpm stop
           fi
           
           #日志
           if [[ ${admin} = 3 ]];then
              pushd ~/Yunzai-Bot
              pnpm run log
           fi
           
           #后台启动
           if [[ ${admin} = 4 ]];then
           pushd ~/Yunzai-Bot
           redis-server --save 900 1 --save 300 10 --daemonize yes
           nohup node app >> Yunzai.log 2>&1 &
           fi
           
           #完全重置账号
           if [[ ${admin} = 5 ]];then
           pushd ~/Yunzai-Bot/config/config
           rm bot.yaml group.yaml other.yaml qq.yaml redis.yaml
           pushd ~/Yunzai-Bot
           pnpm run login
           fi
           
           #报错修复
           if [[ ${admin} = 6 ]];then
             qq=$(whiptail \
             --title "白狐≧▽≦" \
             --inputbox "请输入您的机器人qq号 输完后回车" \
             10 60 \
             3>&1 1>&2 2>&3)
            
             if [ -d "/root/Yunzai-Bot/data/${qq}" ]; then
             pushd /root/Yunzai-Bot/data/${qq}
             #随机输生成
             function baihuqq(){
             min=$1
             max=$(($2-$min+1))
             num=$(date +%s%N)
             echo $(($num%$max+$min))
             }
             imeibh=$(baihuqq 100000000000000 999999999999999)
             sed -i '15s/.*/ \"imei\": \"wcnm\",/g' device-${qq}.json
             sed -i 15s/wcnm/${imeibh}/g device-${qq}.json
             whiptail --title "白狐≧▽≦" --msgbox \
             "修复完成 [注:一次不行 多试几次 实在不行 换一个号]" \
             10 60
            else
             whiptail --title "白狐≧▽≦" --msgbox \
             "错误: ${qq} 该账号没有登录过" \
             10 60
            fi
           fi
           
           #redis报错
           if [[ ${admin} = 7 ]];then
           apt-get autoremove redis -y
           rm -rf /etc/redis
           apt-get install redis -y
           fi
           
           #py报错
           if [[ ${admin} = 8 ]];then
             if [-d /root/Yunzai-Bot/plugins/py-plugin ];then
               pushd  /root/Yunzai-Bot/plugins/py-plugin
               poetry install 
               poetry install
               function py(){
               min=$1
               max=$(($2-$min+1))
               num=$(date +%s%N)
               echo $(($num%$max+$min))
               }
               pyport=$(py 4000 6000)
               sed "20s/.*/port: ${pyport}/g" config.yaml
               pushd $HOME
               whiptail --title "白狐≧▽≦" --msgbox \
               "修复完成 [注:一次不行 多试几次]" \
              10 60
             else
               whiptail --title "白狐≧▽≦" --msgbox \
               "错误: 您好好像还没有安装py插件" \
               10 60
             fi
           fi
           
           if [[ ${admin} = 9 ]];then
            if [ "$architecture" = "aarch64" ]; then
             echo -e "\033[34m 调用甘雨大佬的浏览器修复 感谢 \033[0m";
             pushd $HOME
             rm -rf /usr/bin/chromium-browser
             git clone --depth=1 https://gitee.com/Ganyu256/chromium
             pushd chromium
             bash install.sh
             pushd ..
             rm -rf chromium
             rm -rf chromium
             echo;echo -en "\033[32m 修复完成 回车返回\033[0m";read -p ""
            elif [ "$architecture" = "x86_64" ]; then
             echo "还没写"
             echo;echo -en "\033[32m 回车返回\033[0m";read -p ""
            else
             echo -e "\033[31m 错误: 不支持的框架 \033[0m";
             exit
            fi
         fi 
           
           
           #返回安装脚本
           if [[ ${admin} = 0 ]];then
           bhyz
           fi
     else
           whiptail --title "白狐≧▽≦" --msgbox "
           您好像还没有未安装云崽呢，快去安装吧!
           " 10 43        
    fi
 fi
  
  #安装脚本
  if [[ ${baihu} = 2 ]]
    then
    if [ -d "/root/Yunzai-Bot" ];then
       whiptail --title "白狐≧▽≦" --msgbox "
       您已安装云崽 禁止套娃
       " 10 43
     else
       # 更新软件源和软件
        echo -e "\033[34m 更新软件 \033[0m";
        apt update
        apt upgrade -y
        echo -e "\033[34m 更新完成 \033[0m";
        echo

        # 安装nodejs
        echo '安装nodejs';
        if [ "$Ubuntuv" == "18.04" ]; then
        bash <(curl -L https://deb.nodesource.com/setup_16.x)
        elif [ "$Ubuntuv" == "22.04" ]; then
        bash <(curl -L https://deb.nodesource.com/setup_19.x)
        elif [ "$Ubuntuv" == "22.10" ]; then
        bash <(curl -L https://deb.nodesource.com/setup_19.x)
        else
        bash <(curl -L https://deb.nodesource.com/setup_16.x)
        fi
        apt-get install -y nodejs
        npm -v
        if [ $? -ne 0 ]
        then
        echo -e "\033[34m nodejs安装失败 请检查网络 \033[0m";
          exit
        else
          echo -e "\033[34m nodejs安装成功 \033[0m";
        fi
        echo        
        
        #安装pnpm
        echo -e "\033[34m 开始安装pnpm  \033[0m";
        npm config set registry http://registry.npm.taobao.org/
        npm install -g npm
        npm install -g pnpm
        pnpm config set registry http://registry.npm.taobao.org/
        pnpm -v
        if [ $? -ne 0 ]
        then
        echo -e "\033[34m 安装pnpm失败 请检查网络 \033[0m";
          exit
        else
          echo -e "\033[34m 安装pnpm成功 \033[0m";
        fi
        echo
        
        # 安装并运行redis
        echo -e "\033[34m 安装redis \033[0m";
        apt-get install redis -y
        redis-server --daemonize yes
        echo '安装redis完成';
        echo

        # 安装chromium
        echo -e "\033[34m 安装chromium \033[0m";
        apt install chromium-browser -y
        echo '安装chromium完成';
        echo
        
        #安装中文字体
        echo -e "\033[34m 安装中文字体 \033[0m";
        apt-get install -y fonts-wqy-microhei fonts-wqy-zenhei

        # 克隆项目
        echo -e "\033[34m 正在克隆Yunzai-Bot \033[0m";
        pushd ~/
        git clone --depth=1 -b main https://gitee.com/Le-niao/Yunzai-Bot.git
          if [ ! -d "~/Yunzai-Bot" ]
            then
              echo -e "\033[34m 克隆成功 \033[0m";
            else
              echo -e "\033[34m 克隆失败 请检查网络 \033[0m";
              exit 0
          fi
        echo
        
        #安装Yunzai依赖
        echo -e "\033[34m 安装依赖 \033[0m";
        pushd ~/Yunzai-Bot
        pnpm install -P && pnpm install -P
        pnpm ls oicq
        if [ $? -ne 0 ]
          then
          echo -e "\033[34m 依赖安装失败 请检查网络 \033[0m";
          exit
        else
          echo -e "\033[34m 依赖安装成功 \033[0m";
        fi
        pushd ~/
        echo
        
        #写入自动命令
        if [ -e "/usr/bin/yz" ]
           then
           echo -e "\033[34m 检测到已写入 \033[34m";
           echo "退出"
           exit 
        else
          pushd $HOME 
           echo '正在将启动写入启动命令'
           #启动
           echo echo 正在启动Yunzai-Bot > /usr/bin/yz
           sed -i -e '1a redis-server --daemonize yes --save 900 1 --save 300 10 && cd ~/Yunzai-Bot && node app' /usr/bin/yz 
           chmod 777 /usr/bin/yz
           #日志
           echo echo 正在打开Yunzai-Bot后台日志 > /usr/bin/yzlog
           sed -i -e '1a cd ~/Yunzai-Bot && pnpm run log' /usr/bin/yzlog 
           chmod 777 /usr/bin/yzlog
           #登录
           echo echo 正在启动Yunzai-Bot登录配置 > /usr/bin/yzlogin
           sed -i -e '1a cd ~/Yunzai-Bot && pnpm run login' /usr/bin/yzlogin
           chmod 777 /usr/bin/yzlogin
           #后台
           echo echo 正在停止Yunzai-Bot后台运行 > /usr/bin/yzstop
           sed -i -e '1a cd ~/Yunzai-Bot && pnpm stop' /usr/bin/yzstop
           chmod 777 /usr/bin/yzstop
           pushd 
           echo
        fi
        if (whiptail --title "白狐≧▽≦" --yesno "
        云崽配置完成 
        是否直接启动云崽
        注:直接启动会要你输人机器人的密码和账号
        密码默认不显示" \
        15 60);then
        pushd Yunzai-Bot
        node app
        fi
    fi
  fi
  
  #调用插件脚本
  if [[ ${baihu} = 3 ]]
   then
      if [ -d "/root/Yunzai-Bot" ];then
       bash <(curl -sL https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/plug-in.sh)
     else
      whiptail --title "白狐≧▽≦" --msgbox "
       您好像还没有未安装云崽呢，快去安装吧!
       " 10 43
     fi
   fi
  
  #调用附加安装脚本
  if [[ ${baihu} = 4 ]]
    then
       installing=$(whiptail \
       --title "白狐≧▽≦" \
       --menu "${ver}" \
       20 45 10 \
       "1" "安装python3.10.8和pip和poetry" \
       "2" "安装ffmpeg" \
       3>&1 1>&2 2>&3 )
       ctmd=$?
     
      if [[ ${installing} = 1 ]]
         then
         pushd $HOME
        if [ "$Ubuntuv" == "18.04" ]; then
          echo -e "\033[34m 开始安装python3.10.8 pip poetry \033[0m";
          echo -e "\033[34m 安装依赖包 \033[0m";
          apt-get install git gcc g++ make cmake build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl -y
          git clone --depth=1 https://gitee.com/baihu433/python3.10.8.git
          mv python3.10.8/Python-3.10.8.tar.xz ~/
          rm -rf python3.10.8
          rm -rf python3.10.8
          echo -e "\033[34m 解压源码 \033[0m";
          tar xvJf Python-3.10.8.tar.xz
          rm -rf Python-3.10.8.tar.xz
          rm -rf Python-3.10.8.tar.xz
          pushd Python-3.10.8
          echo -e "\033[34m 编译python3.10.8源码 \033[0m";
          rm -rf /usr/local/python3
          ./configure --prefix=/usr/local/python3/
          echo '编译完成'
          # 开始安装python3.
          echo -e "\033[34m 安装python3.10.8 \033[0m";
          make && make install
          pushd ~/
          echo '安装完成'
          # 添加环境变量
          echo '添加环境变量'
          PATH=/usr/local/python3/bin:$PATH
          rm /usr/bin/python /usr/bin/pip /usr/bin/poetry
          rm -rf Python-3.10.8
          rm -rf python-3.10.8
          ln -s /usr/local/python3/bin/python3 /usr/bin/python
          ln -s /usr/local/python3/bin/pip3 /usr/bin/pip
          pip config set global.index-url https://pypi.mirrors.ustc.edu.cn/simple/
          python -m pip install --upgrade pip
          pip --version
          echo -e "\033[34m 安装poetry \033[0m";
          curl -sSL https://install.python-poetry.org | python -
          ln -s ~/.local/bin/poetry /usr/bin/poetry
          poetry --version
          echo
        elif [ "$Ubuntuv" == "22.04" ]; then
          apt install python3.10
          rm  /usr/bin/python 
          ln -s /usr/bin/python3.10 /usr/bin/python
          curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py 
          python get-pip.py 
          pip config set global.index-url https://pypi.mirrors.ustc.edu.cn/simple/
          curl -sSL https://install.python-poetry.org | python -
          ln -s ~/.local/bin/poetry /usr/bin/poetry
        elif [ "$Ubuntuv"= "22.10" ]; then
          apt install python3.10
          rm  /usr/bin/python 
          ln -s /usr/bin/python3.10 /usr/bin/python
          curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py 
          python get-pip.py 
          pip config set global.index-url https://pypi.mirrors.ustc.edu.cn/simple/
          curl -sSL https://install.python-poetry.org | python -
          ln -s ~/.local/bin/poetry /usr/bin/poetry
        else
          apt-get install git gcc g++ make cmake build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl -y
          git clone --depth=1 https://gitee.com/baihu433/python3.10.8.git
          mv python3.10.8/Python-3.10.8.tar.xz ~/
          rm -rf python3.10.8
          rm -rf python3.10.8
          echo -e "\033[34m 解压源码 \033[0m";
          tar xvJf Python-3.10.8.tar.xz
          rm -rf Python-3.10.8.tar.xz
          rm -rf Python-3.10.8.tar.xz
          pushd Python-3.10.8
          echo -e "\033[34m 编译python3.10.8源码 \033[0m";
          rm -rf /usr/local/python3
          ./configure --prefix=/usr/local/python3/
          echo '编译完成'
          echo -e "\033[34m 安装python3.10.8 \033[0m";
          make && make install
          pushd ~/
          echo '安装完成'
          echo '添加环境变量'
          PATH=/usr/local/python3/bin:$PATH
          rm /usr/bin/python /usr/bin/pip /usr/bin/poetry
          rm -rf Python-3.10.8
          rm -rf python-3.10.8
          ln -s /usr/local/python3/bin/python3 /usr/bin/python
          ln -s /usr/local/python3/bin/pip3 /usr/bin/pip
          pip config set global.index-url https://pypi.mirrors.ustc.edu.cn/simple/
          python -m pip install --upgrade pip
          pip --version
          echo -e "\033[34m 安装poetry \033[34m";
          curl -sSL https://install.python-poetry.org | python -
          ln -s ~/.local/bin/poetry /usr/bin/poetry
          poetry --version
        fi
       fi
       if [[ ${installing} = 2 ]]
         then
         if [ "$architecture" = "aarch64" ]; then
            pushd ~/
            git clone --depth=1 https://gitee.com/baihu433/ffmpeg-arm64.git
            rm /usr/bin/ffmpeg /usr/local/bin/ffmpeg
            mv ~/ffmpeg-arm64/ffmpeg /usr/local/bin
            ln -s /usr/local/bin/ffmpeg /usr/bin/ffmpeg
            chmod +x /usr/local/bin/ffmpeg
            rm -rf ffmpeg-arm64
            rm -rf ffmpeg-arm64
            ffmpeg
            echo -e "\033[34m 安装完成 \033[0m";
            sleep 3s
         elif [ "$architecture" = "x86_64" ]; then
            pushd ~/  
            git clone --depth=1 https://gitee.com/baihu433/ffmpeg-amd64.git
            rm /usr/bin/ffmpeg /usr/local/bin/ffmpeg
            mv ~/ffmpeg-amd64/ffmpeg /usr/local/bin
            ln -s /usr/local/bin/ffmpeg /usr/bin/ffmpeg
            chmod +x /usr/local/bin/ffmpeg
            rm -rf ffmpeg-amd64
            rm -rf ffmpeg-amd64
            ffmpeg
            echo -e "\033[34m 安装完成 \033[0m";
            sleep 3s
         else
            echo -e "\033[34m 您是干什么的呀？ \033[0m";
            exit
         fi
       fi
   fi
   
  if [[ ${baihu} = 5 ]]
   then
    #作者信息？？？
    whiptail --title "白狐≧▽≦" --msgbox "
    注意：脚本完全免费，禁止倒卖
    此脚本作者为白狐
    [QQ:1522099983[Q群:914418311]
    什么?脚本不会用?快进群殴打白狐
    项目地址:
    https://gitee.com/baihu433/Ubuntu-Yunzai
    " 17 40 7
  fi
  
  #退出
  if [[ ${baihu} = 0 ]]
  then
  exit 0
  fi

else
    exit
fi
done