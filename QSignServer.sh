#!/bin/env bash
function main(){
cd $HOME
if [ -d $HOME/QSignServer/jdk ];then
PATH=$PATH:$HOME/QSignServer/jdk/bin
export JAVA_HOME=$HOME/QSignServer/jdk
fi
if [ -d /usr/local/node/bin ];then
PATH=$PATH:/usr/local/node/bin
export PNPM_HOME=/usr/local/node/bin
fi
function install_QSignServer(){
case $(uname -m) in
x86_64|amd64)
JDK_URL=https://cdn.azul.com/zulu/bin/zulu8.70.0.23-ca-jdk8.0.372-linux_x64.tar.gz
;;
arm64|aarch64)
JDK_URL=https://cdn.azul.com/zulu-embedded/bin/zulu8.70.0.23-ca-jdk8.0.372-linux_aarch64.tar.gz
;;
*)
echo -e ${red}暂不支持您的系统 抱歉${background}
exit
;;
esac
if ! [ -x "$(command -v axel)" ];then
    echo -e ${yellow}安装axel下载器${background}
    until apt install -y axel
    do
      echo -e ${red}axel下载器安装失败 ${green}正在重试${background}
    done
    echo
fi
if ! [ -x "$(command -v unar)" ];then
    echo -e ${yellow}安装unar解压器${background}
    until apt install -y unar
    do
      echo -e ${red}安装unar解压器安装失败 ${green}正在重试${background}
    done
    echo
fi
if [ ! -d QSignServer ];then
    until axel -n 32 -o qsign.zip -c https://ghproxy.com/https://github.com/fuqiuluo/unidbg-fetch-qsign/releases/download/1.1.5/qsign-1.1.5.onejar.zip
    do
      echo -e ${red}下载失败 ${green}正在重试${background}
    done
    unar qsign.zip
    mkdir QSignServer
    mv unidbg-fetch-qsign-shadow-1.1.5 QSignServer/qsign
    rm -f qsign.zip
    until axel -n 32 -o jdk.tar.gz -c ${JDK_URL}
    do
      echo -e ${red}下载失败 ${green}正在重试${background}
    done
    unar jdk.tar.gz -o jdk
    rm -f jdk.tar.gz
    mv jdk/$(ls jdk) QSignServer/jdk
    rm -r jdk
    PATH=$PATH:$HOME/QSignServer/jdk/bin
    export JAVA_HOME=$HOME/QSignServer/jdk
echo "
#jdk
PATH=$PATH:$HOME/QSignServer/jdk/bin
export JAVA_HOME=$HOME/QSignServer/jdk " >> /etc/profile
fi
function binaries_nodejs_install(){
case $(uname -m) in
x86_64|amd64)
node=x64
;;
arm64|aarch64|armv8*)
node=arm64
;;
esac
if awk '{print $2}' /etc/issue | grep -q -E 22.* || grep -q -E 23.*
then
  curl -o node.tar.xz https://cdn.npmmirror.com/binaries/node/latest-v18.x/node-v18.16.0-linux-${node}.tar.xz
else
  curl -o node.tar.xz https://cdn.npmmirror.com/binaries/node/latest-v16.x/node-v16.20.0-linux-${node}.tar.xz
fi
if [ ! -d node ];then
mkdir node
fi
echo -e ${yellow}正在解压二进制文件压缩包${background}
if ! tar -xf node.tar.xz -C node ;then
  echo -e ${red}tar命令解压失败 正在安装并使用unar${background}
  if ! [ -x "$(command -v unar)" ];then
    apt install -y unar
  fi
  unar node.tar.xz -o node
