#!/bin/env bash
export red="\033[31m"
export green="\033[32m"
export yellow="\033[33m"
export blue="\033[34m"
export purple="\033[35m"
export cyan="\033[36m"
export white="\033[37m"
export background="\033[0m"
cd $HOME
if [ "$(uname -o)" = "Android" ];then
echo -e ${red}你是大聪明吗?${background}
exit
fi
if [ ! "$(uname)" = "Linux" ]; then
	echo -e ${red}你是大聪明吗?${background}
    exit
fi
if [ ! "$(id -u)" = "0" ]; then
    echo -e ${red}请使用root用户${background}
    exit 0
fi
QSIGN_URL="https://ghproxy.com/https://github.com/fuqiuluo/unidbg-fetch-qsign/releases/download/1.1.6/unidbg-fetch-qsign-1.1.6.zip"
QSIGN_VERSION="116"
qsign_version=1.1.6
case $(uname -m) in
amd64|x86_64)
JDK_URL="https://download.oracle.com/java/17/archive/jdk-17.0.8_linux-x64_bin.tar.gz"
node=x64
;;
arm64|aarch64)
JDK_URL="https://download.oracle.com/java/17/archive/jdk-17.0.8_linux-aarch64_bin.tar.gz"
node=arm64
;;
esac
function main(){
if [ -d $HOME/QSignServer/jdk ];then
export PATH=$PATH:$HOME/QSignServer/jdk/bin
export JAVA_HOME=$HOME/QSignServer/jdk
fi
function install_QSignServer(){
if [ ! -e /etc/resolv.conf ]; then
    echo -e ${red}没有resolv.conf此文件${background}
    exit
fi
if ! grep -q "114.114.114.114" /etc/resolv.conf && grep -q "8.8.8.8" /etc/resolv.conf ;then
    cp -f /etc/resolv.conf /etc/resolv.conf.backup
    echo -e ${yellow}DNS已备份至 /etc/resolv.conf.backup${background}
    echo "nameserver 114.114.114.114" > /etc/resolv.conf
    echo "nameserver 8.8.8.8" >> /etc/resolv.conf
    echo -e ${yellow}DNS已修改为 114.114.114.114 8.8.8.8${background}
fi
if [ ! $(command -v git) ] || [ ! $(command -v wget) ] || [ ! $(command -v gzip) ] || [ ! $(command -v unzip) ] || [ ! $(command -v xz) ] || [ ! $(command -v tar) ] || [ ! $(command -v tmux) ];then
    if [ $(command -v apt) ];then
        apt update -y
        apt install -y git wget gzip unzip xz-utils tar tmux
    elif [ $(command -v yum) ];then
        yum update -y
        yum install -y git wget gzip unzip xz tar tmux
    elif [ $(command -v dnf) ];then
        dnf update -y
        dnf install -y git wget gzip unzip xz
    elif [ $(command -v pacman) ];then
        pacman -Sy --noconfirm --needed git wget gzip unzip xz tar tmux
    elif [ $(command -v apk) ];then
        apk update
        apk add git wget gzip unzip xz tar tmux
    fi
fi
JAVA_VERSION=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}')
if [[ ! "$JAVA_VERSION" == "17."* ]]; then
    until wget -O jdk.tar.gz -c ${JDK_URL}
    do
      echo -e ${red}下载失败 ${green}正在重试${background}
    done
    if [ ! -d $HOME/QSignServer ];then
        mkdir QSignServer
    fi
    rm -rf jdk
    rm -rf QSignServer/jdk 2&> /dev/null
    echo -e ${yellow}正在解压JDK文件,请耐心等候${background}
    mkdir jdk
    tar -zxf jdk.tar.gz -C jdk
    mv jdk/$(ls jdk) QSignServer/jdk
    rm -rf jdk.tar.gz
    rm -rf jdk
    PATH=$PATH:$HOME/QSignServer/jdk/bin
    export JAVA_HOME=$HOME/QSignServer/jdk
fi
if [ -d $HOME/QSignServer/qsign${QSIGN_VERSION} ];then
echo -e ${yellow}您已安装过该版本的签名服务器了${background}
exit
fi
if [ ! -d $HOME/QSignServer/txlib ];then
mkdir -p $HOME/QSignServer/txlib
git clone --depth=1 https://gitee.com/baihu433/unidbg-fetch-qsign-onekey 
rm -rf $HOME/QSignServer/txlib
mv -f unidbg-fetch-qsign-onekey/txlib $HOME/QSignServer/txlib
rm -rf unidbg-fetch-qsign-onekey
fi

until wget -O qsign.zip -c ${QSIGN_URL}
  do
    echo -e ${red}下载失败 ${green}正在重试${background}
  done
echo -e ${yellow}正在解压qsign文件压缩包${background}
    unzip -q qsign.zip -d qsign
    mv $HOME/qsign/$(ls qsign) $HOME/QSignServer/qsign${QSIGN_VERSION}
    rm -rf qsign.zip
    rm -rf qsign
    rm -rf $HOME/QSignServer/qsign${QSIGN_VERSION}/txlib > /dev/null
API_LINK=["${cyan} ${qsign_version}"]
if [ -e $HOME/.fox@bot/Yunzai-Bot/config/config/bot.yaml ]
then
    port_="6666"
    for folder in $(ls $HOME/QSignServer/txlib)
    do
        file="$HOME/QSignServer/txlib/${folder}/config.json"
        port="$(grep -E port ${file} | awk '{print $2}' | sed "s/\"//g" | sed "s/://g" )"
        sed -i "s/\"port\": ${port}/\"port\": ${port_}/g" ${file}
    done
    file="$HOME/.fox@bot/Yunzai-Bot/config/config/bot.yaml"
    sed -i '/sign_api_addr/d' ${file}
    sed -i '$a\sign_api_addr: https://127.0.0.1:6666/sign?key=6666' ${file}
    echo -e ${cyan}已自动填入API链接${background}
    echo -e ${cyan}正在尝试启动BOT${background}
    echo
    echo -e ${white}"====="${green}白狐-QSignServer${white}"====="${background}
    echo -e ${cyan}请选择您的启动方式${background}
    echo -e  ${green}1. ${cyan}前台启动${background}
    echo -e  ${green}2. ${cyan}后台启动${background}
    echo "========================="
    echo -en ${green}请输入您的选项: ${background};read num
    case ${yn} in
    1)
    cd $HOME/.fox@bot/Yunzai-Bot
    node app
    ;;
    2)
    cd $HOME/.fox@bot/Yunzai-Bot
    pnpm run start
    ;;
    *)
    echo -e ${red}输入错误 默认前台启动${background}
    cd $HOME/.fox@bot/Yunzai-Bot
    node app
    ;;
    esac
