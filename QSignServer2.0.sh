#!/bin/env bash
red="\033[31m"
green="\033[32m"
yellow="\033[33m"
blue="\033[34m"
purple="\033[35m"
cyan="\033[36m"
white="\033[37m"
background="\033[0m"
if [ "$(uname -o)" = "Android" ];then
echo -e ${red}你是大聪明吗?${background}
exit
fi
function main(){
cd $HOME
if [ -d $HOME/QSignServer/jdk ];then
export PATH=$PATH:$HOME/QSignServer/jdk/bin
export JAVA_HOME=$HOME/QSignServer/jdk
fi
if [ -d /usr/local/node/bin ];then
export PATH=$PATH:/usr/local/node/bin
export PNPM_HOME=/usr/local/node/bin
fi
if [ -d $HOME/QSignServer/node/bin ];then
export PATH=$PATH:$HOME/QSignServer/node/bin
export PNPM_HOME=$HOME/QSignServer/node/bin
fi
if [ -d /usr/lib/node_modules/pnpm/bin ];then
export PATH=$PATH:/usr/lib/node_modules/pnpm/bin
export PNPM_HOME=/usr/lib/node_modules/pnpm/bin
fi
function install_QSignServer(){
if [ ! $(command -v git) ] || [ ! $(command -v axel) ] || [ ! $(command -v gzip) ] || [ ! $(command -v unzip) ] || [ ! $(command -v xz) ];then
    if [ $(command -v apt) ];then
        apt update -y
        apt install -y git axel gzip unzip xz-utils
    elif [ $(command -v yum) ];then
        yum update -y
        yum install -y git axel gzip unzip xz
    elif [ $(command -v dnf) ];then
        dnf update -y
        dnf install -y git axel gzip unzip xz
    elif [ $(command -v pacman) ];then
        pacman -Sy --noconfirm --needed git axel gzip unzip xz
    elif [ $(command -v apk) ];then
        apk update
        apk add git axel gzip unzip xz
    fi
fi
case $(uname -m) in
amd64|x86_64)
JDK_URL="https://cdn.azul.com/zulu/bin/zulu8.70.0.23-ca-jdk8.0.372-linux_x64.tar.gz"
node=x64
;;
arm64|aarch64)
JDK_URL="https://cdn.azul.com/zulu-embedded/bin/zulu8.70.0.23-ca-jdk8.0.372-linux_aarch64.tar.gz"
node=arm64
;;
esac
JAVA_VERSION=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}')
if [[ ! "${JAVA_VERSION}" == "1.8"* ]]; then
    until axel -n 32 -o jdk.tar.gz -c ${JDK_URL}
    do
      echo -e ${red}下载失败 ${green}正在重试${background}
    done
    if [ ! -d $HOME/QSignServer ];then
        mkdir QSignServer
    fi
    echo -e ${yellow}正在解压JDK文件,请耐心等候${background}
    mkdir jdk
    tar -zxf jdk.tar.gz -C jdk
    mv jdk/$(ls jdk) QSignServer/jdk
    rm -rf jdk.tar.gz
    rm -rf jdk
    PATH=$PATH:$HOME/QSignServer/jdk/bin
    export JAVA_HOME=$HOME/QSignServer/jdk
fi
NODEJS_URL16=https://cdn.npmmirror.com/binaries/node/latest-v16.x/node-v16.20.0-linux-${node}.tar.xz
NODEJS_URL18=https://cdn.npmmirror.com/binaries/node/latest-v18.x/node-v18.17.0-linux-${node}.tar.xz
Nodsjs_Version=$(node -v | cut -d '.' -f1)
if ! [[ "$Nodsjs_Version" == "v16" || "$Nodsjs_Version" == "v18" ]]
    then
    if awk '{print $2}' /etc/issue | grep -q -E 22.*
        then
            curl -o node.tar.xz ${NODEJS_URL18}
    elif awk '{print $2}' /etc/issue | grep -q -E 23.*
        then
            curl -o node.tar.xz ${NODEJS_URL18}
    else
            curl -o node.tar.xz ${NODEJS_URL16}
    fi
    if [ ! -d node ];then
    mkdir node
    fi
    echo -e ${yellow}正在解压nodejs二进制文件压缩包${background}
    mkdir node
    tar -xJf node.tar.xz -C node
    mv -f node/$(ls node) $HOME/QSignServer/node
    rm -rf node.tar.xz
    rm -rf node
    export PATH=$PATH:$HOME/QSignServer/node/bin
    export PNPM_HOME=$HOME/QSignServer/node/bin