fi
rm -rf /usr/local/node > /dev/null
rm -rf /usr/local/node > /dev/null
mv -f node/$(ls node) /usr/local/node
echo '
#Node.JS
export PATH=$PATH:/usr/local/node/bin
export PNPM_HOME=/usr/local/node/bin' >> /etc/profile
PATH=$PATH:/usr/local/node/bin
export PNPM_HOME=/usr/local/node/bin
source /etc/profile
rm -rf node node.tar.xz > /dev/null
rm -rf node node.tar.xz > /dev/null
}
Nodsjs_Version=$(node -v | cut -d '.' -f1)
if ! [[ "$Nodsjs_Version" == "v16" || "$Nodsjs_Version" == "v17" || "$Nodsjs_Version" == "v18" || "$Nodsjs_Version" == "v19" || "$Nodsjs_Version" == "v20" || "$Nodsjs_Version" == "v20" ]] && ! [ -x "$(command -v npm)" ];then
  echo -e ${yellow}安装nodejs和npm${background}
  a=0
  until binaries_nodejs_install
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
    echo -e ${yellow}正在使用npm安装pnpm${background}
    until npm install -g pm2
    do
      echo -e ${red}pm2安装失败 ${green}正在重试${background}
    done
    echo
fi

echo -en ${yellow}安装完成 回车返回${background};read
}

function start_QSignServer(){
if ! pm2 list | grep -q qsign ;then
    pm2 start --name qsign "bash $HOME/QSignServer/qsign/bin/unidbg-fetch-qsign --basePath=$HOME/QSignServer/qsign/txlib/8.9.68"
else
    echo -en ${yellow}签名服务器已经启动,是否打开日志 [Y/n]${background};read num
      case $num in
     Y|y)
       pm2 log
       echo
       echo -en ${cyan}回车返回${background};read
       ;;
       esac  
fi
echo -en ${yellow}启动完成 回车返回${background};read
rm -f $HOME/.pm2/logs/qsign*
}

function stop_QSignServer(){
pm2 delete qsign
}

function uninstall_QSignServer(){
cd $HOME
rm -rf $HOME/QSignServer
JDK='PATH=$PATH:$HOME/QSignServer/qsign/jdk/bin'
JAVA_HOME='export JAVA_HOME=$HOME/QSignServer/jdk'
sed -i "s/\#jdk//g" /etc/profile
sed -i "s#${JDK}##g" /etc/profile
sed -i "s#${JAVA_HOME}##g" /etc/profile
echo -en ${yellow}卸载完成 回车返回${background};read
}

function key_QSignServer(){
file="$HOME/QSignServer/qsign/txlib/8.9.63/config.json"
key=$(grep -E key ${file} | awk '{print $2}' | sed "s/\"//g" | sed "s/,//g" )
echo -en ${green}请输入您要更改的key值: ${background};read number
sed -i "s/${key}/${number}/g" ${file}
echo -en ${yellow}更改完成 回车返回${background};read
}

function port_QSignServer(){
file="$HOME/QSignServer/qsign/txlib/8.9.63/config.json"
port=$(grep -E port ${file} | awk '{print $2}' | sed "s/\"//g" | sed "s/://g" )
echo -en ${green}请输入您要更改的key值: ${background};read number
sed -i "s/${port}/${number}/g" ${file}
echo -en ${yellow}更改完成 回车返回${background};read
}

red="\033[31m"
green="\033[32m"
yellow="\033[33m"
blue="\033[34m"
purple="\033[35m"
cyan="\033[36m"
white="\033[37m"
background="\033[0m"
echo -e ${white}"====="${green}白狐-QSignServer${white}"====="${background}
echo -e  ${green}1.  ${cyan}安装签名服务器${background}
echo -e  ${green}2.  ${cyan}启动签名服务器${background}
echo -e  ${green}3.  ${cyan}关闭签名服务器${background}
#echo -e  ${green}3.  ${cyan}打开签名服务器日志${background}
echo -e  ${green}4.  ${cyan}更新签名服务器${background}
echo -e  ${green}5.  ${cyan}卸载签名服务器${background}
echo -e  ${green}6.  ${cyan}修改签名服务器key值${background}
echo -e  ${green}7.  ${cyan}修改签名服务器端口${background}
echo -e  ${green}0.  ${cyan}退出${background}
echo "========================="
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
#update_QSignServer
echo -en  ${yellow}暂时没写 回车返回${background};read
;;
5)
echo
uninstall_QSignServer
;;
6)
echo
key_QSignServer
;;
7)
echo
port_QSignServer
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