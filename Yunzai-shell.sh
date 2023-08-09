#!/bin/bash
#if ping -c 1 baidu.com &> /dev/null
#then
#   Git=gitee
#elif ping -c 1 google.com &> /dev/null
#then
#   Git=github
#fi
export red="\033[31m"
export green="\033[32m"
export yellow="\033[33m"
export blue="\033[34m"
export purple="\033[35m"
export cyan="\033[36m"
export white="\033[37m"
export background="\033[0m"
if [ -d /usr/local/node/bin ];then
export PATH=$PATH:/usr/local/node/bin
if [ ! -d $HOME/.local/share/pnpm ];then
    mkdir -p $HOME/.local/share/pnpm
fi
export PATH=$PATH:/root/.local/share/pnpm
export PNPM_HOME=/root/.local/share/pnpm
fi
function help(){
echo -e ${green}=============================${background}
echo -e ${cyan} bhyz"      | "${blue}打开白狐脚本${background}
echo -e ${cyan} help"      | "${blue}获取快捷命令${background}
echo -e ${cyan} QS"        | "${blue}管理签名服务器${background}
echo -e ${cyan} YZ/MZ/TZ"  | "${green}[大写]${blue}选择您要控制的对象${background}
echo -e ${cyan} yz/mz/yz"  | "${green}[小写]${blue}进入相应的bot文件夹${background}
echo -e ${cyan} n"         | "${blue}前台启动${background}
echo -e ${cyan} start"     | "${blue}后台启动${background}
echo -e ${cyan} log"       | "${blue}打开日志${background}
echo -e ${cyan} stop"      | "${blue}停止运行${background}
echo -e ${cyan} login"     | "${blue}重新登陆${background}
echo -e ${cyan} install"   | "${green}[依赖名] ${blue}安装依赖${background}
echo -e ${cyan} qsign"     | "${green}[API链接] ${blue}填写签名服务器API${background}
echo -e ${green}=============================${background}
echo -e ${yellow} 脚本完全免费 如果你是购买所得 请给差评 打击倒卖 从你我做起${background}
echo -e ${green} QQ群:${cyan}狐狸窝:705226976${background}
echo -e ${green}=============================${background}
}
case "$1" in
QS)
bash <(curl https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/QSignServer2.0.sh)
exit
;;
YZ)
cd $HOME/Yunzai-Bot
;;
MZ)
cd $HOME/Miao-Yunzai
;;
TZ)
cd $HOME/TRSS-Yunzai
;;
yz)
cd $HOME/Yunzai-Bot && exec bash -i
exit
;;
mz)
cd  $HOME/Miao-Yunzai && exec bash -i
exit
;;
tz)
cd $HOME/TRSS-Yunzai && exec bash -i
exit
;;
help)
help
exit
;;
unup)
up=false
;;
esac

case "$2" in
n)
node app
exit
;;
start)
pnpm run start
exit
;;
stop)
pnpm run stop
exit
;;
log)
pnpm run log
exit
;;
login)
pnpm run login
exit
;;
install)
pnpm install "$3" -w
exit
;;
up)
case $3 in
  bot)
  git pull
  exit
  ;;
  pkg)
  echo "Y" | pnpm install
  echo "Y" | pnpm install puppeteer@19.0.0 icqq@latest -w
  exit
  ;;
esac
;;
qsign)
sed -i '/sign_api_addr/d' config/config/bot.yaml
sed -i "\$a\sign_api_addr: $3" config/config/bot.yaml
API=$(grep sign_api_addr config/config/bot.yaml)
API=$(echo ${API} | sed "s/sign_api_addr//g")
echo -e ${cyan}您的API链接已修改为 ${green}${API}${background}
exit
;;
esac
ver=5.9.1
cd $HOME
if [ ! "${up}" = "false" ];then
version=`curl -s https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/version-bhyz.sh`
if [ "$version" != "$ver" ]; then
    rm /usr/local/bin/bhyz
    a=1
    function install(){
    curl -o bhyz https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/Yunzai-shell.sh
    mv bhyz /usr/local/bin/bhyz
    chmod +x /usr/local/bin/bhyz
    }
    install > /dev/null 2>&1 &
    {
       until command -v bhyz
        do
          a=$(($a+1))
          sleep 0.05s
          echo ${a}
        done
    } | whiptail --gauge "检测到新版本 正在更新" 6 60 0
    #if ! [ -x "/usr/local/bin/bhyz" ];then
    #whiptail --title "白狐≧▽≦" --msgbox \
    #"安装失败 请检查网络" \
    # 8 25
    #exit
    # fi
    update_log=$(curl -sL https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/update.log)
    echo -e ${update_log}
    echo
    echo -en ${yellow}回车继续${background};read
    if [ -x "/usr/local/bin/bhyz" ];then
    whiptail --title "白狐≧▽≦" --msgbox \
    "安装成功 祝您使用愉快!" \
    8 25
    fi
    bhyz
    exit