else
    echo -en ${yellow}安装完成 是否启动?[Y/n]${background};read yn
    case ${yn} in
    Y|y)
    start_QSignServer
    ;;
    esac
fi
}

function start_QSignServer(){
function input(){
echo -e ${white}"====="${green}白狐-QSignServer${white}"====="${background}
echo -e ${cyan}请选择您想让您签名服务器适配的QQ版本${background}
echo -e  ${green}1.  ${cyan}8.9.58${background}
echo -e  ${green}2.  ${cyan}8.9.63${background}
echo -e  ${green}3.  ${cyan}8.9.68${background}
echo -e  ${green}4.  ${cyan}8.9.70${background}
echo "========================="
echo -en ${green}请输入您的选项: ${background};read num
}
if [ -d $HOME/.fox@bot/Yunzai-Bot ]
then
icqq=$(grep version $HOME/Yunzai-Bot/node_modules/icqq/package.json | awk '{print $2}' | sed 's/\"//g' | sed 's/,//g')
    if [ "${icqq}" = "0.4.11" ]
    then
        num=3
    elif [ "${icqq}" = "0.4.12" ]
    then
        num=4
    else
        input
    fi
else
    input
fi
case ${num} in
1|8.9.58)
export version=8.9.58
;;
2|8.9.63)
export version=8.9.63
;;
3|8.9.68)
export version=8.9.68
;;
4|8.9.70)
export version=8.9.70
;;
*)
echo
echo -e ${red}输入错误${background}
exit
;;
esac
if [ ! -d $HOME/QSignServer/qsign${QSIGN_VERSION} ];then
echo -e ${yellow}您未安装过该版本的签名服务器${background}
exit
fi
cd $HOME/QSignServer
if tmux ls | grep -q qsign${QSIGN_VERSION} ;then
    echo -en ${yellow}签名服务器已经启动,是否打开日志 [Y/n]${background};read num
      case $num in
     Y|y)
       tail -f qsign.log
       echo
       ;;
       esac