fi
if ! [ -x "$(command -v pnpm)" ];then
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
if ! [ -x "$(command -v pm2)" ];then
    echo -e ${yellow}正在使用pnpm安装pnpm${background}
    pnpm config set registry https://registry.npmmirror.com
    pnpm config set registry https://registry.npmmirror.com
    until pnpm install -g pm2@latest
    do
      echo -e ${red}pm2安装失败 ${green}正在重试${background}
      pnpm setup
    done
    echo
fi

echo -e ${white}"====="${green}白狐-QSignServer${white}"====="${background}
echo -e ${cyan}请选择您要安装的版本${background}
echo -e  ${green}1.  ${cyan}1.1.5${background}
echo -e  ${green}2.  ${cyan}1.1.0${background}
echo "========================="
echo -e ${cyan}他们的区别是${background}
echo -e ${cyan}1.1.5适配icqq 1.1.0适配go-cqhttp${background}
echo "========================="
echo -en ${green}请输入您的选项: ${background};read number
case ${number} in
1|1.1.5)
QSIGN_URL="https://ghproxy.com/https://github.com/fuqiuluo/unidbg-fetch-qsign/releases/download/1.1.5/qsign-1.1.5.onejar.zip"
QSIGN_VERSION="115"
;;
2|1.1.0)
QSIGN_URL="https://ghproxy.com/https://github.com/fuqiuluo/unidbg-fetch-qsign/releases/download/1.1.0/unidbg-fetch-qsign-1.1.0.zip"
QSIGN_VERSION="110"
;;
*)
echo
echo -e ${red}输入错误${background}
exit
;;
esac
if [ -d $HOME/QSignServer/qsign${QSIGN_VERSION} ];then
echo -e ${yellow}您已安装过该版本的签名服务器了${background}
exit
fi
if [ ! -d $HOME/QSignServer/txlib ];then
mkdir -p $HOME/QSignServer/txlib
git clone --depth=1 -b 1.1.5 https://gitee.com/baihu433/unidbg-fetch-qsign
rm -rf $HOME/QSignServer/txlib
mv -f unidbg-fetch-qsign/txlib $HOME/QSignServer/txlib
rm -rf unidbg-fetch-qsign
fi
until axel -n 32 -o qsign.zip -c ${QSIGN_URL}
  do
    echo -e ${red}下载失败 ${green}正在重试${background}
  done
echo -e ${yellow}正在解压qsign文件压缩包${background}
    unzip -q qsign.zip -d qsign
    mv $HOME/qsign/$(ls qsign) $HOME/QSignServer/qsign${QSIGN_VERSION}
    rm -rf qsign.zip
    rm -rf qsign
    rm -rf $HOME/QSignServer/qsign${QSIGN_VERSION}/txlib 2&> /dev/null
echo -en ${yellow}安装完成 回车返回${background};read
}

function start_QSignServer(){
echo -e ${white}"====="${green}白狐-QSignServer${white}"====="${background}
echo -e ${cyan}请选择您要启动的签名服务器${background}
echo -e  ${green}1.  ${cyan}1.1.5${background}
echo -e  ${green}2.  ${cyan}1.1.0${background}
echo "========================="
echo -en ${green}请输入您的选项: ${background};read number

echo -e ${white}"====="${green}白狐-QSignServer${white}"====="${background}
echo -e ${cyan}请选择您想让您签名服务器适配的QQ版本${background}
echo -e  ${green}1.  ${cyan}8.9.63${background}
echo -e  ${green}2.  ${cyan}8.9.68${background}
#echo -e  ${green}2.  ${cyan}8.9.70${background}
echo "========================="
echo -en ${green}请输入您的选项: ${background};read num
case ${num} in
1|8.9.63)
export version=8.9.63
;;
2|8.9.68)
export version=8.9.68
;;
*)
echo
echo -e ${red}输入错误${background}
exit
;;
esac
case ${number} in
1|1.1.5)
if [ ! -d $HOME/QSignServer/qsign115 ];then
echo -e ${yellow}您未安装过该版本的签名服务器${background}
exit
fi
if ! pm2 show qsign115 | grep -q online ;then
    pm2 start --name qsign115 "bash $HOME/QSignServer/qsign115/bin/unidbg-fetch-qsign --basePath=$HOME/QSignServer/txlib/${version}"
    echo
    echo -en ${yellow}签名服务器已经启动,是否打开日志 [Y/n]${background};read num
    case $num in
     Y|y)
       pm2 logs qsign115
       echo
       ;;
       esac
else
    echo -en ${yellow}签名服务器已经启动,是否打开日志 [Y/n]${background};read num
      case $num in
     Y|y)
       pm2 logs qsign115
       echo
       ;;
       esac  