fi
fi
#########################################################
function centos(){
yum install -y chromium
yum install -y redis
yum install -y wqy*
}
#########################################################
function install(){
echo
echo -e ${yellow}正在更新软件源${background}
a=0
until apt-get -y update
do
  echo -e ${red}软件源更新失败 ${green}正在重试${background}
  a=$(($a+1))
  if [ "${a}" == "3" ];then
    echo -e ${red}错误次数过多 退出${background}
    exit
  fi
done
echo

pkg_list=("tar" "xz-utils" "gzip")
for pkg in ${pkg_list[@]}; do
if ! dpkg -s ${pkg} >/dev/null 2>&1 ; then
    echo -e ${yellow}安装解压工具${pkg}${background}
    until apt install -y ${pkg}
    do
        echo -e ${red}解压工具 ${green}正在重试${background}
    done
fi
done

pkg_list=("fonts-wqy-zenhei" "fonts-wqy-microhei")
for pkg in ${pkg_list[@]}; do
if ! dpkg -s ${pkg} >/dev/null 2>&1 ; then
    echo -e ${yellow}安装中文字体${background}
    until apt install -y ${pkg}
    do
        echo -e ${red}中文字体安装失败 ${green}正在重试${background}
    done
fi
done

if [ ! -x "$(command -v redis-server)" ];then
    echo -e ${yellow}安装redis数据库${background}
    until apt install -y redis redis-server
    do
      echo -e ${red}redis数据库安装失败 ${green}正在重试${background}
    done
    echo
fi

#if ! [ -x "$(command -v catimg)" ];then
#    echo -e ${yellow}安装catimg${background}
#    until apt install -y catimg
#    do
#      echo -e ${red}catimg安装失败 ${green}正在重试${background}
#    done
#    echo
#fi

function chromium_install(){
echo "deb http://ftp.cn.debian.org/debian sid main" >> /etc/apt/sources.list
apt install -y gnupg gnupg1 gnupg2
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0E98404D386FA1D9 6ED0E7B82643E131
apt-key adv --refresh-keys --keyserver keyserver.ubuntu.com
apt update -y
apt install -y chromium
rm -rf /etc/apt/trusted.gpg
sed -i "s/deb http:\/\/ftp.cn.debian.org\/debian sid main//g" /etc/apt/sources.list
chromium > /dev/null
}

function install_chromium(){
echo -e ${yellow}安装chromium浏览器${background}
if awk '{print $2}' /etc/issue | grep -q -E 20.*
    then
        until chromium_install
        do
           echo -e ${red}chromium浏览器安装失败 ${green}正在重试${background}
        done
elif awk '{print $2}' /etc/issue | grep -q -E 22.*
    then
        until bash <(curl https://gitee.com/baihu433/chromium/raw/master/chromium.sh)
        do
           echo -e ${red}chromium浏览器安装失败 ${green}正在重试${background}
        done
elif awk '{print $2}' /etc/issue | grep -q -E 23.*
    then
        until chromium_install
        do
           echo -e ${red}chromium浏览器安装失败 ${green}正在重试${background}
        done          
else
    until apt install -y chromium-browser
        do
           apt install -y chromium-browser
           echo -e ${red}chromium浏览器安装失败 ${green}正在重试${background}
        done
fi
}
if dpkg-query -s chromium > /dev/null 2>&1
    then 
        Installation_Status="installed"
fi

if dpkg-query -s chromium-browser > /dev/null 2>&1
    then 
        Installation_Status="installed"
fi

if [ ! "${Installation_Status}" == "installed" ];then
    install_chromium
fi

if [ ! -x "$(command -v ffmpeg)" ];then
echo -e ${yellow}正在安装ffmpeg${background}
bash <(curl https://gitee.com/baihu433/ffmpeg/raw/master/ffmpeg.sh)
fi

function setup_nodejs_install(){
if awk '{print $2}' /etc/issue | grep -q -E 22.* | grep -q -E 23.*
then
  echo -e ${yellow}安装nodejs${background}
  rm /etc/apt/sources.list.d/nodesource.list > /dev/null 2>&1
  curl https://deb.nodesource.com/setup_18.x | bash
else
  echo -e ${yellow}安装nodejs${background}
  rm /etc/apt/sources.list.d/nodesource.list > /dev/null 2>&1
  curl https://deb.nodesource.com/setup_16.x | bash 
  # | sed "s/sleep 20/sleep 2/g" | sed "s/Continuing in 20 seconds .../Continuing in 2 seconds .../g" | bash
fi
apt autoremove -y nodejs
curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | gpg --dearmor | tee /usr/share/keyrings/nodesource.gpg > /dev/null
apt update -y
apt install -y nodejs
echo
} #nodejs_install
function nvm_nodejs_install(){
rm -rf $HOME/.nvm > /dev/null
echo -e ${yellow}正在安装nvm 这需要一些时间'\n'${cyan}[如果中途没有任何输出 那是在处理安装 请耐心等待]${background}
curl https://ghproxy.com/https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | sed "s/https:\/\/raw.githubusercontent.com/https:\/\/ghproxy.com\/https:\/\/raw.githubusercontent.com/g" | sed "s/https:\/\/github.com/https:\/\/ghproxy.com\/https:\/\/github.com/g" | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
export NVM_NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node/
echo "export NVM_NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node/" >> ~/.bashrc
if awk '{print $2}' /etc/issue | grep -q -E 22.* || grep -q -E 23.*
then
  nvm install --lts
else
  nvm install 16.20.0
fi
source ~/.bashrc
echo
}
function binaries_nodejs_install(){
case $(uname -m) in
x86_64|amd64)
node=x64
;;
arm64|aarch64|armv8*)
node=arm64
;;
armhf|armel|armv7*)
node=armv7l
;;
*)
echo -e ${red}不受支持的框架 自动切换为setup脚本${background}
setup_nodejs_install
return
#echo ${red}您的框架为${yellow}$(uname -m)${red},快让白狐做适配.${background}
esac
if awk '{print $2}' /etc/issue | grep -q -E 22.*
    then
        curl -o node.tar.xz https://cdn.npmmirror.com/binaries/node/latest-v18.x/node-v18.17.0-linux-${node}.tar.xz