else
    tmux new -s qsign${QSIGN_VERSION} "bash qsign${QSIGN_VERSION}/bin/unidbg-fetch-qsign --basePath=$HOME/QSignServer/txlib/${version}" | tee qsign.log
    echo
    echo -en ${yellow}签名服务器已经启动,是否打开日志 [Y/n]${background};read num
    case $num in
     Y|y)
       tail -f qsign.log
       echo
       ;;
       esac
fi
echo -en ${yellow}回车返回${background};read
}

function stop_QSignServer(){
tmux kill-session -t qsign${QSIGN_VERSION}
echo -e ${yellow}停止完成 回车返回${background};read
}

function restart_QSignServer(){
pm2 restart qsign${QSIGN_VERSION}
echo -e ${yellow}重启完成 回车返回${background};read
}

function update_QSignServer(){
rm -rf $HOME/QSignServer/txlib
rm -rf $HOME/QSignServer/qsign*
mkdir -p $HOME/QSignServer/txlib
git clone --depth=1 https://gitee.com/baihu433/unidbg-fetch-qsign-onekey
rm -rf $HOME/QSignServer/txlib
mv -f unidbg-fetch-qsign-onekey/txlib $HOME/QSignServer/txlib
rm -rf unidbg-fetch-qsign
until wget -O qsign.zip -c ${QSIGN_URL}
  do
    echo -e ${red}下载失败 ${green}正在重试${background}
  done
echo -e ${yellow}正在解压qsign文件压缩包${background}
    unzip -q qsign.zip -d qsign
    mv $HOME/qsign/$(ls qsign) $HOME/QSignServer/qsign${QSIGN_VERSION}
    rm -rf qsign.zip
    rm -rf qsign
    rm -rf $HOME/QSignServer/qsign${QSIGN_VERSION}/txlib 2&> /dev/null
echo -en ${yellow}更新完成 回车返回${background};read
}

function uninstall_QSignServer(){
cd $HOME
echo -e ${yellow}正在停止服务器运行${background}
pm2 stop qsign${QSIGN_VERSION}
pm2 delete qsign${QSIGN_VERSION}
rm -rf $HOME/QSignServer 2&> /dev/null
rm -rf $HOME/QSignServer 2&> /dev/null
Version="${red}[未部署]"
}

function key_QSignServer(){
echo -en ${green}请输入更改后的key: ${background};read key_
if [ -z "${key_}" ]; then
    echo -en ${red}输入错误 回车返回${background};read
    return
fi
for file in $(ls $HOME/QSignServer/txlib)
do
file="$HOME/QSignServer/txlib/${file}/config.json"
key="$(grep -E key ${file} | awk '{print $2}' | sed "s/\"//g" | sed "s/,//g" )"
sed -i "s/\"key\": \"${key}\"/\"key\": ${key_}/g" ${file}
done
echo -en ${yellow}更改完成 回车返回${background};read
}

