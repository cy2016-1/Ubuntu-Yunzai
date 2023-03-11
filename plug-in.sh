#!/bin/bash

function debian()
{
if ! [ -x "$(command -v whiptail)" ];then
    echo -e "\033[36m检测到未安装whiptail 开始安装 \033[0m";
    apt update -y
    apt install whiptail -y
fi
}
function ubuntu()
{
if ! [ -x "$(command -v whiptail)" ];then
    echo -e "\033[36m检测到未安装whiptail 开始安装 \033[0m";
    apt update -y
    apt install whiptail -y
fi
}
function centos()
{
if ! [ -x "$(command -v whiptail)" ];then
    echo -e "\033[36m检测到未安装whiptail 开始安装 \033[0m";
    yum update -y
    yum install whiptail -y
fi
}
function archlinux()
{
if ! [ -x "$(command -v whiptail)" ];then
    echo -e "\033[36m检测到未安装whiptail 开始安装 \033[0m";
    pacman -Syu
    pacman -S whiptail
fi
}

function Linux(){

if [ -d "/root/Yunzai-Bot" ];then
path="/root/Yunzai-Bot"
elif [ -d "/home/Yunzai-Bot" ];then
path="/home/Yunzai-Bot"
elif [ -d "/home/lighthouse/ubuntu/Yunzai-Bot" ];then
path="/home/lighthouse/ubuntu/Yunzai-Bot"
elif [ -d "/home/lighthouse/centos/Yunzai-Bot" ];then
path="/home/lighthouse/centos/Yunzai-Bot"
elif [ -d "/home/lighthouse/debian/Yunzai-Bot" ];then
path="/home/lighthouse/debian/Yunzai-Bot"
elif [ -d "/home/lighthouse/debian/Yunzai-Bot" ];then
path="/home/lighthouse/debian/Yunzai-Bot"
elif [ -d "/root/TRSS_Yunzai/Yunzai" ];then
path="/root/TRSS_Yunzai/Yunzai"
else
whiptail --title "白狐≧▽≦" --msgbox "
您还没有安装云崽 禁止安装插件
" 10 43
exit
fi
while true
do
pushd ${path}
plugin=$(whiptail \
--title "白狐-QQ群:705226976" \
--menu "35个插件" \
23 50 15 \
"1" "miao-plugin                  喵喵插件" \
"2" "xiaoyao-cvs-plugin           逍遥图鉴" \
"3" "Guoba-Plugin                 锅巴插件" \
"4" "zhi-plugin                   白纸插件" \
"5" "xitian-plugin                戏天插件" \
"6" "Akasha-Terminal-plugin       虚空插件" \
"7" "Xiuxian-Plugin-Box           修仙插件" \
"8" "Yenai-Plugin                 椰奶插件" \
"9" "xiaofei-plugin               小飞插件" \
"10" "earth-k-plugin               土块插件" \
"11" "py-plugin                    py插件" \
"12" "xianxin-plugin               闲心插件" \
"13" "lin-plugin                   麟插件" \
"14" "l-plugin                     L插件" \
"15" "qianyu-plugin                千羽插件" \
"16" "yunzai-c-v-plugin            清凉图插件" \
"17" "flower-plugin                抽卡插件" \
"18" "auto-plugin                  自动化插件" \
"19" "recreation-plugin            娱乐插件" \
"20" "suiyue-plugin                碎月插件" \
"21" "windoge-plugin               风歌插件" \
"22" "Atlas                        原神图鉴" \
"23" "zhishui-plugin               止水插件" \
"24" "TRSS-Plugin                  trss插件" \
"25" "Jinmaocuicuisha              脆脆鲨插件" \
"26" "alemon-plugin                半柠檬插件" \
"27" "liulian-plugin               榴莲插件" \
"28" "xiaoye-plugin                小叶插件" \
"29" "rconsole-plugin              R插件" \
"30" "expand-plugin                扩展插件" \
"31" "XiaoXuePlugin                小雪插件" \
"32" "Icepray                      冰祈插件" \
"33" "xiuxian-emulator-plugin      绝云间修仙" \
"34" "Tlon-Sky                     光遇插件" \
"35" "hs-qiqi-plugin               枫叶插件" \
3>&1 1>&2 2>&3)
feedback=$?

if [ $feedback = 0 ]
then
#喵喵插件
if [[ ${plugin} = 1 ]];then
 if [ -d ${path}/plugins/miao-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除喵喵插件" \
    10 60);then
    echo -e "\033[34m 正在删除喵喵插件 \033[0m";
    rm -rf ${path}/plugins/miao-plugin
    rm -rf ${path}/plugins/miao-plugin
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://gitee.com/yoimiya-kokomi/miao-plugin.git
    " 10 60
  echo "=================================="
  echo "正在安装喵喵插件，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 https://gitee.com/yoimiya-kokomi/miao-plugin.git ./plugins/miao-plugin/
  pnpm install -P
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi
#逍遥图鉴
if [[ ${plugin} = 2 ]];then
if [ -d ${path}/plugins/xiaoyao-cvs-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除逍遥图鉴" \
    10 60);then
    echo -e "\033[34m 正在删除逍遥图鉴 \033[0m";
    rm -rf ${path}/plugins/xiaoyao-cvs-plugin
    rm -rf ${path}/plugins/xiaoyao-cvs-plugin
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://gitee.com/Ctrlcvs/xiaoyao-cvs-plugin
    " 10 60
  echo "=================================="
  echo "正在安装逍遥图鉴，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 https://gitee.com/Ctrlcvs/xiaoyao-cvs-plugin.git ./plugins/xiaoyao-cvs-plugin/
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi
#锅巴插件
if [[ ${plugin} = 3 ]];then
 if [ -d ${path}/plugins/Guoba-Plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除锅巴插件" \
    10 60);then
    echo -e "\033[34m 正在删除锅巴插件 \033[0m";
    rm -rf ${path}/plugins/Guoba-Plugin
    rm -rf ${path}/plugins/Guoba-Plugin
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://gitee.com/guoba-yunzai/guoba-plugin
    " 10 60
  echo "=================================="
  echo "正在安装锅巴插件，稍安勿躁～"
  echo "==================================" 
  git clone --depth=1 https://gitee.com/guoba-yunzai/guoba-plugin.git ./plugins/Guoba-Plugin
  pnpm install --filter=guoba-plugin
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 4 ]];then
 if [ -d ${path}/plugins/zhi-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除白纸插件" \
    10 60);then
    echo -e "\033[34m 正在删除白纸插件 \033[0m";
    rm -rf ${path}/plugins/zhi-plugin
    rm -rf ${path}/plugins/zhi-plugin
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://gitee.com/headmastertan/zhi-plugin
    " 10 60
  echo "=================================="
  echo "正在安装白纸插件，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 https://gitee.com/headmastertan/zhi-plugin.git ./plugins/zhi-plugin/
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 5 ]];then
 if [ -d ${path}/plugins/xitian-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除戏天插件[注:插件备份也会一并删除]" \
    10 60);then
    echo -e "\033[34m 正在删除戏天插件 \033[0m";
    rm -rf ${path}/plugins/xitian-plugin
    rm -rf ${path}/plugins/xitian-plugin
    rm -rf ${path}/plugins/bin
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://gitee.com/XiTianGame/xitian-plugin
    " 10 60
  echo "=================================="
  echo "正在安装戏天插件，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 https://gitee.com/XiTianGame/xitian-plugin.git ./plugins/xitian-plugin
  mkdir ${path}/plugins/bin
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 6 ]];then
 if [ -d ${path}/plugins/akasha-terminal-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除虚空插件" \
    10 60);then
    echo -e "\033[34m 正在删除虚空插件 \033[0m";
    rm -rf ${path}/plugins/akasha-terminal-plugin
    rm -rf ${path}/plugins/akasha-terminal-plugin
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://gitee.com/go-farther-and-farther/akasha-terminal-plugin
     " 10 60
  echo "=================================="
  echo "正在安装虚空插件，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 https://gitee.com/go-farther-and-farther/akasha-terminal-plugin.git ./plugins/akasha-terminal-plugin
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 7 ]];then
 if [ -d ${path}/plugins/Xiuxian-Plugin-Box ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除修仙插件" \
    10 60);then
    echo -e "\033[34m 正在删除修仙插件 \033[0m";
    rm -rf ${path}/plugins/xiuxian-plugin
    rm -rf ${path}/plugins/xiuxian-plugin
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://gitee.com/ningmengchongshui/Xiuxian-Plugin-Box
    " 10 60
  echo "=================================="
  echo "正在安装修仙插件，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 https://gitee.com/ningmengchongshui/Xiuxian-Plugin-Box.git ./plugins/xiuxian-plugin
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 8 ]];then
 if [ -d ${path}/plugins/yenai-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除椰奶插件" \
    10 60);then
    echo -e "\033[34m 正在删除椰奶插件 \033[0m";
    rm -rf ${path}/plugins/yenai-plugin
    rm -rf ${path}/plugins/yenai-plugin
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://gitee.com/yeyang52/yenai-plugin
    " 10 60
  echo "=================================="
  echo "正在安装椰奶插件，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 https://gitee.com/yeyang52/yenai-plugin.git ./plugins/yenai-plugin
  pnpm add systeminformation cheerio -w
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 9 ]];then
 if [ -d ${path}/plugins/xiaofei-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除小飞插件" \
    10 60);then
    echo -e "\033[34m 正在删除小飞插件 \033[0m";
    rm -rf ${path}/plugins/xiaofei-plugin
    rm -rf ${path}/plugins/xiaofei-plugin
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://gitee.com/xfdown/xiaofei-plugin
    " 10 60
  echo "=================================="
  echo "正在安装小飞插件，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 https://gitee.com/xfdown/xiaofei-plugin.git ./plugins/xiaofei-plugin
  pnpm add axios -w
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 10 ]];then
 if [ -d ${path}/plugins/earth-k-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除土块插件" \
    10 60);then
    echo -e "\033[34m 正在删除土块插件 \033[0m";
    rm -rf ${path}/plugins/earth-k-plugin
    rm -rf ${path}/plugins/earth-k-plugin
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://gitee.com/SmallK111407/earth-k-plugin
    " 10 60
  echo "=================================="
  echo "正在安装土块插件，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 https://gitee.com/SmallK111407/earth-k-plugin.git ./plugins/earth-k-plugin
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 11 ]];then
 if [ -d ${path}/plugins/py-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除py插件" \
    10 60);then
    echo -e "\033[34m 正在删除py插件 \033[0m";
    rm -rf ${path}/plugins/py-plugin
    rm -rf ${path}/plugins/py-plugin
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://gitee.com/realhuhu/py-plugin
    " 10 60
  echo "=================================="
  echo "正在安装py插件，稍安勿躁～"
  echo "=================================="
  if ! [ -x "$(command -v poetry)" ];then
  echo -en "\033[31m 你还没有安装poetry呢 回车返回 \033[0m";read -p ""
  exit
  fi
  git clone --depth=1 https://gitee.com/realhuhu/py-plugin ./plugins/py-plugin
  pushd ${path}/plugins/py-plugin
  pnpm install iconv-lite @grpc/grpc-js @grpc/proto-loader -w
  poetry install
  poetry install
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 12 ]];then
 if [ -d ${path}/plugins/xianxin-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除闲心插件插件" \
    10 60);then
    echo -e "\033[34m 正在删除闲心插件 \033[0m";
    rm -rf ${path}/plugins/xianxin-plugin 
    rm -rf ${path}/plugins/xianxin-plugin 
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://gitee.com/xianxincoder/xianxin-plugin
    " 10 60
  echo "=================================="
  echo "正在安装闲心插件，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 https://gitee.com/xianxincoder/xianxin-plugin.git ./plugins/xianxin-plugin
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 13 ]];then
 if [ -d ${path}/plugins/lin-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除麟插件" \
    10 60);then
    echo -e "\033[34m 正在删除麟插件 \033[0m";
    rm -rf ${path}/plugins/lin-plugin
    rm -rf ${path}/plugins/lin-plugin
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://gitee.com/go-farther-and-farther/lin-plugin.git
    " 10 60
  echo "=================================="
  echo "正在安装麟插件，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 https://gitee.com/go-farther-and-farther/lin-plugin.git ./plugins/lin-plugin/
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 14 ]];then
 if [ -d ${path}/plugins/l-plugin/ ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除L插件" \
    10 60);then
    echo -e "\033[34m 正在删除L插件 \033[0m";
    rm -rf ${path}/plugins/l-plugin
    rm -rf ${path}/plugins/l-plugin
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://github.com/liuly0322/l-plugin
    " 10 60
  echo "=================================="
  echo "正在安装L插件，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 ${ghproxy}https://github.com/liuly0322/l-plugin.git ./plugins/l-plugin
  pnpm install -P
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 15 ]];then
 if [ -d ${path}/plugins/qianyu-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除千羽插件" \
    10 60);then
    echo -e "\033[34m 正在删除千羽插件 \033[0m";
    rm -rf ${path}/plugins/qianyu-plugin
    rm -rf ${path}/plugins/qianyu-plugin
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://gitee.com/think-first-sxs/qianyu-plugin
    " 10 60
  echo "=================================="
  echo "正在安装千羽插件，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 https://gitee.com/think-first-sxs/qianyu-plugin.git ./plugins/qianyu-plugin/
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 16 ]];then
 if [ -d ${path}/plugins/yunzai-c-v-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除清凉图插件" \
    10 60);then
    echo -e "\033[34m 正在删除清凉图插件 \033[0m";
    rm -rf ${path}/plugins/yunzai-c-v-plugin
    rm -rf ${path}/plugins/yunzai-c-v-plugin
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://gitee.com/xwy231321/yunzai-c-v-plugin
    " 10 60
  echo "=================================="
  echo "正在安装清凉图插件，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 https://gitee.com/xwy231321/yunzai-c-v-plugin.git ./plugins/yunzai-c-v-plugin/
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 17 ]];then
 if [ -d ${path}/plugins/flower-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除抽卡插件" \
    10 60);then
    echo -e "\033[34m 正在删除抽卡插件 \033[0m";
    rm -rf ${path}/plugins/flower-plugin
    rm -rf ${path}/plugins/flower-plugin
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://gitee.com/Nwflower/flower-plugin
    " 10 60
  echo "=================================="
  echo "正在安装抽卡插件，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 https://gitee.com/Nwflower/flower-plugin.git ./plugins/flower-plugin/
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 18 ]];then
 if [ -d ${path}/plugins/auto-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除自动化插件" \
    10 60);then
    echo -e "\033[34m 正在删除自动化插件 \033[0m";
    rm -rf ${path}/plugins/auto-plugin
    rm -rf ${path}/plugins/auto-plugin
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://gitee.com/Nwflower/auto-plugin
    " 10 60
  echo "=================================="
  echo "正在安装自动化插件，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 https://gitee.com/Nwflower/auto-plugin.git ./plugins/auto-plugin/
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 19 ]];then
 if [ -d ${path}/plugins/recreation-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除娱乐插件" \
    10 60);then
    echo -e "\033[34m 正在删除娱乐插件 \033[0m";
    rm -rf ${path}/plugins/recreation-plugin
    rm -rf ${path}/plugins/recreation-plugin
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://github.com/Cold-666/recreation-plugin
    " 10 60
  echo "=================================="
  echo "正在安装娱乐插件，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 https://gitee.com/zzyAJohn/recreation-plugin ./plugins/recreation-plugin/
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 20 ]];then
 if [ -d ${path}/plugins/suiyue ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除碎月插件" \
    10 60);then
    echo -e "\033[34m 正在删除碎月插件 \033[0m";
    rm -rf ${path}/plugins/suiyue
    rm -rf ${path}/plugins/suiyue
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://gitee.com/Acceleratorsky/suiyue.git
    " 10 60
  echo "=================================="
  echo "正在安装碎月插件，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 https://gitee.com/Acceleratorsky/suiyue.git ./plugins/suiyue
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 21 ]];then
 if [ -d ${path}/plugins/windoge-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除风歌插件" \
    10 60);then
    echo -e "\033[34m 正在删除风歌插件 \033[0m";
    rm -rf ${path}/plugins/windoge-plugin
    rm -rf ${path}/plugins/windoge-plugin
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://github.com/gxy12345/windoge-plugin
    " 10 60
  echo "=================================="
  echo "正在安装风歌插件，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 ${ghproxy}https://github.com/gxy12345/windoge-plugin ./plugins/windoge-plugin/
  pnpm install --filter=windoge-plugin
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 22 ]];then
 if [ -d ${path}/plugins/Atlas ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除Atlas图鉴" \
    10 60);then
    echo -e "\033[34m 正在删除Atlas图鉴 \033[0m";
    rm -rf ${path}/plugins/Atlas
    rm -rf ${path}/plugins/Atlas
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://gitee.com/Nwflower/atlas
    " 10 60
  echo "=================================="
  echo "正在安装Atlas[图鉴]插件，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 https://gitee.com/Nwflower/atlas ./plugins/Atlas/
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 23 ]];then
 if [ -d ${path}/plugins/zhishui-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除止水插件" \
    10 60);then
    echo -e "\033[34m 正在删除止水 \033[0m";
    rm -rf ${path}/plugins/zhishui-plugin
    rm -rf ${path}/plugins/zhishui-plugin
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://gitee.com/fjcq/zhishui-plugin
    " 10 60
  echo "=================================="
  echo "正在安装止水插件，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 https://gitee.com/fjcq/zhishui-plugin.git ./plugins/zhishui-plugin
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 24 ]];then
 if [ -d ${path}/plugins/TRSS-Plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除trss插件" \
    10 60);then
    echo -e "\033[34m 正在删除trss插件 \033[0m";
    rm -rf ${path}/plugins/TRSS-Plugin
    rm -rf ${path}/plugins/TRSS-Plugin
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://gitee.com/TimeRainStarSky/TRSS-Plugin
    " 10 60
  echo "=================================="
  echo "正在安装trss插件，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 https://gitee.com/TimeRainStarSky/TRSS-Plugin ./plugins/TRSS-Plugin
  pnpm install -P
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 25 ]];then
 if [ -d ${path}/plugins/Jinmaocuicuisha-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除脆脆鲨插件" \
    10 60);then
    echo -e "\033[34m 正在删除脆脆鲨插件 \033[0m";
    rm -rf ${path}/plugins/Jinmaocuicuisha-plugin
    rm -rf ${path}/plugins/Jinmaocuicuisha-plugin
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://gitee.com/JMCCS/jinmaocuicuisha
    " 10 60
  echo "=================================="
  echo "正在安装脆脆鲨插件，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 https://gitee.com/JMCCS/jinmaocuicuisha.git ./plugins/Jinmaocuicuisha-plugin
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 26 ]];then
 if [ -d ${path}/plugins/alemon-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除半柠檬插件" \
    10 60);then
    echo -e "\033[34m 正在删除半柠檬插件 \033[0m";
    rm -rf ${path}/plugins/alemon-plugin
    rm -rf ${path}/plugins/alemon-plugin
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://gitee.com/ningmengchongshui/alemon-plugin
    " 10 60
  echo "=================================="
  echo "正在安装半柠檬插件，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 https://gitee.com/ningmengchongshui/alemon-plugin.git ./plugins/alemon-plugin/
  pushd plugins/alemon-plugin
  pnpm install -P
  pushd ${path}/Yunzai-Bot
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 27 ]];then
 if [ -d ${path}/plugins/liulian-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除榴莲插件" \
    10 60);then
    echo -e "\033[34m 正在删除榴莲插件 \033[0m";
    rm -rf ${path}/plugins/liulian-plugin
    rm -rf ${path}/plugins/liulian-plugin
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://gitee.com/huifeidemangguomao/liulian-plugin
    " 10 60
  echo "=================================="
  echo "正在安装榴莲插件，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 https://gitee.com/huifeidemangguomao/liulian-plugin.git ./plugins/liulian-plugin/
  pnpm install axios image-size -w
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 28 ]];then
 if [ -d ${path}/plugins/xiaoye-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除小叶插件" \
    10 60);then
    echo -e "\033[34m 正在删除小叶插件 \033[0m";
    rm -rf ${path}/plugins/xiaoye-plugin
    rm -rf ${path}/plugins/xiaoye-plugin
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://gitee.com/xiaoye12123/xiaoye-plugin
    " 10 60
  echo "=================================="
  echo "正在安装小叶插件，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 https://gitee.com/xiaoye12123/xiaoye-plugin.git ./plugins/xiaoye-plugin/
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 29 ]];then
 if [ -d ${path}/plugins/rconsole-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除R插件" \
    10 60);then
    echo -e "\033[34m 正在删除R插件 \033[0m";
    rm -rf ${path}/plugins/rconsole-plugin
    rm -rf ${path}/plugins/rconsole-plugin
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://gitee.com/kyrzy0416/rconsole-plugin
    " 10 60
  echo "=================================="
  echo "正在安装R插件，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 https://gitee.com/kyrzy0416/rconsole-plugin.git ./plugins/rconsole-plugin/
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 30 ]];then
 if [ -d ${path}/plugins/expand-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除扩展插件" \
    10 60);then
    echo -e "\033[34m 正在删除扩展插件 \033[0m";
    rm -rf ${path}/plugins/expand-plugin
    rm -rf ${path}/plugins/expand-plugin
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://gitee.com/SmallK111407/expand-plugin
    " 10 60
  echo "=================================="
  echo "正在安装扩展插件，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 https://gitee.com/SmallK111407/expand-plugin.git ./plugins/expand-plugin/
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 31 ]];then
 if [ -d ${path}/plugins/XiaoXuePlugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除小雪插件" \
    10 60);then
    echo -e "\033[34m 正在删除小雪插件 \033[0m";
    rm -rf ${path}/plugins/XiaoXuePlugin
    rm -rf ${path}/plugins/XiaoXuePlugin
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://gitee.com/XueWerY/XiaoXuePlugin
    " 10 60
  echo "=================================="
  echo "正在安装小雪插件，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 https://gitee.com/XueWerY/XiaoXuePlugin.git ./plugins/XiaoXuePlugin/
  pushd plugins/XiaoXuePlugin/
  pnpm install -P
  pushd ${path}/Yunzai-Bot
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 32 ]];then
 if [ -d ${path}/plugins/Icepray ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除冰祈插件" \
    10 60);then
    echo -e "\033[34m 正在删除冰祈插件 \033[0m";
    rm -rf ${path}/plugins/Icepray
    rm -rf ${path}/plugins/Icepray
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://gitee.com/koinori/Icepray
    " 10 60
  echo "=================================="
  echo "正在安装冰祈插件，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 https://gitee.com/koinori/Icepray.git ./plugins/Icepray
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 33 ]];then
 if [ -d ${path}/plugins/xiuxian-emulator-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除绝云间修仙" \
    10 60);then
    echo -e "\033[34m 正在删除绝云间修仙 \033[0m";
    rm -rf ${path}/plugins/xiuxian-emulator-plugin
    rm -rf ${path}/plugins/xiuxian-emulator-plugin
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://gitee.com/hutao222/DDZS-XIUXIAN-V1.2.4
    " 10 60
  echo "=================================="
  echo "正在安装绝云间修仙，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 https://gitee.com/hutao222/DDZS-XIUXIAN-V1.2.4/.git ./plugins/xiuxian-emulator-plugin/
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 34 ]];then
 if [ -d ${path}/plugins/Tlon-Sky ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除光遇插件" \
    10 60);then
    echo -e "\033[34m 正在删除光遇插件 \033[0m";
    rm -rf ${path}/plugins/Tlon-Sky
    rm -rf ${path}/plugins/Tlon-Sky
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://gitee.com/Tloml-Starry/Tlon-Sky
    " 10 60
  echo "=================================="
  echo "正在安装光遇插件，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 https://gitee.com/Tloml-Starry/Tlon-Sky.git ./plugins/Tlon-Sky/
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 35 ]];then
 if [ -d ${path}/plugins/hs-qiqi-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除枫叶插件插件" \
    10 60);then
    echo -e "\033[34m 正在删除枫叶插件 \033[0m";
    rm -rf ${path}/plugins/hs-qiqi-plugin
    rm -rf ${path}/plugins/hs-qiqi-plugin
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://gitee.com/kesally/hs-qiqi-cv-plugin.git
    " 10 60
  echo "=================================="
  echo "正在安装枫叶插件，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 https://gitee.com/kesally/hs-qiqi-cv-plugin.git ./plugins/hs-qiqi-plugin
  echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

else
exit
fi
done
}