elif awk '{print $2}' /etc/issue | grep -q -E 23.*
    then
        curl -o node.tar.xz https://cdn.npmmirror.com/binaries/node/latest-v18.x/node-v18.17.0-linux-${node}.tar.xz     
    else
        curl -o node.tar.xz https://cdn.npmmirror.com/binaries/node/latest-v16.x/node-v16.20.0-linux-${node}.tar.xz
fi
if [ ! -d node ];then
mkdir node
fi
echo -e ${yellow}正在解压二进制文件压缩包${background}
tar -xf node.tar.xz -C node
rm -rf /usr/local/node > /dev/null
rm -rf /usr/local/node > /dev/null
mv -f node/$(ls node) /usr/local/node
if [ ! -d $HOME/.local/share/pnpm ];then
    mkdir -p $HOME/.local/share/pnpm
fi
export PATH=$PATH:/usr/local/node/bin
export PATH=$PATH:/root/.local/share/pnpm
export PNPM_HOME=/root/.local/share/pnpm
echo '
#Node.JS
export PATH=$PATH:/usr/local/node/bin
export PATH=$PATH:/root/.local/share/pnpm
export PNPM_HOME=/root/.local/share/pnpm
' >> /etc/profile
source /etc/profile
rm -rf node node.tar.xz > /dev/null
rm -rf node node.tar.xz > /dev/null
}

Nodsjs_Version=$(node -v | cut -d '.' -f1)
if ! [[ "$Nodsjs_Version" == "v16" || "$Nodsjs_Version" == "v17" || "$Nodsjs_Version" == "v18" || "$Nodsjs_Version" == "v19" || "$Nodsjs_Version" == "v20" || "$Nodsjs_Version" == "v20" ]] && ! [ -x "$(command -v npm)" ];then
  if (whiptail --title "白狐" \
   --yes-button "二进制文件" \
   --no-button "setup脚本" \
   --yesno "请选择nodejs安装方式 \n国内用户建议使用二进制文件安装 \n国际用户建议使用setup脚本安装" 10 50)
   then
     nodejs_install=binaries_nodejs_install
   else
     nodejs_install=setup_nodejs_install
  fi
  echo -e ${yellow}安装nodejs和npm${background}
  a=0
  until ${nodejs_install}
  do
    echo -e ${red}NodeJS和npm安装失败 ${green}正在重试${background}
    a=$(($a+1))
    if [ "${a}" == "3" ];then
      echo -e ${red}错误次数过多 退出${background}
      exit
    fi
  done
  echo
fi

