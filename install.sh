#!/bin/env bash
echo -e ${yellow} - ${cyan}此脚本已停止维护${background}
echo -e ${yellow} - ${cyan}请到 ${green}https://gtiee.com/baihu433/Yunzai-Bot-Shell${cyan}获取新脚本${background}
echo -e ${yellow} - ${cyan}如有疑问 请添加QQ群聊${green}879718035 ${cyan}获取帮助${background}
exit
if [ "$(uname -o)" = "Android" ]; then
	echo "看来你是大聪明 加Q群获取帮助吧 596660282"
	exit 1
fi
#检查系统及root用户
if ! [ "$(uname)" == "Linux" ];then
echo -e "\033[31m 请使用linux! \033[0m"
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

if ! [ -e "/usr/local/bin/bh" ];then
    a=1
    function install(){
    curl -o bh https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/Yunzai-shell.sh
    mv bh /usr/local/bin/bh
    chmod +x /usr/local/bin/bh
    }
    install > /dev/null 2>&1 &
    {
       until command -v bh
        do
          a=$(($a+1))
          sleep 0.05s
          echo ${a}
        done
    } | whiptail --gauge "正在安装" 6 60 0
    if [ -x "/usr/local/bin/bh" ];then
    whiptail --title "白狐≧▽≦" --msgbox \
    "安装成功 祝您使用愉快!" \
    8 25
    fi
    Aword=`curl -s https://api.vvhan.com/api/ian`
    whiptail --title "白狐≧▽≦" --msgbox \
    "${Aword}" \
    10 50
    bh
else
    a=1
    function install(){
    curl -o bh https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/Yunzai-shell.sh
    mv bh /usr/local/bin/bh
    chmod +x /usr/local/bin/bh
    }
    install > /dev/null 2>&1 &
    {
       until command -v bh
        do
          a=$(($a+1))
          sleep 0.05s
          echo ${a}
        done
    } | whiptail --gauge "正在安装" 6 60 0
    if [ -x "/usr/local/bin/bh" ];then
    whiptail --title "白狐≧▽≦" --msgbox \
    "安装成功 祝您使用愉快!" \
    8 25
    fi
    Aword=`curl -s https://api.vvhan.com/api/ian`
    whiptail --title "白狐≧▽≦" --msgbox \
    "${Aword}" \
    10 50
    bh
fi