fi
echo -en ${yellow}回车返回${background};read
;;
2|1.1.0)
if [ ! -d $HOME/QSignServer/qsign110 ];then
echo -e ${yellow}您未安装过该版本的签名服务器${background}
exit
fi
if ! pm2 show qsign110 | grep -q online ;then
    pm2 start --name qsign110 "bash $HOME/QSignServer/qsign110/bin/unidbg-fetch-qsign --host=0.0.0.0 --port=23500 --count=1 --library=$HOME/QSignServer/txlib/${version} --android_id=GGw0JRIMXn5a"
    echo
    echo -en ${yellow}签名服务器已经启动,是否打开日志 [Y/n]${background};read num
    case $num in
     Y|y)
       pm2 logs qsign110
       echo
       ;;
       esac
else
    echo -en ${yellow}签名服务器已经启动,是否打开日志 [Y/n]${background};read num
      case $num in
     Y|y)
       pm2 logs qsign110
       echo
       ;;
       esac  
fi
echo -en ${yellow}回车返回${background};read
;;
esac
}

function stop_QSignServer(){
echo -e ${white}"====="${green}白狐-QSignServer${white}"====="${background}
echo -e ${green}请选择您要停止的签名服务器版本${background}
echo -e  ${green}1.  ${cyan}1.1.5${background}
echo -e  ${green}2.  ${cyan}1.1.0${background}
echo "========================="
echo -en ${green}请输入您的选项: ${background};read number
case ${number} in
1|1.1.5)
pm2 stop qsign115
pm2 delete qsign115
;;
2|1.1.0)
pm2 stop qsign110
pm2 delete qsign110
;;
*)
echo
echo -e ${red}输入错误${background}
exit
;;
esac
}

function restart_QSignServer(){
echo -e ${white}"====="${green}白狐-QSignServer${white}"====="${background}
echo -e ${green}请选择您要重启的签名服务器版本${background}
echo -e  ${green}1.  ${cyan}1.1.5${background}
echo -e  ${green}2.  ${cyan}1.1.0${background}
echo "========================="
echo -en ${green}请输入您的选项: ${background};read number
case ${number} in
1|1.1.5)
pm2 restart qsign115
;;
2|1.1.0)
pm2 restart qsign110
;;
*)
echo
echo -e ${red}输入错误${background}
exit
;;
esac
}

function uninstall_QSignServer(){
cd $HOME
echo -e ${yellow}正在停止服务器运行${background}
pm2 stop qsign115
pm2 delete qsign115
pm2 stop qsign110
pm2 delete qsign110
rm -rf $HOME/QSignServer 2&> /dev/null
rm -rf $HOME/QSignServer 2&> /dev/null
}

echo -e ${white}"====="${green}白狐-QSignServer${white}"====="${background}
echo -e  ${green}1.  ${cyan}安装签名服务器${background}
echo -e  ${green}2.  ${cyan}启动签名服务器${background}
echo -e  ${green}3.  ${cyan}关闭签名服务器${background}
echo -e  ${green}4.  ${cyan}重启签名服务器${background}
echo -e  ${green}5.  ${cyan}更新签名服务器${background}
echo -e  ${green}6.  ${cyan}卸载签名服务器${background}
#echo -e  ${green}7.  ${cyan}修改签名服务器key值${background}
#echo -e  ${green}8.  ${cyan}修改签名服务器端口${background}
echo -e  ${green}7.  ${cyan}清理签名服务器日志${background}
echo -e  ${green}0.  ${cyan}退出${background}
echo "========================="
#echo -e ${green}您的api链接: "127.0.0.1":"${port}"/sign?key="${key}"${background}
echo -e ${green}您的1.1.5版本的api链接: "127.0.0.1:8080/sign?key=114514"${background}
echo -e ${green}您的1.1.0版本的api链接: "127.0.0.1:23500"${background}
echo -e ${green}QQ群:${cyan}狐狸窝:705226976${background}
echo "========================="
echo
echo -en ${green}请输入您的选项: ${background};read number
case ${number} in
1)
echo
install_QSignServer
;;
2)
echo
start_QSignServer
;;
3)
echo
stop_QSignServer
;;
4)
echo
restart_QSignServer
;;
6)
echo
uninstall_QSignServer
;;
7)
echo
pm2 flush qsign
;;
0)
exit
;;
*)
echo
echo -e ${red}输入错误${background}
exit
;;
esac
}
function mainbak()
{
   while true
   do
       main
       mainbak
   done
}
mainbak