function Other_Linux(){
if ! [ -d Yunzai-Bot/plugins ];then
echo -e "\033[31m未在此目录下找到Yunzai-Bot的插件文件夹 \033[36m回车退出\033[0m"; read -p ""
exit
fi
pushd Yunzai-Bot
function baihu()
{
green="\033[32m"
blue="\033[34m"
background="\033[0m"
echo -e ${green}1.  ${blue}miao-plugin                 喵喵插件${background}
echo -e ${green}2.  ${blue}xiaoyao-cvs-plugin           逍遥图鉴${background}
echo -e ${green}3.  ${blue}Guoba-Plugin                锅巴插件${background}
echo -e ${green}4.  ${blue}zhi-plugin                    白纸插件${background}
echo -e ${green}5.  ${blue}xitian-plugin                 戏天插件${background}
echo -e ${green}6.  ${blue}Akasha-Terminal-plugin       虚空插件${background}
echo -e ${green}7.  ${blue}Xiuxian-Plugin-Box           修仙插件${background}
echo -e ${green}8.  ${blue}Yenai-Plugin                 椰奶插件${background}
echo -e ${green}9.  ${blue}xiaofei-plugin                小飞插件${background}
echo -e ${green}10. ${blue}earth-k-plugin               土块插件${background}
echo -e ${green}11. ${blue}py-plugin                    py插件${background}
echo -e ${green}12. ${blue}xianxin-plugin                闲心插件${background}
echo -e ${green}13. ${blue}lin-plugin                    麟插件${background}
echo -e ${green}14. ${blue}l-plugin                      L插件${background}
echo -e ${green}15. ${blue}qianyu-plugin                千羽插件${background}
echo -e ${green}16. ${blue}yunzai-c-v-plugin            清凉图插件${background}
echo -e ${green}17. ${blue}flower-plugin                抽卡插件${background}
echo -e ${green}18. ${blue}auto-plugin                  自动化插件${background}
echo -e ${green}19. ${blue}recreation-plugin             娱乐插件${background}
echo -e ${green}20. ${blue}suiyue-plugin                碎月插件${background}
echo -e ${green}21. ${blue}windoge-plugin              风歌插件${background}
echo -e ${green}22. ${blue}Atlas                        原神图鉴${background}
echo -e ${green}23. ${blue}zhishui-plugin                止水插件${background}
echo -e ${green}24. ${blue}TRSS-Plugin                  trss插件${background}
echo -e ${green}25. ${blue}Jinmaocuicuisha              脆脆鲨插件${background}
echo -e ${green}26. ${blue}alemon-plugin                半柠檬插件${background}
echo -e ${green}27. ${blue}liulian-plugin                 榴莲插件${background}
echo -e ${green}28. ${blue}xiaoye-plugin                小叶插件${background}
echo -e ${green}29. ${blue}rconsole-plugin               R插件${background}
echo -e ${green}30. ${blue}expand-plugin               扩展插件${background}
echo -e ${green}31. ${blue}XiaoXuePlugin                小雪插件${background}
echo -e ${green}32. ${blue}Icepray                      冰祈插件${background}
echo -e ${green}33. ${blue}xiuxian-emulator-plugin       绝云间修仙${background}
echo -e ${green}34. ${blue}Tlon-Sky                     光遇插件${background}
echo -e ${green}35. ${blue}hs-qiqi-plugin                枫叶插件${background}
echo "———————————————"
echo -e ${green}py. 修复py依赖和端口报错${background}
echo -e ${green}pyrs. py切换远程${background}
echo -e ${green}gb. 修复锅巴依赖和端口报错${background}
echo -e ${green}0. 退出插件安装${background}
echo "———————————————"
echo -e ${blue}注意脚本完全免费出现问题${background}
echo -e ${blue}请加Q群 3583757169 进行反馈${background}
echo "———————————————"
}

function ghproxy_agency(){
green="\033[32m"
blue="\033[34m"
background="\033[0m"
echo -e ${green}${Name}该项目库位于github 是否启用ghproxy镜像站 ${blue}删除[y]取消[n]:${background}
read -p "" num
        case $num in
     y)
       ghproxy="https://ghproxy.com/"
       ;;
     n)
       ghproxy=" "
       ;;
     *)
       echo -e "\033[31m请正确输入 \033[36m回车返回\033[0m" read -p ""
       ;;
  esac
}



