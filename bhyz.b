#!/bin/bash
pushd ${home}
#判断系统是否为Ubuntu
lsb_release -i | grep -q "Ubuntu"
if [ $? -eq 0 ]; then
  echo
else
  echo -e "\033[44m 非ubuntu系统 停止运行! \033[0m";
  exit
fi
#检测是否为root用户
if [ "$(whoami)" == "root" ]; then
    echo
else
    echo -e "\033[44m 非root用户 请登录root用户后使用该脚本 \033[0m";
fi
#检测curl安装状态
if ! [ -x "$(command -v curl)" ]
    then
    echo -e "\033[44m 未检测到未安装curl 开始安装 \033[0m";
    apt update
    apt install curl -y
fi
#检测wget安装状态
if ! [ -x "$(command -v wget)" ]
    then
    echo -e "\033[44m 未检测到未安装wget 开始安装 \033[0m";
    apt update
    apt install wget -y
fi
#检测whiptail安装状态
if ! [ -x "$(command -v whiptail)" ]
    then
    echo -e "\033[44m 未检测到未安装whiptail 开始安装 \033[0m";
    apt update
    apt install whiptail -y
fi

while true
do
baihu=$(whiptail \
--title "白狐≧▽≦" \
--menu "0.1" \
20 45 10 \
"1" "管理Yunzai-Bot" \
"2" "安装Yunzai-Bot" \
"3" "安装Yunzai插件" \
"4" "打开附加安装菜单" \
"5" "报错修复" \
"6" "帮助" \
"0" "退出" \
3>&1 1>&2 2>&3 )
ctmd=$?

