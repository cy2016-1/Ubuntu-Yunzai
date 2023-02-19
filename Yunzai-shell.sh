#!/bin/bash
pushd $HOME
Ubuntuv=$(lsb_release -r | awk '{print $2}')
architecture=$(uname -m)
ver=2.1.5
echo > log.txt
if [ ! -f "/usr/local/bin/bhyz" ]; then
    wget -O /usr/local/bin/bhyz https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/Yunzai-shell.sh >> wget.log 2>&1
    {
       for ((i = 0 ; i <= 100 ; i+=1)); do
          sleep 0.01s
          echo $i
       done
    } | whiptail --gauge "检测到新版本 正在更新" 6 60 0
    if ! [ -e "/usr/local/bin/bhyz" ];then
    whiptail --title "白狐≧▽≦" --msgbox \
    "安装失败 请检查网络" \
    8 25
    exit
    fi
    chmod +x /usr/local/bin/bhyz
    rm wget.log
    bhyz
fi
version=`curl -s https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/version-bhyz.sh`
if [ "$version" != "$ver" ]; then
    rm -rf /usr/local/bin/bhyz
    wget -O /usr/local/bin/bhyz https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/Yunzai-shell.sh >> wget.log 2>&1 &
    {
       for ((i = 0 ; i <= 100 ; i+=1)); do
          sleep 0.01s
          echo $i
       done
    } | whiptail --gauge "检测到新版本 正在更新" 6 60 0
    if ! [ -e "/usr/local/bin/bhyz" ];then
    whiptail --title "白狐≧▽≦" --msgbox \
    "安装失败 请检查网络" \
    8 25
    exit
    fi
    chmod +x /usr/local/bin/bhyz
    rm wget.log
    bhyz
fi

if ! grep -i 'bhyz' /root/.bashrc  &>> /root/bh.log
then
    echo "
  1.启动Yunzai-Bot的命令为 yz
  2.查看Yunzai-Bot后台日志的命令为 yzlog
  3.重新配置Yunzai-Bot账户的命令为 yzlogin
  4.停止Yunzai-Bit后台运行的命令为 yzstop
  5.打开白狐脚本的命令为 bhyz
" > .baihu
    echo cat /root/.baihu >> .bashrc
fi

