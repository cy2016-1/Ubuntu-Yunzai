#!/bin/bash
#检查系统及root用户
if [ "$(uname)" == "Linux" ] && [ -f /etc/os-release ]; then
if grep -q "Ubuntu" /etc/os-release; then
if [ "$(whoami)" == "root" ]; then
    echo -e "\033[36m 系统及权限检查通过 \033[0m"
else
    echo -e "\033[33m 权限错误 \033[0m"
    exit 1
fi
fi
else
    echo -e "\033[33m 系统错误 \033[0m"
    exit 1
fi
#检测curl安装状态
if ! [ -x "$(command -v curl)" ];then
    echo -e "\033[36m 检测到未安装curl 开始安装 \033[0m";
    apt update
    apt install curl -y
fi
#检测wget安装状态
if ! [ -x "$(command -v wget)" ];then
    echo -e "\033[36m 检测到未安装wget 开始安装 \033[0m";
    apt update
    apt install wget -y
fi
#检测git安装状态
if ! [ -x "$(command -v git)" ];then
    echo -e "\033[36m 检测到未安装git 开始安装 \033[0m";
    apt update
    apt install git -y
fi
#检测whiptail安装状态
if ! [ -x "$(command -v whiptail)" ]
    then
    echo -e "\033[36m 检测到未安装whiptail 开始安装 \033[0m";
    apt update
    apt install whiptail -y
fi
if [ -e  "/usr/bin/bhyzt" ];then
  rm /usr/bin/bhyz
  wget -O bhyz https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/Yunzai-shell.sh >> log.txt 2>&1 &
  {
    for ((i = 0 ; i <= 100 ; i+=1)); do
      sleep 0.01s
         echo $i
      done
  } | whiptail --gauge "已安装 正在更新" 6 60 0
  mv bhyz /usr/bin
  chmod +x /usr/bin/bhyz
  rm log.txt
  bhyz
else
  wget -O bhyz https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/Yunzai-shell.sh >> log.txt 2>&1 &
  {
    for ((i = 0 ; i <= 100 ; i+=1)); do
      sleep 0.01s
         echo $i
      done
  } | whiptail --gauge "未安装 正在安装" 6 60 0
  mv bhyz /usr/bin
  chmod +x /usr/bin/bhyz
  rm log.txt
  bhyz
fi