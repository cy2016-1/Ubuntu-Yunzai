#!/bin/bash
ver=3.0.0
cd $HOME
if ! grep -q "cat $HOME/.baihu" $HOME/.bashrc
then
    echo "
  1.启动Yunzai-Bot的命令为 yz
  2.查看Yunzai-Bot后台日志的命令为 yzlog
  3.重新配置Yunzai-Bot账户的命令为 yzlogin
  4.停止Yunzai-Bit后台运行的命令为 yzstop
  5.打开白狐脚本的命令为 bhyz
  6.注意:脚本完全免费,如果你是购买所得,请退款
  7.脚本有任何问题都可以加入QQ群:705226976
" > .baihu
   echo cat $HOME/.baihu >> .bashrc
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
"6" "更新脚本" \
"0" "退出" \
3>&1 1>&2 2>&3)

feedback=$?
if [ $feedback = 0 ];then
  #调用管理脚本
  if [[ ${baihu} = 1 ]]
   then
     if [ -d "$HOME/Yunzai-Bot" ];then
       admin=$(whiptail \
       --title "白狐≧▽≦" \
       --menu "${ver}" \
       17 40 10 \
       "1" "启动Yunzai-Bot" \
       "2" "停止Yunzai-Bot" \
       "3" "后台启动Yunzai-Bot" \
       "4" "查看后台Yunzai-Bot日志" \
       "5" "重置Yunzai-Bot账号" \
       "6" "修改登录设备" \
       "7" "修复版本过低" \
       "8" "修改主人QQ" \
       "9" "修复Redis服务器错误" \
       "10" "py服务器依赖和端口报错" \
       "11" "修复puppeteer Chromium 启动失败" \
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
              pnpm run stop
           fi
           
           if [[ ${admin} = 3 ]];then
             pushd ~/Yunzai-Bot
             redis-server --save 900 1 --save 300 10 --daemonize yes
             pnpm run start
           fi
             
           if [[ ${admin} = 4 ]];then
              pushd ~/Yunzai-Bot
              pnpm run log
           fi
           
           if [[ ${admin} = 5 ]];then
           pushd ~/Yunzai-Bot
           pnpm run login
           fi
           
           if [[ ${admin} = 6 ]];then
           pushd ~/Yunzai-Bot
           equipment=$(whiptail \
           --title "白狐≧▽≦" \
           --menu "请选择登录设备" \
           17 35 7 \
           "1" "安卓手机" \
           "2" "aPad" \
           "3" "安卓手表" \
           "4" "MacOS" \
           "5" "iPad[推荐]" \
           3>&1 1>&2 2>&3 )
           new="platform: ${equipment}"
           file="$HOME/Yunzai-Bot/config/config/qq.yaml"
           old_equipment="platform: [0-5]"
           new_equipment="platform: ${equipment}"
           sed -i "s/$old_equipment/$new_equipment/g" $file
           rm $HOME/Yunzai-Bot/data/device.json
           fi
        
           #报错修复
          if [[ ${admin} = 7 ]];then
            qq=$(whiptail \
            --title "白狐≧▽≦" \
            --inputbox "请输入您的机器人qq号 输完后回车" \
            10 60 \
            3>&1 1>&2 2>&3)
            
            if [ -e $HOME/Yunzai-Bot/data/${qq}_token ]
              then
                rm -rf $HOME/Yunzai-Bot/data/${qq}
                rm $HOME/Yunzai-Bot/data/device.json
                rm $HOME/Yunzai-Bot/data/${qq}_token
              else
                whiptail --title "白狐≧▽≦" --msgbox "
               文件不存在 请确认${qq}登陆过
               " 10 43
            fi
          fi
           
           if [[ ${admin} = 8 ]];then
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
           if [[ ${admin} = 9 ]];then
           apt install gcc g++ pkg-config make -y
           wget -O redis.tar.gz http://download.redis.io/releases/redis-7.0.9.tar.gz
           tar -zxvf redis.tar.gz
           pushd redis-7.0.9
           make -j$(cat /proc/cpuinfo | grep "processor" | wc -l) PREFIX=/usr/local/redis install
           ln -s /usr/local/redis/bin/redis-server /usr/bin/redis-server
           fi
           
           #py报错
           if [[ ${admin} = 10 ]];then
             if [ -d $HOME/Yunzai-Bot/plugins/py-plugin ];then
               if ! [ -x "$(command -v python3.10)" ];then
               echo -e "\033[31m 小子 你还没有安装python呢\n 快到附加安装 安装python3.10吧\033[0m";
               exit
               fi
               if ! [ -x "$(command -v pip)" ];then
               echo -e "\033[31m 小子 你还没有安装pip呢\n 快到附加安装 安装pip吧\033[0m";
               exit
               fi
               if ! [ -x "$(command -v poetry)" ];then
               echo -e "\033[31m 小子 你还没有安装poetry呢\n 快到附加安装 安装poetry吧\033[0m";
               exit
               fi
               pushd  $HOME/Yunzai-Bot/plugins/py-plugin
               poetry install 
               poetry install
               function py(){
               min=$1
               max=$(($2-$min+1))
               num=$(date +%s%N)
               echo $(($num%$max+$min))
               }
               pyport=$(py 40000 60000)
               sed -i "15s/.*/port: ${pyport}/g" $HOME/Yunzai-Bot/plugins/py-plugin/config.yaml
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
           
           if [[ ${admin} = 11 ]];then
           Ubuntuv=$(lsb_release -r | awk '{print $2}')
           architecture=$(uname -m)
            if [ "$architecture" = "aarch64" ]; then
             echo -e "\033[34m 调用甘雨大佬的浏览器修复 感谢 \033[0m";
             pushd $HOME
             apt-get autoremove chromium-browser -y
             git clone --depth=1 https://gitee.com/Ganyu256/chromium
             pushd chromium
             bash install.sh
             pushd $HOME
             rm -rf chromium
             rm -rf chromium
             pushd Yunzai-Bot
             pnpm install -P
             pushd $HOME
             sed -i "13s/.*/chromium_path: \/usr\/bin\/chromium-browser/g" $HOME/Yunzai-Bot/config/config/bot.yaml
             echo;echo -en "\033[32m 修复完成 回车返回\033[0m";read -p ""
            elif [ "$architecture" = "armv8l" ]; then
             echo -e "\033[34m 调用甘雨大佬的浏览器修复 感谢 \033[0m";
             pushd $HOME
             apt-get autoremove chromium-browser -y
             git clone --depth=1 https://gitee.com/Ganyu256/chromium
             pushd chromium
             bash install.sh
             pushd $HOME
             rm -rf chromium
             rm -rf chromium
             pushd Yunzai-Bot
             pnpm install -P
             pushd $HOME
             sed -i "13s/.*/chromium_path: \/usr\/bin\/chromium-browser/g" $HOME/Yunzai-Bot/config/config/bot.yaml
             echo;echo -en "\033[32m 修复完成 回车返回\033[0m";read -p ""
            elif [ "$architecture" = "x86_64" ]; then
             if [ "$Ubuntuv" == "18.04" ]; then
             pushd Yunzai-Bot
             node ./node_modules/puppeteer/install.js
             pnpm install -P
             elif [ "$Ubuntuv" == "22.04" ]; then
             apt install snapd -y
             snap install chromium
             sed -i "13s/.*/chromium_path: \/usr\/bin\/chromium-browser/g" $HOME/Yunzai-Bot/config/config/bot.yaml
             elif [ "$Ubuntuv" == "22.10" ]; then
             apt install snapd -y
             snap install chromium
             sed -i "13s/.*/chromium_path: \/usr\/bin\/chromium-browser/g" $HOME/Yunzai-Bot/config/config/bot.yaml
             else
             pushd Yunzai-Bot
             node ./node_modules/puppeteer/install.js
             sed -i "13s/.*/chromium_path: \/usr\/bin\/chromium-browser/g" $HOME/Yunzai-Bot/config/config/bot.yaml
             fi
             echo;echo -en "\033[32m 修复完成 回车返回\033[0m";read -p ""
            else
             echo -en "\033[31m 错误: 不支持的框架 \033[0m";
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
    if [ -d "$HOME/Yunzai-Bot" ];then
       whiptail --title "白狐≧▽≦" --msgbox "
       您已安装云崽 禁止套娃
       " 10 43
     else
       # 更新软件源和软件
        echo -e "\033[34m 更新软件源 \033[0m";
        apt update -y
        echo -e "\033[34m 更新完成 \033[0m";
        echo

        # 安装nodejs
        Ubuntuv=$(lsb_release -r | awk '{print $2}')
        until npm -v
        do
        if [ "$Ubuntuv" == "18.04" ]; then
          bash <(curl -sL https://deb.nodesource.com/setup_16.x)
        elif [ "$Ubuntuv" == "22.04" ]; then
          bash <(curl -sL https://deb.nodesource.com/setup_18.x)
        elif [ "$Ubuntuv" == "22.10" ]; then
          bash <(curl -sL https://deb.nodesource.com/setup_18.x)
        else
          bash <(curl -sL https://deb.nodesource.com/setup_16.x)
        fi
        apt remove nodejs -y
        apt autoremove
        apt update -y
        apt install -y nodejs
        done
        
        #安装pnpm
        echo -e "\033[34m 开始安装pnpm  \033[0m";
        npm config set registry http://registry.npm.taobao.org/
        npm install -g npm
        npm install -g pnpm
        pnpm config set registry http://registry.npm.taobao.org/
        pnpm install -g pnpm
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
        git clone --depth=1 https://gitee.com/yoimiya-kokomi/Yunzai-Bot
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
        #写入自动命令
        if [ -e "/usr/bin/yz" ]
           then
           echo -e "\033[34m 检测到已写入 \033[34m";
           echo "退出"
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
      if [ -d "$HOME/Yunzai-Bot" ];then
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
       "3" "安装ftp服务器" \
       3>&1 1>&2 2>&3)
       ctmd=$?

function 18pythonpippoetry()
{
if [ -x "$(command -v python3.10)" ];then
apt purge python3.10 -y
apt autoremove -y
fi
apt install software-properties-common -y
echo -e "\n" | add-apt-repository ppa:deadsnakes/ppa
apt install python3.10-full python3.10-venv
until apt install python3.10-full python3.10-venv
do
apt install software-properties-common -y
echo -e "\n" | add-apt-repository ppa:deadsnakes/ppa
apt install python3.10-full python3.10-venv
done
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
if ! [ -e get-pip.py ];then
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
fi
python3.10 get-pip.py
rm get-pip.py
echo -e "\033[32m 正在为pip更换默认源\033[0m"
python3.10 -m pip config set global.index-url https://pypi.mirrors.ustc.edu.cn/simple/
python3.10 -m pip config set global.index-url https://pypi.mirrors.ustc.edu.cn/simple/
python3.10 -m pip install --upgrade pip
echo -e "\033[32m poetry安装较久 请耐心等待 \033[0m"
python3.10 -m pip install poetry
if ! [ -x "$(command -v python3.10)" ];then
echo -e "\033[31mPython3.10安装失败\033[0m"
exit
fi
if ! [ -x "$(command -v pip)" ];then
echo -e "\033[31mpip安装失败\033[0m"
exit
fi
if ! [ -x "$(command -v poetry)" ];then
echo -e "\033[31mpoetry安装失败\033[0m"
exit
fi
echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
}

function 22pythonpippoetry()
{
apt install python3.10 python3-pip python3.10-venv -y
echo -e "\033[32m 正在更新pip\033[0m"
python3.10 -m pip install -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade pip
echo -e "\033[32m 正在为pip更换默认源\033[0m"
python3.10 -m pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
python3.10 -m pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
python3.10 -m pip install --upgrade pip
echo -e "\033[32m poetry安装较久 请耐心等待 \033[0m"
python3.10 -m pip install poetry
if ! [ -x "$(command -v python3.10)" ];then
echo -e "\033[31mPython3.10安装失败\033[0m"
exit
fi
if ! [ -x "$(command -v pip)" ];then
echo -e "\033[31mpip安装失败\033[0m"
exit
fi
if ! [ -x "$(command -v poetry)" ];then
echo -e "\033[31mpoetry安装失败\033[0m"
exit
fi
echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
}

      if [[ ${installing} = 1 ]]
         then
         pushd $HOME
        Ubuntuv=$(lsb_release -r | awk '{print $2}')
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
      
       if [[ ${installing} = 2 ]]
         then
         architecture=$(uname -m)
         if [ "$architecture" = "aarch64" ]; then
            pushd ~/
            git clone --depth=1 https://gitee.com/baihu433/ffmpeg-arm64.git
            rm /usr/bin/ffmpeg /usr/local/bin/ffmpeg &>/dev/null
            mv ffmpeg-arm64/ffmpeg /usr/local/bin/ffmpeg
            chmod +x /usr/local/bin/ffmpeg
            rm -rf ffmpeg-arm64 &>/dev/null
            rm -rf ffmpeg-arm64
            ffmpeg
            echo -en "\033[34m 安装完成 回车返回\033[0m";read
         elif [ "$architecture" = "armv8l" ]; then
            pushd ~/
            git clone --depth=1 https://gitee.com/baihu433/ffmpeg-arm64.git
            rm /usr/bin/ffmpeg /usr/local/bin/ffmpeg &>/dev/null
            mv ffmpeg-arm64/ffmpeg /usr/local/bin/ffmpeg
            chmod +x /usr/local/bin/ffmpeg
            rm -rf ffmpeg-arm64 &>/dev/null
            rm -rf ffmpeg-arm64
            ffmpeg
            echo -en "\033[34m 安装完成 回车返回 \033[0m";read
         elif [ "$architecture" = "x86_64" ]; then
            pushd ~/  
            git clone --depth=1 https://gitee.com/baihu433/ffmpeg-amd64.git
            rm /usr/bin/ffmpeg /usr/local/bin/ffmpeg &>/dev/null
            mv ffmpeg-amd64/ffmpeg /usr/local/bin/ffmpeg
            chmod +x /usr/local/bin/ffmpeg
            rm -rf ffmpeg-amd64 &>/dev/null
            rm -rf ffmpeg-amd64
            ffmpeg
            echo -en "\033[34m 安装完成 回车返回 \033[0m";read
         else
            echo -en "\033[34m 您是干什么的呀？ \033[0m";read
         fi
       fi
    
      if [[ ${installing} = 3 ]]
        then
        echo;echo -en "\033[36m 没写完\033[0m";read -p ""
function ftpserver(){
          #apt install vsftpd openssh-server -y
          apt install vsftpd -y
          file=/etc/vsftpd.conf
          sed -i "s/#anonymous_enable=YES/anonymous_enable=NO/g" ${file} &>/dev/null
          sed -i "s/#local_enable=NO/local_enable=YES/g" ${file} &>/dev/null
          sed -i "s/#write_enable=NO/write_enable=YES/g" ${file} &>/dev/null
          sed -i "s/anonymous_enable=YES/anonymous_enable=NO/g" ${file} &>/dev/null
          sed -i "s/local_enable=NO/local_enable=YES/g" ${file} &>/dev/null
          sed -i "s/write_enable=NO/write_enable=YES/g" ${file} &>/dev/null
          sed -i "s/#anonymous_enable=NO/anonymous_enable=NO/g" ${file} &>/dev/null
          sed -i "s/#local_enable=YES/local_enable=YES/g" ${file} &>/dev/null
          sed -i "s/#write_enable=YES/write_enable=YES/g" ${file} &>/dev/null
          sed -i "s/listen_ipv6=YES/listen_ipv6=NO/g" ${file} &>/dev/null
          sed -i "s/listen=NO/listen=YES/g" ${file} &>/dev/null
          sed -i "s/#listen_ipv6=YES/listen_ipv6=NO/g" ${file} &>/dev/null
          sed -i "s/#listen=NO/listen=YES/g" ${file} &>/dev/null
          ftpuser=$(whiptail \
          --title "白狐≧▽≦" \
          --inputbox "请输入您将要设置的ftp用户名 请勿设置为ftp" \
          10 60 \
          3>&1 1>&2 2>&3)
          useradd -d /home/ftp -M ${ftpuser}
          echo -e "\033[34m 请输入您将要设置的的ftp密码 \033[0m";
          passwd ${ftpuser}
          pushd /home
          mkdir ftp
          chown ${ftpuser} ftp
          chgrp ${ftpuser} ftp 
          sed -i "45i\ftpuser    ALL=(ALL:ALL) ALL " /etc/sudoers
          sed -i s/ftpuser/${ftpuser}/g /etc/sudoers
          ln -s /root /home/ftp/root
}
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
  
  if [[ ${baihu} = 6 ]];then
ver=2.5.0
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
    Aword=`curl -s https://api.vvhan.com/api/ian`
    whiptail --title "白狐≧▽≦" --msgbox \
    "${Aword}" \
    10 50
    chmod +x /usr/local/bin/bhyz
    rm wget.log
    bhyz
fi
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