if [[ ${ctmd} = 0 ]]
then
  #调用管理脚本
  if [[ ${baihu} = 1 ]]
   then
    if [ ! -d "~/Yunzai-Bot" ]
     then
       admin=$(whiptail \
       --title "白狐≧▽≦" \
       --menu "0.1" \
       20 45 10 \
       "1" "启动Yunzai-Bot" \
       "2" "停止Yunzai-Bot" \
       "3" "查看Yunzai-Bot日志" \
       "4" "后台启动Yunzai-Bot" \
       "5" "报错修复" \
       "6" "打开安装脚本" \
       "0" "退出" \
       3>&1 1>&2 2>&3 )
       ctmd=$?
       
       if [[ ${ctmd} = 0 ]]
         then
           #启动
           if [[ ${admin} = 1 ]];then
              echo -e "\033[44m 正在启动Yunzai-Bot \033[0m";
              pushd ~/Yunzai-Bot
              redis-server --daemonize yes --save 900 1 --save 300 10
              node app
           fi
           
           #停止
           if [[ ${admin} = 2 ]];then
              echo -e "\033[44m 正在停止Yunzai-Bot \033[0m";
              pushd ~/Yunzai-Bot
              pnpm stop
           fi
           
           #日志
           if [[ ${admin} = 3 ]];then
              echo -e "\033[44m 正在打开Yunzai-Bot日志 \033[0m";
              pushd ~/Yunzai-Bot
              pnpm run log
           fi
           
           #后台启动
           if [[ ${admin} = 4 ]];then
           echo -e "\033[44m 正在后台启动Yunzai-Bot \033[0m";
           pushd ~/Yunzai-Bot
           node app &
           fi
           
           #报错修复
           if [[ ${admin} = 5 ]];then
           bash <(curl -sL https://gitee.com/baihu433/raw/)
           fi
           
           #返回安装脚本
           if [[ ${admin} = 6 ]];then
           bhyz
           fi               
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
    if [ -e "~/Yunzai-Bot" ];then
			whiptail --title "白狐≧▽≦" --msgbox "
       已安装云崽 禁止重复安装
       " 10 43
			exit 0
      else
        # 更新软件源和软件
        echo -e "\033[44m 更新软件 \033[0m";
        apt update
        apt upgrade -y
        echo -e "\033[44m 更新完成 \033[0m";
        echo

        # 安装nodejs
        echo '安装nodejs';
        bash <(curl -sL https://deb.nodesource.com/setup_16.x)
        apt-get install -y nodejs
        npm -v
        if [ $? -ne 0 ]
        then
        echo -e "\033[44m nodejs安装失败 请检查网络 \033[0m";
          exit
        else
          echo -e "\033[44m nodejs安装成功 \033[0m";
        fi
        echo        
        
        #安装pnpm
        echo -e "\033[44m 开始安装pnpm  \033[0m";
        npm config set registry http://registry.npm.taobao.org/
        npm install -g npm
        npm install -g pnpm
        pnpm config set registry http://registry.npm.taobao.org/
        pnpm -v
        if [ $? -ne 0 ]
        then
        echo -e "\033[44m 安装pnpm失败 请检查网络 \033[0m";
          exit
        else
          echo -e "\033[44m 安装pnpm成功 \033[0m";
        fi
        echo
        
        # 安装并运行redis
        echo -e "\033[44m 安装redis \033[0m";
        apt-get install redis -y
        redis-server --daemonize yes
        echo '安装redis完成';
        echo

        # 安装chromium
        echo -e "\033[44m 安装chromium \033[0m";
        apt install chromium-browser -y
        echo '安装chromium完成';
        echo
        
        #安装中文字体
        echo -e "\033[44m 安装中文字体 \033[0m";
        apt-get install -y fonts-wqy-microhei fonts-wqy-zenhei

        # 克隆项目
        echo -e "\033[44m 正在克隆Yunzai-Bot \033[0m";
        pushd ~/
          git clone --depth=1 https://gitee.com/Le-niao/Yunzai-Bot.git
          if [ ! -d "~/Yunzai-Bot" ]
            then
              echo -e "\033[44m 克隆成功 \033[0m";
            else
              echo -e "\033[44m 克隆失败 请检查网络 \033[0m";
              exit 0
          fi
        echo
        
        #安装Yunzai依赖
        echo -e "\033[34m 安装依赖 \033[44m";
        pushd ~/Yunzai-Bot
        pnpm install -P && pnpm install -P
        pnpm ls oicq
        if [ $? -ne 0 ]
          then
          echo -e "\033[34m 依赖安装失败 请检查网络 \033[44m";
          exit
        else
          echo -e "\033[34m 依赖安装成功 \033[44m";
        fi
        pushd ~/
        echo
        
        #写入自动命令
        if [ ! -e "/usr/bin/yz" ]
           then
           echo -e "\033[34m 检测到已写入 \033[44m";
           echo "退出"
           exit 
        else
        echo '正在将启动写入启动命令'
        echo echo 正在启动Yunzai-Bot > /usr/bin/yz 
        sed -i -e '1a echo 白狐制作 禁止倒卖' /usr/bin/yz 
        sed -i -e '2a redis-server --daemonize yes --save 900 1 --save 300 10 && pushd ~/Yunzai-Bot && node app' /usr/bin/yz 
        chmod 777 /usr/bin/yz
        echo echo 正在打开Yunzai-Bot后台日志 > /usr/bin/yzlog
        sed -i -e '1a echo 白狐制作 禁止倒卖' /usr/bin/yzlog 
        sed -i -e '2a pushd ~/Yunzai-Bot && pnpm run log' /usr/bin/yzlog 
        chmod 777 /usr/bin/yzlog 
        echo echo 正在打开Yunzai-Bot登录配置 > /usr/bin/yzlogin 
        sed -i -e '1a echo 白狐制作 禁止倒卖' /usr/bin/yzlogin  
        sed -i -e '2a pushd ~/Yunzai-Bot && pnpm run login' /usr/bin/yzlogin
        chmod 777 /usr/bin/yzlogin 
        echo echo 正在停止Yunzai-Bot后台运行 > /usr/bin/yzstop
        sed -i -e '1a echo 白狐制作 禁止倒卖' /usr/bin/yzstop
        sed -i -e '2a pushd ~/Yunzai-Bot && pnpm stop' /usr/bin/yzstop
        chmod 777 /usr/bin/yzstop
        pushd ~/
        echo
        fi
    fi
  fi
  
  #调用插件脚本
  if [[ ${baihu} = 4 ]]
   then
    if [ ! -d "~/Yunzai-Bot" ]
     then
       bash <(curl -sL https://gitee.com/baihu433/raw/)
     else
       whiptail --title "白狐≧▽≦" --msgbox "
       您好像还没有未安装云崽呢，快去安装吧!
       " 10 43
     fi
   fi
  
  #调用附加安装脚本
  if [[ ${baihu} = 5 ]]
   then
     if [ ! -d "~/Yunzai-Bot" ]
       then
       installing=$(whiptail \
       --title "白狐≧▽≦" \
       --menu "0.1" \
       20 45 10 \
       "1" "安装python3.10.8和pip和poetry" \
       "2" "安装ffmpeg" \
       3>&1 1>&2 2>&3 )
       ctmd=$?
     
       if [[ ${ctmd} = 0 ]]
       then
         if [[ ${installing} = 1 ]]
         then
         pushd ~/
         echo -e "\033[44m 开始安装python3.10.8 pip poetry \033[0m";
         #安装python3.10.8依赖
         echo -e "\033[44m 安装依赖包 \033[0m";
         apt-get install git gcc g++ make cmake build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl -y
         git clone --depth=1 https://gitee.com/baihu433/python3.10.8.git
         mv python3.10.8/Python-3.10.8.tar.xz ~/
         rm -rf python3.10.8
         rm -rf python3.10.8
         #解压Python-3.10.8.tar.xz
         echo -e "\033[44m 解压源码 \033[0m";
         tar xvJf Python-3.10.8.tar.xz
         rm -rf Python-3.10.8.tar.xz
         rm -rf Python-3.10.8.tar.xz
         #进入Python-3.10.8源码文件夹
         pushd Python-3.10.8
         # 开始编译python3.10.8源码
         echo -e "\033[44m 编译python3.10.8源码 \033[0m";
         ./configure --prefix=/usr/local/python3/
         echo '编译完成'
         # 开始安装python3.10.8
         echo -e "\033[44m 安装python3.10.8 \033[0m";
         make && make install
         echo '安装完成'
         # 添加环境变量
         echo '添加环境变量'
         PATH=/usr/local/python3/bin:$PATH
         #更改python2.7名称
         mv /usr/bin/python /usr/bin/python.bak
         mv /usr/bin/pip /usr/bin/pip.bak
         mv /usr/bin/poetry /usr/bin/poetry.bak
         #删除源码文件
         rm -rf Python-3.10.8
         rm -rf python-3.10.8
         #添加软链接
         ln -s /usr/local/python3/bin/python3 /usr/bin/python
         ln -s /usr/local/python3/bin/pip3 /usr/bin/pip
         #更换pip默认下载源，来提升下载速度
         pip config set global.index-url https://pypi.mirrors.ustc.edu.cn/simple/
         python -m pip install --upgrade pip
         pip --version
         echo -e "\033[34m 安装poetry \033[44m";
         curl -sSL https://install.python-poetry.org | python -
         #添加软链接
         ln -s ~/.local/bin/poetry /usr/bin/poetry
         poetry --version
         echo
         fi
       fi
       
       if [[ ${installing} = 2 ]]
         then
         if [ "$architecture" = "aarch64" ]; then
            pushd ~/
            git clone --depth=1 https://gitee.com/baihu433/ffmpeg-arm64.git
            mv /usr/bin/ffmpeg /usr/bin/ffmpeg.bak
            mv ~/ffmpeg-arm64/ffmpeg /usr/local/bin
            ln -s /usr/local/bin/ffmpeg /usr/bin/ffmpeg
            chmod +x /usr/local/bin/ffmpeg
            rm -rf ffmpeg-arm64
            rm -rf ffmpeg-arm64
            ffmpeg
            echo -e "\033[34m 安装完成 \033[44m";
            sleep 3s
         elif [ "$architecture" = "x86_64" ]; then
            pushd ~/  
            git clone --depth=1 https://gitee.com/baihu433/ffmpeg-amd64.git
            mv /usr/bin/ffmpeg /usr/bin/ffmpeg.bak
            mv ~/ffmpeg-amd64/ffmpeg /usr/local/bin
            ln -s /usr/local/bin/ffmpeg /usr/bin/ffmpeg
            chmod +x /usr/local/bin/ffmpeg
            rm -rf ffmpeg-amd64
            rm -rf ffmpeg-amd64
            ffmpeg
            echo -e "\033[34m 安装完成 \033[44m";
            sleep 3s
         else
            echo -e "\033[34m 您是干什么的呀？ \033[44m";
            exit
         fi 
       fi             
        else
            whiptail --title "白狐≧▽≦" --msgbox "
            您好像还没有未安装云崽呢，快去安装吧!
            " 10 43
     fi
   fi
   
  if [[ ${baihu} = 6 ]]
   then
    #作者信息？？？
    whiptail --title "白狐≧▽≦" --msgbox "
    注意：脚本完全免费，禁止倒卖
    此脚本作者为白狐
    [QQ:1522099983[Q群:914418311]
    什么?脚本不会用?快进群殴打白狐
    项目地址:
    https://gitee.com/baihu433/Ubuntu-Yunzai
    " 15 60
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