if [ ! -x "$(command -v pnpm)" ];then
    echo -e ${yellow}正在使用npm安装pnpm${background}
    a=0
    npm config set registry https://registry.npmmirror.com
    npm config set registry https://registry.npmmirror.com
    npm install -g npm@latest
    until npm install -g pnpm@latest
    do
      echo -e ${red}pnpm安装失败 ${green}正在重试${background}
      a=$(($a+1))
      if [ "${a}" == "3" ];then
        echo -e ${red}错误次数过多 退出${background}
        exit
      fi
    done
    echo
fi

#if ! [ -x "$(command -v pm2)" ];then
#    echo -e ${yellow}正在使用npm安装pnpm${background}
#    until npm install -g pm2
#    do
#      echo -e ${red}pm2安装失败 ${green}正在重试${background}
#    done
#    echo
#fi

a=0
echo -e ${yellow}正在使用pnpm安装依赖${background}
cd ~/.fox@bot/${name}
pnpm config set registry https://registry.npmmirror.com
pnpm config set registry https://registry.npmmirror.com
until echo "Y" | pnpm install -P && echo "Y" | pnpm install
do
  echo -e ${red}依赖安装失败 ${green}正在重试${background}
  pnpm setup
  source ~/.bashrc
  a=$(($a+1))
  if [ "${a}" == "3" ];then
    echo -e ${red}错误次数过多 退出${background}
    exit 
  fi
