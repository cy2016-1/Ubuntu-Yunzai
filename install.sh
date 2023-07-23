#!/bin/env bash
if [ "$(uname -o)" = "Android" ]; then
	echo "看来你是大聪明 加Q群获取帮助吧 596660282"
	exit 1
fi
if [ -d /data/data/com.termux ];then
	echo "看来你是大聪明 加Q群获取帮助吧 596660282"
	exit 1
fi
#检查系统及root用户
if ! [ "$(uname)" == "Linux" ];then
echo -e "\033[31m 请使用linux! \033[0m"
exit 0
fi

if ! [ -f /etc/lsb-release ];then
echo -e "\033[31m 请使用ubuntu! \033[0m"
exit 0
fi

if [ "$(id -u)" != "0" ]; then
echo -e "\033[31m 请使用root用户! \033[0m"
exit 0
fi

if ! [ -x "$(command -v curl)" ];then
    echo -e "\033[36m检测到未安装curl 开始安装 \033[0m";
    apt update
    apt install curl -y
fi

if ! [ -x "$(command -v git)" ];then
    echo -e "\033[36m检测到未安装git 开始安装 \033[0m";
    apt update
    apt install git -y
fi

if ! [ -x "$(command -v whiptail)" ]
    then
    echo -e "\033[36m检测到未安装whiptail 开始安装 \033[0m";
    apt update
    apt install whiptail -y
fi

if ! [ -e "/usr/local/bin/bhyz" ];then
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
    } | whiptail --gauge "正在安装" 6 60 0
    if [ -x "/usr/local/bin/bhyz" ];then
    whiptail --title "白狐≧▽≦" --msgbox \
    "安装成功 祝您使用愉快!" \
    8 25
    fi
    Aword=`curl -s https://api.vvhan.com/api/ian`
    whiptail --title "白狐≧▽≦" --msgbox \
    "${Aword}" \
    10 50
    bhyz
else
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
    } | whiptail --gauge "正在安装" 6 60 0
    if [ -x "/usr/local/bin/bhyz" ];then
    whiptail --title "白狐≧▽≦" --msgbox \
    "安装成功 祝您使用愉快!" \
    8 25
    fi
    Aword=`curl -s https://api.vvhan.com/api/ian`
    whiptail --title "白狐≧▽≦" --msgbox \
    "${Aword}" \
    10 50
    bhyz
fi