while true
do
baihu=$(whiptail \
--title "白狐≧▽≦" \
--menu "${ver}" \
17 35 7 \
"1" "管理Yunzai-Bot" \
"2" "安装Yunzai-Bot" \
"3" "管理Yunzai插件" \
"4" "附加安装" \
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
       "7" "更改主人QQ" \
       "8" "修复redis报错" \
       "9" "修复py服务器启动失败" \
       "10" "修复puppeteer Chromium 启动失败" \
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
             #随机输生成
             function baihuqq(){
             min=$1
             max=$(($2-$min+1))
             num=$(date +%s%N)
             echo $(($num%$max+$min))
             }
             imeibh=$(baihuqq 100000000000000 999999999999999)
             sed -i '15s/.*/ \"imei\": \"wcnm\",/g' $HOME/Yunzai-Bot/data/${qq}
             sed -i 15s/wcnm/${imeibh}/g $HOME/Yunzai-Bot/data/${qq}
             sed.-i 6s/.*/platform: 5/g $HOME/Yunzai-Bot/config/config/qq.yaml
             whiptail --title "白狐≧▽≦" --msgbox \
             "修复完成 [注:一次不行 多试几次 实在不行 换一个号]" \
             10 60
            else
             whiptail --title "白狐≧▽≦" --msgbox \
             "错误: ${qq} 该账号没有登录过" \
             10 60
            fi
           fi
           
           if [[ ${admin} = 7 ]];then
             qq=$(whiptail \
             --title "白狐≧▽≦" \
             --inputbox "请输入您要更改后的主人qq号" \
             10 60 \
             3>&1 1>&2 2>&3)
             
             if [[ $qq =~ ^[0-9]+$ ]]; then
             if [ $qq -gt 9999 ]; then
                 sed -i '7s/.*/'" - $qq"'/' $HOME/Yunzai-Bot/config/config/other.yaml
                 whiptail --title "白狐≧▽≦" --msgbox \
                 "主人QQ已更改为${qq}" \
                 10 60
               else
                 echo -e "\033[31m 请输入正确的QQ号！\033[0m"
                 exit
             fi
               else
                 echo -e "\033[31m 请输入正确的QQ号！\033[0m"
                 exit
             fi
           fi
           
           #redis报错
           if [[ ${admin} = 8 ]];then
           apt-get autoremove redis -y
           rm -rf /etc/redis
           apt-get install redis -y
           fi
           
           #py报错
           if [[ ${admin} = 9 ]];then
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
               sed -i "20s/.*/port: wcnm/g" config.yaml
               sed -i 20s/wcnm/$pyport/g config.yaml
               pushd $HOME
               whiptail --title "白狐≧▽≦" --msgbox \
               "修复完成 [注:一次不行 多试几次]" \
              10 60
             else
               whiptail --title "白狐≧▽≦" --msgbox \
               "错误: 您好像还没有安装py插件" \
               10 60
             fi
           fi
           
           if [[ ${admin} = 10 ]];then
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
             sed -i "13s/chromium_path: /chromium_path: /usr/bin/chromium-browser/g" $HOME/Yunzai-Bot/config/config/bot.yaml
             echo;echo -en "\033[32m 修复完成 回车返回\033[0m";read -p ""
            elif [ "$architecture" = "x86_64" ]; then
             if [ "$Ubuntuv" == "18.04" ]; then
             pushd Yunzai-Bot
             node ./node_modules/puppeteer/install.js
             elif [ "$Ubuntuv" == "22.04" ]; then
             apt install snapd -y
             snap install chromium
             sed -i "13s/chromium_path: /chromium_path: /usr/bin/chromium-browser/g" $HOME/Yunzai-Bot/config/config/bot.yaml
             elif [ "$Ubuntuv" == "22.10" ]; then
             apt install snapd -y
             snap install chromium
             sed -i "13s/chromium_path: /chromium_path: /usr/bin/chromium-browser/g" $HOME/Yunzai-Bot/config/config/bot.yaml
             else
             pushd Yunzai-Bot
             node ./node_modules/puppeteer/install.js
             fi
             echo;echo -en "\033[32m 修复完成 回车返回\033[0m";read -p ""
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
        bash <(curl -sL https://deb.nodesource.com/setup_16.x)
        elif [ "$Ubuntuv" == "22.04" ]; then
        bash <(curl -sL https://deb.nodesource.com/setup_19.x)
        elif [ "$Ubuntuv" == "22.10" ]; then
        bash <(curl -sL https://deb.nodesource.com/setup_19.x)
        else
        bash <(curl -sL https://deb.nodesource.com/setup_16.x)
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
        注意:如果使用密码登录
        则密码默认不显示" \
        15 60);then
        pushd Yunzai-Bot
        node app
        pnpm -v
        if ! [ $? -ne 0 ];then
          echo -e "\033[31m 启动失败 请截图并发给白狐\033[0m";
          exit
        fi
        echo
        exit
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
       "1" "安装python3.10和pip和poetry" \
       "2" "安装ffmpeg" \
       3>&1 1>&2 2>&3)
       ctmd=$?


      if [[ ${installing} = 1 ]]
         then
         pushd $HOME
        if [ "$Ubuntuv" == "18.04" ]; then
          18pythonpippoetry
        elif [ "$Ubuntuv" == "22.04" ]; then
          22pythonpippoetry
        elif [ "$Ubuntuv"= "22.10" ]; then
          22pythonpippoetry
        else
          18pythonpippoetry
        fi
      fi
      
function 18pythonpippoetry()
{
apt-get install git gcc g++ make cmake build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl -y
git clone --depth=1 https://gitee.com/baihu433/python3.10.8.git
mv python3.10.8/Python-3.10.8.tar.xz ~/
rm -rf python3.10.8
rm -rf python3.10.8 >> log.txt 2>&1 &
echo -e "\033[34m 解压源码 \033[0m";
tar xvJf Python-3.10.8.tar.xz
rm -rf Python-3.10.8.tar.xz
rm -rf Python-3.10.8.tar.xz
pushd Python-3.10.8
rm -rf /usr/local/python3.10 > log.txt 2>&1 &
./configure --prefix=/usr/local/python3.10/
make -j $(cat /proc/cpuinfo | grep "processor" | wc -l)
make install
pushd ~/
echo PATH=/usr/local/python3.10/bin:$PATH >> .bashrc
rm /usr/bin/pip /usr/bin/poetry >> log.txt 2>&1 &
rm -rf Python-3.10.8
rm -rf python-3.10.8 >> log.txt 2>&1 &
ln -s /usr/local/python3/bin/python3 /usr/bin/python
ln -s /usr/local/python3/bin/pip3 /usr/bin/pip
pip config set global.index-url https://pypi.mirrors.ustc.edu.cn/simple/
python -m pip install --upgrade pip
pip --version
curl -sSL https://install.python-poetry.org | python3.10 -
ln -s ~/.local/bin/poetry /usr/bin/poetry
poetry --version
echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
}

function 22pythonpippoetry()
{
apt install python3.10
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py 
python3.10 get-pip.py
if [ -x "$(command -v pip)" ];then
rm get-pip.py
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3.10 get-pip.py
fi
pip config set global.index-url https://pypi.mirrors.ustc.edu.cn/simple/
curl -sSL https://install.python-poetry.org | python3.10 -
ln -s ~/.local/bin/poetry /usr/bin/poetry
if ! [ -x "$(command -v poetry)" ];then
rm ~/.local/bin/poetry
curl -sSL https://install.python-poetry.org | python3.10 -
ln -s ~/.local/bin/poetry /usr/bin/poetry
fi
echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
}
      
       if [[ ${installing} = 2 ]]
         then
         if [ "$architecture" = "aarch64" ]; then
            pushd ~/
            git clone --depth=1 https://gitee.com/baihu433/ffmpeg-arm64.git
            rm /usr/bin/ffmpeg /usr/local/bin/ffmpeg
            mv ~/ffmpeg-arm64/ffmpeg /usr/local/bin
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
    [QQ:1522099983[Q群:705226976]
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