done
pnpm uninstall puppeteer -w
pnpm install puppeteer@19.0.0 -w
pnpm uninstall icqq -w
pnpm install icqq@latest -w
if [ ! -e $HOME/.fox@bot/${name}/config/config/bot.yaml ];then
cd ~/.fox@bot/${name}
echo -en ${yellow}正在初始化${background}
pnpm run start
sleep 5s
pnpm run stop
rm -rf ~/.pm2/logs/*.log
echo -en ${yellow}初始化完成${background}
echo
if [ ! -d $HOME/QSignServer/qsign* ];then
if (whiptail --title "白狐" \
   --yes-button "马上部署" \
   --no-button "暂不部署" \
   --yesno "是否部署本地签名服务器?" 10 50)
   then
       export install_QSignServer=true
       bash <(curl -sL https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/QSignServer2.0.sh)
fi
fi
fi
echo -en ${yellow}安装完成 回车继续${background};read
} #install
#########################################################
function install_Bot(){
if (whiptail --title "白狐" \
   --yes-button "安装" \
   --no-button "返回" \
   --yesno "${name}未安装，是否开始安装?" 10 50)
   then
     if (whiptail --title "白狐" \
       --yes-button "Gitee" \
       --no-button "Github" \
       --yesno "请选择${name}的下载服务器\n国内用户建议选择Gitee" 10 50)
       then
         if ! git clone --depth=1 ${Gitee} ~/.fox@bot/${name};then
           echo -e ${red} 克隆失败 ${cyan}试试Github ${background}
           exit
         fi
       else
         if ! git clone --depth=1 ${Github} ~/.fox@bot/${name};then
           echo -e ${red} 克隆失败 ${cyan}试试Gitee ${background}
           exit
         fi
     fi
     ln -sf ~/.fox@bot/${name} ~/${name}
fi
} #install_Yunzai_Bot
#########################################################
function install_Miao_Plugin(){
if (whiptail --title "白狐" \
--yes-button "Gitee" \
--no-button "Github" \
--yesno "请选择的miao-plugin下载服务器\n国内用户建议选择Gitee" 10 50)
  then
    if ! git clone --depth=1 https://gitee.com/yoimiya-kokomi/miao-plugin.git ~/.fox@bot/${name}/plugins/miao-plugin
    then
      echo -e ${red} 克隆失败 ${cyan}试试Github ${background}
      exit
    fi
  else
    if ! git clone --depth=1 https://github.com/yoimiya-kokomi/miao-plugin.git ~/.fox@bot/${name}/plugins/miao-plugin
    then
      echo -e ${red} 克隆失败 ${cyan}试试Gitee ${background}
      exit
    fi
fi
} #install_Miao_Plugin
#########################################################
function install_go_cqhttp(){
if [ -e /etc/resolv.conf ]; then
        cp /etc/resolv.conf /etc/resolv.conf.backup
        echo -e ${yellow}DNS已备份至 /etc/resolv.conf.backup${background}
    else
        echo -e ${red}没有resolv.conf此文件${background}
        exit
fi
if grep -q "114.114.114.114" /etc/resolv.conf && grep -q "8.8.8.8" /etc/resolv.conf
    then
        echo -e ${yellow}DNS已修改${background}
    else
        echo "nameserver 114.114.114.114" > /etc/resolv.conf
        echo "nameserver 8.8.8.8" >> /etc/resolv.conf
        echo -e ${yellow}DNS已修改为 114.114.114.114 8.8.8.8${background}
fi
case $(uname -m) in
amd64|x86_64)
URL="https://ghproxy.com/https://github.com/rhwong/go-cqhttp-dev/releases/download/v1.1.1-dev/go-cqhttp-linux-amd64.tar.gz"
;;
arm64|aarch64)
URL="https://ghproxy.com/https://github.com/rhwong/go-cqhttp-dev/releases/download/v1.1.1-dev/go-cqhttp-linux-arm64.tar.gz"
;;
*)
echo ${red}抱歉 暂时不支持您的架构${background}
exit
;;
esac
axel -n 32 -o go-cqhttp.tar.gz -c ${URL}
tar -zxf go-cqhttp.tar.gz
}
#########################################################
function help(){
echo -en ${cyan} 正在咕咕 回车返回${background}
read
}
function error(){
ErrorRepair=$(whiptail \
--title "白狐≧▽≦" \
--menu "${ver}" \
20 40 10 \
"1" "修复chromium启动失败" \
"2" "降级puppeteer版本" \
"3" "修改${name}主人qq" \
"4" "修改登录设备" \
"5" "修复redis数据库" \
"6" "检查各项依赖" \
"0" "返回" \
3>&1 1>&2 2>&3)
feedback=$?
if ! [ $feedback = 0 ]
then
return
fi
case ${ErrorRepair} in
1)
function chromium_install(){
apt install -y gnupg gnupg1 gnupg2
cp -f /etc/apt/sources.list /etc/apt/sources.list.bak
echo "deb http://ftp.cn.debian.org/debian sid main" > /etc/apt/sources.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0E98404D386FA1D9 6ED0E7B82643E131
apt-key adv --refresh-keys --keyserver keyserver.ubuntu.com
apt update -y
apt install -y chromium
rm -rf /etc/apt/trusted.gpg
mv -f /etc/apt/sources.list.bak /etc/apt/sources.list
chromium > /dev/null
cd ~/.fox@bot/${name}
chromium_path=$(grep chromium_path: config/config/bot.yaml)
sed -i "s/${chromium_path}/chromium_path: \/usr\/bin\/chromium/g" config/config/bot.yaml
aptitude install -y
}
if ! command -v aptitude > /dev/null;then
apt install -y aptitude
fi
if awk '{print $2}' /etc/issue | grep -q -E 22.*
    then
        chromium_install
elif awk '{print $2}' /etc/issue | grep -q -E 23.*
    then
        chromium_install
    else
        apt autoremove -y chromium-browser
        apt install -y chromium-browser
fi

echo -e ${green}回车返回${background};read
;;
2)
cd ~/.fox@bot/${name}
echo "Y" | pnpm install
pnpm uninstall puppeteer
pnpm install puppeteer@19.0.0 -w
node ./node_modules/puppeteer/install.js
echo -e ${green}回车返回${background};read
;;
3)
qq=$(whiptail \
--title "白狐≧▽≦" \
--inputbox "请输入您要更改后的主人qq号" \
10 60 \
3>&1 1>&2 2>&3)
if [[ ${qq} =~ ^[0-9]+$ ]]; then
  if [ ${qq} -gt 9999 ]; then
    sed -i '7s/.*/'" - $qq"'/' $HOME/Yunzai-Bot/config/config/other.yaml
    whiptail --title "白狐≧▽≦" --msgbox \
    "主人QQ已更改为${qq}" \
    10 60
  else
    echo -e ${red}请输入正确的QQ!${background}
    exit
  fi
else
    echo -e ${red}请输入正确的QQ号${background}
    exit