#插件:Plugin 插件git链接:Git 插件名字:Name 依赖:Dependency
function install (){
green="\033[32m"
blue="\033[34m"
background="\033[0m"
if [ -d Yunzai-Bot/plugins/${Plugin} ]
  then
    echo -e ${green}${Name}已经安装 是否删除 ${blue}删除[y]取消[n]:${background}
        read -p "" num
        case $num in
     y)
       rm -rf Yunzai-Bot/plugins/${Plugin}
       rm -rf Yunzai-Bot/plugins/${Plugin} &>/dev/null
       ;;
     n)
       echo -e "\033[36m 取消\033[0m"
       sleep 2s
       ;;
     *)
       echo -e "\033[31m请正确输入 \033[36m回车返回\033[0m" read -p ""
       ;;
     esac
  else
    echo 建议到插件地址查看使用方法\n${git}
    sleep 2s
    echo "=================================="
    echo 正在安装${Name}，稍安勿躁～
    echo "=================================="
    git clone --depth=1 $git ./plugins/{Plugin}
    echo -e "\033[36m正在处理依赖\033[0m"
    ${Dependency}
    echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""    
fi
}


function hubai()		
{
echo;echo -en "\033[32m 请输入您需要安装插件的序号:\033[0m";read -p "" number
  case $number in  
   1)
     Name=喵喵插件 #插件中文名字
     Plugin=miao-plugin #插件名
     Git=https://gitee.com/yoimiya-kokomi/miao-plugin.git #仓库链接
     Dependency=pushd plugins/miao-plugin && pnpm install -P && pushd ../../ #依赖项
     install #调用安装
     ;;
   2)
     Name=逍遥图鉴
     Plugin=xiaoyao-cvs-plugin
     Git=https://gitee.com/Ctrlcvs/xiaoyao-cvs-plugin.git
     Dependency=echo -e "\033[32m无依赖\033[0m";echo
     install
     ;;
   3)
     Name=锅巴插件
     Plugin=Guoba-Plugin
     Git=https://gitee.com/guoba-yunzai/guoba-plugin.git
     Dependency=pnpm install --filter=guoba-plugin
     install
     ;;
   4)
     Name=白纸插件
     Plugin=zhi-plugin
     Git=https://gitee.com/headmastertan/zhi-plugin.git
     Dependency=echo -e "\033[32m无依赖\033[0m";echo
     install
     ;;
   5)
     Name=戏天插件
     Plugin=xitian-plugin
     Git=https://gitee.com/XiTianGame/xitian-plugin.git
     Dependency=echo -e "\033[32m无依赖\033[0m";echo
     install
     ;;
   6)
     Name=虚空插件
     Plugin=akasha-terminal-plugin
     Git=https://gitee.com/go-farther-and-farther/akasha-terminal-plugin.git
     Dependency=echo -e "\033[32m无依赖\033[0m";echo
     install
     ;;
   7)
     Name=修仙插件
     Plugin=xiuxian-plugin
     Git=https://gitee.com/ningmengchongshui/Xiuxian-Plugin-Box.git
     Dependency=echo -e "\033[32m无依赖\033[0m";echo
     install
     ;;
   8)
     Name=椰奶插件
     Plugin=yenai-plugin
     Git=https://gitee.com/yeyang52/yenai-plugin.git
     Dependency=pnpm add systeminformation cheerio -w
     install
     ;;
   9)
     Name=小飞插件
     Plugin=xiaofei-plugin
     Git=https://gitee.com/xfdown/xiaofei-plugin.git
     Dependency=pnpm add axios -w
     install
     ;;
   10)
     Name=土块插件
     Plugin=earth-k-plugin
     Git=https://gitee.com/SmallK111407/earth-k-plugin.git
     Dependency=echo -e "\033[32m无依赖\033[0m";echo
     install
     ;;
   11)
     if ! [ "$(uname)" == "Linux" ];then
     echo -e "\033[31m 非Linux系统 本脚本无法安装py插件 \033[0m"
     exit 0
     fi
     if ! [ -x "$(command -v poetry)" ];then
     echo -en "\033[31m 你还没有安装poetry呢 回车退出 \033[0m";read -p ""
     exit
     fi
     Name=py插件
     Plugin=py-plugin
     Git=https://gitee.com/realhuhu/py-plugin
     Dependency=pnpm install iconv-lite @grpc/grpc-js @grpc/proto-loader -w && pushd plugins/py-plugin && poetry install && poetry install && pushd ../../ 
     install
     ;;
   12)
     Name=闲心插件
     Plugin=xianxin-plugin
     Git=https://gitee.com/xianxincoder/xianxin-plugin.git
     Dependency=echo -e "\033[32m无依赖\033[0m";echo
     install
     ;;
   13)
     Name=麟插件
     Plugin=lin-plugin
     Git=https://gitee.com/go-farther-and-farther/lin-plugin.git
     Dependency=echo -e "\033[32m无依赖\033[0m";echo
     install
     ;;
   14)
     Name=L插件
     Plugin=l-plugin
     ghproxy_agency
     Git=${ghproxy}https://github.com/liuly0322/l-plugin.git
     Dependency=pushd plugins/l-plugin && pnpm install -P && pushd ../../
     install
     ;;
   15)
     Name=千羽插件
     Plugin=qianyu-plugin
     Git=https://gitee.com/think-first-sxs/qianyu-plugin.git
     Dependency=echo -e "\033[32m无依赖\033[0m";echo
     install
     ;;
   16)
     Name=清凉图插件
     Plugin=yunzai-c-v-plugin
     Git=https://gitee.com/xwy231321/yunzai-c-v-plugin.git
     Dependency=echo -e "\033[32m无依赖\033[0m";echo
     install
     ;;
   17)
     Name=抽卡插件
     Plugin=flower-plugin
     Git=https://gitee.com/Nwflower/flower-plugin.git
     Dependency=echo -e "\033[32m无依赖\033[0m";echo
     install
     ;;
   18)
     Name=自动化插件
     Plugin=auto-plugin
     Git=https://gitee.com/Nwflower/auto-plugin.git
     Dependency=echo -e "\033[32m无依赖\033[0m";echo
     install
     ;;
   19)
     Name=娱乐插件
     Plugin=recreation-plugin
     Git=https://gitee.com/zzyAJohn/recreation-plugin
     Dependency=echo -e "\033[32m无依赖\033[0m";echo
     install
     ;;
   20)
     Name=碎月插件
     Plugin=suiyue
     Git=https://gitee.com/Acceleratorsky/suiyue.git
     Dependency=echo -e "\033[32m无依赖\033[0m";echo
     install
     ;;
   21)
     Name=风歌插件
     Plugin=windoge-plugin
     ghproxy_agency
     Git=${ghproxy}https://github.com/gxy12345/windoge-plugin
     Dependency=pnpm install --filter=windoge-plugin
     install
     ;;
   22)
     Name=Atlas[图鉴]
     Plugin=Atlas
     Git=https://gitee.com/Nwflower/atlas
     Dependency=echo -e "\033[32m无依赖\033[0m";echo
     install
     ;;
   23)
     Name=止水插件
     Plugin=zhishui-plugin
     Git=https://gitee.com/fjcq/zhishui-plugin.git
     Dependency=echo -e "\033[32m无依赖\033[0m";echo
     install
     ;;
   24)
     Name=trss插件
     Plugin=TRSS-Plugin
     Git=https://gitee.com/TimeRainStarSky/TRSS-Plugin.git
     Dependency=pushd plugins/TRSS-Plugin && pnpm install -P && pushd ../../
     install
     ;;
   25)
     Name=脆脆鲨插件
     Plugin=Jinmaocuicuisha-plugin
     Git=https://gitee.com/JMCCS/jinmaocuicuisha.git
     Dependency=echo -e "\033[32m无依赖\033[0m";echo
     install
     ;;
   26)
     Name=半柠檬插件
     Plugin=alemon-plugin
     Git=https://gitee.com/ningmengchongshui/alemon-plugin.git
     Dependency=pushd plugins/alemon-plugin && pnpm install -P && pushd ../../
     install
     ;;
   27)
     Name=榴莲插件
     Plugin=liulian-plugin
     Git=https://gitee.com/huifeidemangguomao/liulian-plugin.git
     Dependency=pnpm install axios image-size -w
     install
     ;;
   28)
     Name=小叶插件
     Plugin=xiaoye-plugin
     Git=https://gitee.com/xiaoye12123/xiaoye-plugin.git
     Dependency=echo -e "\033[32m无依赖\033[0m";echo
     install
     ;;
   29)
     Name=R插件
     Plugin=rconsole-plugin
     Git=https://gitee.com/kyrzy0416/rconsole-plugin.git
     Dependency=echo -e "\033[32m无依赖\033[0m";echo
     install
     ;;
   30)
     Name=扩展插件
     Plugin=expand-plugin
     Git=https://gitee.com/SmallK111407/expand-plugin.git
     Dependency=echo -e "\033[32m无依赖\033[0m";echo
     install
     ;;
   31)
     Name=小雪插件
     Plugin=XiaoXuePlugin
     Git=https://gitee.com/XueWerY/XiaoXuePlugin.git
     Dependency=pushd plugins/XiaoXuePlugin && pnpm install -P pushd ../../
     install
     ;;
   32)
     Name=冰祈插件
     Plugin=Icepray
     Git=https://gitee.com/koinori/Icepray.git
     Dependency=echo -e "\033[32m无依赖\033[0m";echo
     install
     ;;
   33)
     Name=绝云间修仙
     Plugin=xiuxian-emulator
     Git=https://gitee.com/hutao222/DDZS-XIUXIAN-V1.2.4/.git
     Dependency=echo -e "\033[32m无依赖\033[0m";echo
     install
     ;;
   34)
     Name=光遇插件
     Plugin=Tlon-Sky
     Git=https://gitee.com/Tloml-Starry/Tlon-Sky.git
     Dependency=echo -e "\033[32m无依赖\033[0m";echo
     install
     ;;
   35)
     Name=枫叶插件
     Plugin=hs-qiqi-plugin
     Git=https://gitee.com/kesally/hs-qiqi-cv-plugin.git
     Dependency=echo -e "\033[32m无依赖\033[0m";echo
     install
     ;;
   35)
     Name=枫叶插件
     Plugin=hs-qiqi-plugin
     Git=https://gitee.com/kesally/hs-qiqi-cv-plugin.git
     Dependency=echo -e "\033[32m无依赖\033[0m";echo
     install
     ;;
   py)
     pushd plugins/py-plugin
     poetry install 
     poetry install
     function py_(){
     min=$1
     max=$(($2-$min+1))
     num=$(date +%s%N)
     echo $(($num%$max+$min))
     }
     pyport=$(py_ 40000 60000)
     sed -i "15s/.*/port: ${pyport}/g" $HOME/Yunzai-Bot/plugins/py-plugin/config.yaml
     pushd ../../
     ;;
   pyrs)
     if [ -e "$HOME/Yunzai-Bot/plugins/py-plugin/config.yaml" ]
       then
          sed -i "s/.*host.*/host: 159.75.113.47/g" $HOME/Yunzai-Bot/plugins/py-plugin/config.yaml
          echo -e "\033[36m 执行完成 \033[0m"
       else
          cp $HOME/Yunzai-Bot/plugins/py-plugin/config_default.yaml $HOME/Yunzai-Bot/plugins/py-plugin/config.yaml
          sed -i "s/.*host.*/host: 159.75.113.47/g" $HOME/Yunzai-Bot/plugins/py-plugin/config.yaml
          echo -e "\033[36m 执行完成 \033[0m"
     fi
     ;;
   gb)
     if [ -e "$HOME/Yunzai-Bot/plugins/Guoba-Plugin/config/application.yaml" ]
       then
         function gb_(){
         min=$1
         max=$(($2-$min+1))
         num=$(date +%s%N)
         echo $(($num%$max+$min))
         }
         gbport=$(gb_ 40000 60000)
         sed -i "s/.*port.*/  port: ${gbport}/g" $HOME/Yunzai-Bot/plugins/Guoba-Plugin/config/application.yaml
	     echo -e "\033[36m 端口更改完成\033[0m"
       else
     echo -e "\033[33m 文件不存在,请确认是否安装锅巴并启动过一次 \033[0m"; 
     fi
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
        baihu
        hubai
    done
}
mainbak
}

if [[ -f /etc/redhat-release ]]; then
       centos
elif grep -q -E -i "debian" /etc/issue; then
    debian
    Linux
elif grep -q -E -i "ubuntu" /etc/issue; then
    ubuntu
    Linux
elif grep -q -E -i "centos|red hat|redhat" /etc/issue; then
    centos
    Linux
elif grep -q -E -i "Arch|Manjaro" /etc/issue; then
    archlinux
    Linux
elif grep -q -E -i "debian" /proc/version; then
    debian
    Linux
elif grep -q -E -i "ubuntu" /proc/version; then
    ubuntu
    Linux
elif grep -q -E -i "centos|red hat|redhat" /proc/version; then
    centos
    Linux
else
Other_Linux
fi