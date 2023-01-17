#!/bin/bash
lsb_release -i | grep -q "Ubuntu"
if [ $? -eq 0 ];then
  echo
else
  echo -e "\033[44m 非ubuntu系统 停止运行! \033[0m";
  exit
fi
#检测是否为root用户
if [ "$(whoami)" == "root" ];then
    echo
else
    echo -e "\033[44m 非root用户 请登录root用户后使用该脚本 \033[0m";
    exit 0
fi
#检测curl安装状态
if ! [ -x "$(command -v curl)" ];then
    echo -e "\033[44m 检测到未安装curl 开始安装 \033[0m";
    apt update
    apt install curl -y
fi
#检测wget安装状态
if ! [ -x "$(command -v wget)" ];then
    echo -e "\033[44m 检测到未安装wget 开始安装 \033[0m";
    apt update
    apt install wget -y
fi
#检测git安装状态
if ! [ -x "$(command -v wget)" ];then
    echo -e "\033[44m 检测到未安装git 开始安装 \033[0m";
    apt update
    apt install git -y
fi
#检测whiptail安装状态
if ! [ -x "$(command -v whiptail)" ]
    then
    echo -e "\033[44m 检测到未安装whiptail 开始安装 \033[0m";
    apt update
    apt install whiptail -y
fi

if [ -e "/usr/bin/txyz" ]; then 
    echo -e "\033[33m 存在旧版,执行删除安装 \033[0m";
    rm -rf /usr/bin/bhyz
    wget -O bhyz https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/Yunzai-shell.sh
    mv bhyz /usr/bin
    chmod +x /usr/bin/bhyz
else 
    echo -e "\033[33m 文件不存在,执行安装 \033[0m"; 
    rm -rf /usr/bin/bhyz
    wget -O bhyz https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/Yunzai-shell.sh
    mv bhyz /usr/bin
    chmod +x /usr/bin/bhyz
fi

echo -e "\033[33m 使用 bhyz 启动脚本 芜湖!!! \033[0m";]]