fi
echo -e ${green}回车返回${background};read
;;
4)
cd ~/.fox@bot/${name}
equipment=$(whiptail \
--title "白狐≧▽≦" \
--menu "请选择登录设备" \
17 35 7 \
"1" "安卓手机" \
"2" "aPad" \
"3" "安卓手表" \
"4" "MacOS" \
"5" "iPad" \
"6" "Tim" \
3>&1 1>&2 2>&3)
feedback=$?
if ! [ $feedback = 0 ]
then
return
fi
new="platform: ${equipment}"
file="~/.fox@bot/${name}/config/config/qq.yaml"
old_equipment="platform: [0-5]"
new_equipment="platform: ${equipment}"
sed -i "s/${old_equipment}/${new_equipment}/g" ${file}
rm ~/.fox@bot/${name}/data/device.json
echo -e ${green}回车返回${background};read
;;
5)
apt autoremove -y redis redis-server
apt install -y redis redis-server
echo -e ${green}回车返回${background};read
;;
6)
install
echo -e ${green}检查完成 回车返回${background};read
;;
7)
curl -o redis.tar.gz https://download.redis.io/releases/redis-7.2-rc3.tar.gz
apt install -y tar gzip xz-utils make pkg-config gcc
mkdir redis
tar -zxf redis.tar.gz -C redis
cd redis/$(ls redis)
rm -rf /usr/local/redis > /dev/null
mkdir /usr/local/redis
make PREFIX=/usr/local/redis install
echo -e ${green}重装完成 回车返回${background};read
;;
esac
}
function QSIGN(){
export QSIGN_VERSION="116"
if [ -d $HOME/QSignServer/jdk ];then
export PATH=$PATH:$HOME/QSignServer/jdk/bin
export JAVA_HOME=$HOME/QSignServer/jdk
fi
if [ -d /usr/local/node/bin ];then
    if [ ! -d $HOME/.local/share/pnpm ];then
        mkdir -p $HOME/.local/share/pnpm
    fi
    export PATH=$PATH:$HOME/.local/share/pnpm
    export PNPM_HOME=$HOME/.local/share/pnpm
elif [ -d $HOME/QSignServer/node/bin ];then
    export PATH=$PATH:$HOME/QSignServer/node/bin
    export PNPM_HOME=$HOME/QSignServer/node/bin
elif [ -d /usr/lib/node_modules/pnpm/bin ];then
    if [ ! -d $HOME/.local/share/pnpm ];then
        mkdir -p $HOME/.local/share/pnpm
    fi
    export PATH=$PATH:$HOME/.local/share/pnpm
    export PNPM_HOME=$HOME/.local/share/pnpm
fi
if ! [ -x "$(command -v pm2)" ];then
    echo -e ${yellow}正在使用pnpm安装pm2${background}
    pnpm config set registry https://registry.npmmirror.com
    pnpm config set registry https://registry.npmmirror.com
    until pnpm install -g pm2@latest
    do
      echo -e ${red}pm2安装失败 ${green}正在重试${background}
      pnpm setup
    done
    echo
fi
if [ -d $HOME/QSignServer/qsign${QSIGN_VERSION} ];then
    if [ ! -e $HOME/.fox@bot/${name}/node_modules/icqq/package.json ];then
        echo Y pnpm install && echo Y | pnpm install -P
    fi
    ICQQ_VERSION="$(grep version $HOME/.fox@bot/${name}/node_modules/icqq/package.json | awk '{print $2}' | sed 's/\"//g' | sed 's/,//g')"
    case ${ICQQ_VERSION} in
    0.4.13)
    export version=8.9.70
    ;;
    0.4.12)
    export version=8.9.70
    ;;
    0.4.11)
    export version=8.9.68
    ;;
    0.4.10)
    export version=8.9.63
    ;;
    0.3.*)
    echo -e ${yellow}请更新icqq${background}
    export version=8.9.70
    ;;
    *)
    echo -e ${yellow}读取失败 请更新icqq${background}
    export version=8.9.70
    ;;
    esac
    if [ ! -e $HOME/QSignServer/txlib/${version}/config.json ];then
        echo ${red}文件不存在 请确认您已经部署签名服务器${background}
        exit
    fi
    file="$HOME/QSignServer/txlib/${version}/config.json"
    port="$(grep -E port ${file} | awk '{print $2}' | sed "s/\"//g" | sed "s/://g" )"
    key="$(grep -E key ${file} | awk '{print $2}' | sed "s/\"//g" | sed "s/,//g" )"
    host="$(grep -E host ${file} | awk '{print $2}' | sed "s/\"//g" | sed "s/,//g" )"
    API="http://"${host}":"${port}"/sign?key="${key}
    API=$(echo ${API})
    file1="$HOME/.fox@bot/${name}/config/config/bot.yaml"
    file2="$HOME/.fox@bot/${name}/config/config/qq.yaml"
    equipment="platform: 2"
    if [ -e ${file} ];then
        if ! grep -q "${API}" ${file1};then
            sed -i '/sign_api_addr/d' ${file1}
            sed -i "\$a\sign_api_addr: ${API}" ${file1}
        fi
        if ! grep -q "${equipment}" ${file2};then
            sed -i "s/platform: */${equipment}/g" ${file2}
        fi
    fi
    if pm2 show qsign${QSIGN_VERSION} | grep -q online;then
        echo -e ${green}签名服务器 ${cyan}已启动${background}
    else
        echo -e ${green}签名服务器 ${red}未启动${background}
        echo -e ${yellow}正在尝试启动签名服务器${background}
        pm2 start --name qsign${QSIGN_VERSION} "bash $HOME/QSignServer/qsign${QSIGN_VERSION}/bin/unidbg-fetch-qsign --basePath=$HOME/QSignServer/txlib/${version}"
    fi