function port_QSignServer(){
echo -en ${green}请输入更改后的端口号: ${background};read port_
if [ -z "${port_}" ]; then
    echo -en ${red}输入错误 回车返回${background};read
    return
fi
for folder in $(ls $HOME/QSignServer/txlib)
do
file="$HOME/QSignServer/txlib/${folder}/config.json"
port="$(grep -E port ${file} | awk '{print $2}' | sed "s/\"//g" | sed "s/://g" )"
sed -i "s/\"port\": ${port}/\"port\": ${port_}/g" ${file}
done
echo -en ${yellow}更改完成 回车返回${background};read
}

function link_QSignServer(){
if [ ! -d $HOME/QSignServer/qsign${QSIGN_VERSION} ];then
    echo -en ${red}您还没有部署签名服务器!!! ${cyan}回车返回${background};read
    return
fi
echo -e ${green}您的各版本API链接${background}
echo
for folder in $(ls $HOME/QSignServer/txlib)
do
file="$HOME/QSignServer/txlib/${folder}/config.json"
port="$(grep -E port ${file} | awk '{print $2}' | sed "s/\"//g" | sed "s/://g" )"
key="$(grep -E key ${file} | awk '{print $2}' | sed "s/\"//g" | sed "s/,//g" )"
host="$(grep -E host ${file} | awk '{print $2}' | sed "s/\"//g" | sed "s/,//g" )"
echo -e ${green}${folder}: ${cyan}"http://""${host}":"${port}"/sign?key="${key}"${background}
echo
done
echo -en ${yellow}回车返回${background};read
}

function help_QSignServer(){
echo -e ${green}1. ${cyan}先启动签名服务器,再写入签名服务器地址,最后启动机器人${background}
echo -e ${green}2. ${cyan}已经启动签名服务器,然后才能使用重启签名服务器,不然请使用启动签名服务器${background}

echo -en ${yellow}回车返回${background};read
}

if [ -d $HOME/QSignServer/qsign${QSIGN_VERSION} ];then
    if tmux ls | grep qsign${QSIGN_VERSION};then
        condition="${cyan}[已启动]"
    else
        condition="${red}[未启动]"
    fi
fi

if [ -d $HOME/QSignServer/qsign* ];then  
        Version="${cyan}[$(ls $HOME/QSignServer | grep qsign | sed "s/qsign//g" | sed "s/.\B/&./g")]"
        if [ ! "${QSIGN_VERSION}" = $(ls $HOME/QSignServer | grep qsign | sed "s/qsign//g") ];then
            Version="${red}{Version} [请更新]"
        fi
else
        Version="${red}[未部署]"
fi

echo -e ${white}"====="${green}白狐-QSignServer${white}"====="${background}
echo -e  ${green}1.  ${cyan}安装签名服务器${background}
echo -e  ${green}2.  ${cyan}启动签名服务器${background}
echo -e  ${green}3.  ${cyan}关闭签名服务器${background}
echo -e  ${green}4.  ${cyan}重启签名服务器${background}
echo -e  ${green}5.  ${cyan}更新签名服务器${background}
echo -e  ${green}6.  ${cyan}卸载签名服务器${background}
echo -e  ${green}7.  ${cyan}修改签名服务器key值${background}
echo -e  ${green}8.  ${cyan}修改签名服务器端口${background}
echo -e  ${green}9.  ${cyan}清理签名服务器日志${background}
echo -e  ${green}10.  ${cyan}查看签名服务器链接${background}
echo -e  ${green}11.  ${cyan}打开签名服务器帮助${background}
echo -e  ${green}0.  ${cyan}退出${background}
echo "========================="
echo -e ${green}您的签名服务器状态: ${condition}${background}
echo -e ${green}当前签名服务器版本: ${Version}${background}
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
5)
echo
update_QSignServer
;;
6)
echo
uninstall_QSignServer
;;
7)
echo
key_QSignServer
;;
8)
port_QSignServer
;;
9)
echo
pm2 flush qsign
;;
10)
echo
link_QSignServer
;;
11)
echo
help_QSignServer
;;
test)
test_QSignServer
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