fi
}
function main(){
baihu=$(whiptail \
--title "白狐≧▽≦" \
--menu "${ver},注意:第一次启动,请使用前台启动" \
20 45 12 \
"1" "打开${name}日志" \
"2" "后台启动${name}" \
"3" "停止${name}运行" \
"4" "管理${name}插件" \
"5" "${name}重新登陆" \
"6" "填写签名服务器" \
"7" "前台启动${name}" \
"8" "${name}报错修复" \
"9" "帮助[实时更新]" \
"10" "卸崽! 删除${name}" \
"0" "返回" \
3>&1 1>&2 2>&3)
feedback=$?
if ! [ $feedback = 0 ]
then
return
fi
case ${baihu} in 
1)
cd ~/${name}
pnpm run log
echo
echo -en ${cyan}回车返回${background};read
;;
2)
Redis=$(redis-cli ping)
if ! [ "${Redis}" = "PONG" ]; then
 nohup redis-server &
 echo
fi
cd ~/${name}
QSIGN
if [ -e ~/${name}/config/config/qq.yaml ];then
pnpm run start
echo -e ${yellow}${name}启动完成 ${green}是否打开日志 ${cyan}[Y/n] ${background}
read -p "" num
      case $num in
     Y|y)
       cd ~/.fox@bot/${name}
       pnpm run log
       echo
       echo -en ${cyan}回车返回${background};read
       ;;
     n|N)
       echo -en ${cyan}回车返回${background};read
       ;;
     *)
       echo -en ${cyan}回车返回${background};read
       ;;
       esac
else
echo
echo -en ${red}请使用前台启动后，在使用后台启动${background};read
fi
;;
3)
cd ~/${name}
pnpm stop
echo
echo -en ${cyan}回车返回${background};read
;;
4)
bash <(curl -sL https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/plug-in.sh)
;;
5)
Redis=$(redis-cli ping)
if ! [ "${Redis}" = "PONG" ]; then
 redis-server &
 echo
fi
cd ~/${name}
pnpm run login
echo
echo -en ${cyan}回车返回${background};read
;;
6)
#bash <(curl -sL https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/version.sh)
cd ~/${name}
git pull
if (whiptail --title "白狐" \
--yes-button "第三方签名服务器" \
--no-button "返回" \
--yesno "请选择签名服务器类型" 10 50)
  then
    if [ -e $HOME/${name}/config/config/bot.yaml ]
    then
        #http://127.0.0.1:8080/sign
        #sign_api_addr: http://127.0.0.1:8080/sign?key=123456
        #sign_api_addr: 112.74.57.142
        sed -i '/sign_api_addr/d' config/config/bot.yaml
        apilink=$(whiptail --title "白狐≧▽≦" --inputbox "请输入您准备好的api链接\n请注意,原链接末尾有sign的不要忘记了，如果有key请带上" \
        10 60 3>&1 1>&2 2>&3)
        sed -i "\$a\sign_api_addr: ${apilink}" config/config/bot.yaml
        API=$(grep sign_api_addr config/config/bot.yaml)
        API=$(echo ${API} | sed "s/sign_api_addr//g")
        echo -e ${cyan}您的API链接已修改为 ${green}${API}${background}
        echo
    fi
fi
echo -en ${yellow}执行完成 回车继续${background};read
;;
7)
Redis=$(redis-cli ping)
if ! [ "${Redis}" = "PONG" ]; then
 redis-server --daemonize yes &
 echo
fi
cd ~/${name}
QSIGN
pnpm run stop
node app
echo
echo -en ${cyan}回车返回${background};read
;;
8)
error
;;
9)
echo -en ${cyan} 正在咕咕 回车返回${background}
;;
10)
echo -e ${yellow}是否删除${red}${name}${cyan}[N/y] ${background};read -p "" num
      case $num in
     Y|y)
       echo -e ${red}3${background}
       sleep 1
       echo -e ${red}2${background}
       sleep 1
       echo -e ${red}1${background}
       sleep 1
       echo -e ${red}正在删除${name}${background}
       rm -rf ~/${name} > /dev/null
       rm -rf ~/${name} > /dev/null
       rm -rf ~/.fox@bot/${name} > /dev/null
       rm -rf ~/.fox@bot/${name} > /dev/null
       echo -en ${cyan}删除完成 回车返回${background};read
       ;;
     n|N)
       echo -en ${cyan}回车返回${background};read
       ;;
     *)
       echo -en ${red}输入错误${cyan}回车返回${background};read
       ;;
       esac
;;
0)
return
;;
esac
}
#########################################################
function bot_path(){
if ! [ -L ~/${name} ];then
    mv ~/${name} ~/.fox@bot/${name}
    ln -sf ~/.fox@bot/${name} ~/${name}
fi
}
#########################################################
function install_bot(){
cd ~
if ! [ -d .fox@bot ];then
mkdir .fox@bot
fi
Number=$(whiptail \
--title "白狐 QQ群:705226976" \
--menu "请选择bot" \
20 40 10 \
"1" "Yunzai[icqq版]" \
"2" "Miao-Yunzai" \
"3" "TRSS-Yunzai" \
"4" "签名服务器管理" \
"5" "白狐脚本附件安装" \
"0" "退出" \
3>&1 1>&2 2>&3)
feedback=$?
if ! [ $feedback = 0 ]
then
exit
fi
case ${Number} in
1)
name=Yunzai-Bot
Gitee=https://gitee.com/yoimiya-kokomi/Yunzai-Bot.git
#GithubYZ=https://github.com/yoimiya-kokomi/Yunzai-Bot.git
if [ ! -d "/root/.fox@bot/${name}" ];then
install_Bot
install
fi
bot_path
main
;;
2)
name=Miao-Yunzai
Gitee=https://gitee.com/yoimiya-kokomi/Miao-Yunzai.git
Github=https://github.com/yoimiya-kokomi/Miao-Yunzai.git
if [ ! -d "/root/.fox@bot/${name}" ];then
install_Bot
install_Miao_Plugin
install
fi
bot_path
main
;;
3)
whiptail --title "白狐≧▽≦" --msgbox "
TRSS-Yunzai的安装正在测试中，可能有bug
" 10 43
name=TRSS-Yunzai
Gitee=https://gitee.com/TimeRainStarSky/Yunzai.git
Github=https://github.com/TimeRainStarSky/Yunzai.git
if [ ! -d "/root/.fox@bot/${name}" ];then
install_Bot
install_Miao_Plugin
install
fi
bot_path
main
;;
4)
bash <(curl -sL https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/QSignServer2.0.sh)
;;
5)
Number=$(whiptail \
--title "白狐 QQ群:705226976" \
--menu "请选择bot" \
20 40 10 \
"1" "安装ffmpeg" \
"2" "安装python3.10 pip poetry" \
"0" "退出" \
3>&1 1>&2 2>&3)
feedback=$?
if ! [ $feedback = 0 ]
then
exit
fi
case ${Number} in
1)
echo -e ${yellow}正在安装ffmpeg${background}
bash <(curl https://gitee.com/baihu433/ffmpeg/raw/master/ffmpeg.sh)
echo -en ${yellow}安装完成 回车返回${background};read
;;
2)
apt update -y
if [ -x "$(command -v python3.10)" ];then
apt autoremove python3.10 -y
apt autoremove python3.10-full -y
fi
apt install -y software-properties-common
until echo -e "\n" | add-apt-repository ppa:deadsnakes/ppa && apt update -y
do
echo -e ${red}ppa仓库写入失败 ${cyan}3秒后重试${background}
sleep 3s
done
apt install -y python3.10-dev
apt install -y python3.10-venv
until apt install python3.10-full -y
do
echo -e ${red}python3.8安装失败 ${cyan}3秒后重试${background}
sleep 3s
done
until curl https://bootstrap.pypa.io/get-pip.py | python3.10
do
echo -e ${red}pip安装失败 ${cyan}3秒后重试${background}
sleep 3s
done
python3.10 -m pip config set global.index-url https://mirrors.bfsu.edu.cn/pypi/web/simple
python3.10 -m pip config set global.index-url https://mirrors.bfsu.edu.cn/pypi/web/simple
python3.10 -m pip install --upgrade pip
until pip install poetry
do
echo -e ${red}poetry安装失败 ${cyan}3秒后重试${background}
sleep 3s
done
echo
echo -en ${yellow}安装完成 回车返回${background};read
;;
0)
return
;;
esac
;;
0)
exit
;;
esac
}
function mainbak()
{
   while true
   do
       install_bot
       mainbak
   done
}
mainbak
