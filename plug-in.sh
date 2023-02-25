#!/bin/bash
pushd /root/Yunzai-Bot
while true
do
plugin=$(whiptail \
--title "白狐≧▽≦" \
--menu "0.1" \
20 50 13 \
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
3>&1 1>&2 2>&3 )
feedback=$?
if [ $feedback = 0 ]
then
#喵喵插件
if [[ ${plugin} = 1 ]];then
 if [ -d /root/Yunzai-Bot/plugins/miao-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除喵喵插件" \
    10 60);then
    echo -e "\033[34m 正在删除喵喵插件 \033[0m";
    rm -rf /root/Yunzai-Bot/plugins/miao-plugin
    rm -rf /root/Yunzai-Bot/plugins/miao-plugin
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
  pnpm add image-size -w
  echo;echo -e "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi
#逍遥图鉴
if [[ ${plugin} = 2 ]];then
if [ -d /root/Yunzai-Bot/plugins/xiaoyao-cvs-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除逍遥图鉴" \
    10 60);then
    echo -e "\033[34m 正在删除逍遥图鉴 \033[0m";
    rm -rf /root/Yunzai-Bot/plugins/xiaoyao-cvs-plugin
    rm -rf /root/Yunzai-Bot/plugins/xiaoyao-cvs-plugin
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
  echo;echo -e "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi
#锅巴插件
if [[ ${plugin} = 3 ]];then
 if [ -d /root/Yunzai-Bot/plugins/Guoba-Plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除锅巴插件" \
    10 60);then
    echo -e "\033[34m 正在删除锅巴插件 \033[0m";
    rm -rf /root/Yunzai-Bot/plugins/Guoba-Plugin
    rm -rf /root/Yunzai-Bot/plugins/Guoba-Plugin
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
  echo;echo -e "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 4 ]];then
 if [ -d /root/Yunzai-Bot/plugins/zhi-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除白纸插件" \
    10 60);then
    echo -e "\033[34m 正在删除白纸插件 \033[0m";
    rm -rf /root/Yunzai-Bot/plugins/zhi-plugin
    rm -rf /root/Yunzai-Bot/plugins/zhi-plugin
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
  echo;echo -e "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 5 ]];then
 if [ -d /root/Yunzai-Bot/plugins/xitian-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除戏天插件[注:插件备份也会一并删除]" \
    10 60);then
    echo -e "\033[34m 正在删除戏天插件 \033[0m";
    rm -rf /root/Yunzai-Bot/plugins/xitian-plugin
    rm -rf /root/Yunzai-Bot/plugins/xitian-plugin
    rm -rf /root/Yunzai-Bot/plugins/bin
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
  mkdir /root/Yunzai-Bot/plugins/bin
  echo;echo -e "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 6 ]];then
 if [ -d /root/Yunzai-Bot/plugins/akasha-terminal-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除虚空插件" \
    10 60);then
    echo -e "\033[34m 正在删除虚空插件 \033[0m";
    rm -rf /root/Yunzai-Bot/plugins/akasha-terminal-plugin
    rm -rf /root/Yunzai-Bot/plugins/akasha-terminal-plugin
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
  echo;echo -e "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 7 ]];then
 if [ -d /root/Yunzai-Bot/plugins/Xiuxian-Plugin-Box ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除修仙插件" \
    10 60);then
    echo -e "\033[34m 正在删除修仙插件 \033[0m";
    rm -rf /root/Yunzai-Bot/plugins/xiuxian-plugin
    rm -rf /root/Yunzai-Bot/plugins/xiuxian-plugin
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
  echo;echo -e "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 8 ]];then
 if [ -d /root/Yunzai-Bot/plugins/yenai-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除椰奶插件" \
    10 60);then
    echo -e "\033[34m 正在删除椰奶插件 \033[0m";
    rm -rf /root/Yunzai-Bot/plugins/yenai-plugin
    rm -rf /root/Yunzai-Bot/plugins/yenai-plugin
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
  echo;echo -e "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 9 ]];then
 if [ -d /root/Yunzai-Bot/plugins/xiaofei-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除小飞插件" \
    10 60);then
    echo -e "\033[34m 正在删除小飞插件 \033[0m";
    rm -rf /root/Yunzai-Bot/plugins/xiaofei-plugin
    rm -rf /root/Yunzai-Bot/plugins/xiaofei-plugin
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
  echo;echo -e "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 10 ]];then
 if [ -d /root/Yunzai-Bot/plugins/earth-k-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除土块插件" \
    10 60);then
    echo -e "\033[34m 正在删除土块插件 \033[0m";
    rm -rf /root/Yunzai-Bot/plugins/earth-k-plugin
    rm -rf /root/Yunzai-Bot/plugins/earth-k-plugin
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
  echo;echo -e "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 11 ]];then
 if [ -d /root/Yunzai-Bot/plugins/py-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除py插件" \
    10 60);then
    echo -e "\033[34m 正在删除py插件 \033[0m";
    rm -rf /root/Yunzai-Bot/plugins/py-plugin
    rm -rf /root/Yunzai-Bot/plugins/py-plugin
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
  if ! [ -x "$(command -v python3.10)" ];then
  echo -e "\033[31m 你还没有安装python呢\n 快到附加安装 安装python3.10吧\033[0m";
  exit
  exit
  fi
  if ! [ -x "$(command -v pip)" ];then
  echo -e "\033[31m 你还没有安装pip呢\n 快到附加安装 安装pip吧\033[0m";
  exit
  exit
  fi
  if ! [ -x "$(command -v poetry)" ];then
  echo -e "\033[31m 你还没有安装poetry呢\n 快到附加安装 安装poetry吧\033[0m";
  exit
  exit
  fi
  git clone --depth=1 https://gitee.com/realhuhu/py-plugin ./plugins/py-plugin
  pushd /root/Yunzai-Bot/plugins/py-plugin
  pnpm install iconv-lite @grpc/grpc-js @grpc/proto-loader -w
  poetry install
  poetry install
  echo;echo -e "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 12 ]];then
 if [ -d /root/Yunzai-Bot/plugins/plugins/xianxin-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除闲心插件插件" \
    10 60);then
    echo -e "\033[34m 正在删除闲心插件 \033[0m";
    rm -rf /root/Yunzai-Bot/plugins/xianxin-plugin 
    rm -rf /root/Yunzai-Bot/plugins/xianxin-plugin 
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
  echo;echo -e "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 13 ]];then
 if [ -d /root/Yunzai-Bot/plugins/lin-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除麟插件" \
    10 60);then
    echo -e "\033[34m 正在删除麟插件 \033[0m";
    rm -rf /root/Yunzai-Bot/plugins/lin-plugin
    rm -rf /root/Yunzai-Bot/plugins/lin-plugin
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
  echo;echo -e "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 14 ]];then
 if [ -d /root/Yunzai-Bot/plugins/plugins/l-plugin/ ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除L插件" \
    10 60);then
    echo -e "\033[34m 正在删除L插件 \033[0m";
    rm -rf /root/Yunzai-Bot/plugins/l-plugin
    rm -rf /root/Yunzai-Bot/plugins/l-plugin
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
  git clone --depth=1 https://ghproxy.com/https://github.com/liuly0322/l-plugin.git ./plugins/l-plugin
  echo;echo -e "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 15 ]];then
 if [ -d /root/Yunzai-Bot/plugins/plugins/qianyu-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除千羽插件" \
    10 60);then
    echo -e "\033[34m 正在删除千羽插件 \033[0m";
    rm -rf /root/Yunzai-Bot/plugins/qianyu-plugin
    rm -rf /root/Yunzai-Bot/plugins/qianyu-plugin
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
  echo;echo -e "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 16 ]];then
 if [ -d /root/Yunzai-Bot/plugins/plugins/yunzai-c-v-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除清凉图插件" \
    10 60);then
    echo -e "\033[34m 正在删除清凉图插件 \033[0m";
    rm -rf /root/Yunzai-Bot/plugins/yunzai-c-v-plugin
    rm -rf /root/Yunzai-Bot/plugins/yunzai-c-v-plugin
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
  echo;echo -e "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 17 ]];then
 if [ -d /root/Yunzai-Bot/plugins/plugins/flower-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除抽卡插件" \
    10 60);then
    echo -e "\033[34m 正在删除抽卡插件 \033[0m";
    rm -rf /root/Yunzai-Bot/plugins/flower-plugin
    rm -rf /root/Yunzai-Bot/plugins/flower-plugin
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
  echo;echo -e "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 18 ]];then
 if [ -d /root/Yunzai-Bot/plugins/plugins/auto-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除自动化插件" \
    10 60);then
    echo -e "\033[34m 正在删除自动化插件 \033[0m";
    rm -rf /root/Yunzai-Bot/plugins/auto-plugin
    rm -rf /root/Yunzai-Bot/plugins/auto-plugin
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
  git clone --depth=1 
  echo;echo -e "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 19 ]];then
 if [ -d /root/Yunzai-Bot/plugins/plugins/recreation-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除娱乐插件" \
    10 60);then
    echo -e "\033[34m 正在删除娱乐插件 \033[0m";
    rm -rf /root/Yunzai-Bot/plugins/recreation-plugin
    rm -rf /root/Yunzai-Bot/plugins/recreation-plugin
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
  git clone --depth=1 https://ghproxy.com/https://github.com/Cold-666/recreation-plugin.git
  echo;echo -e "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 20 ]];then
 if [ -d /root/Yunzai-Bot/plugins/plugins/suiyue ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除岁月插件" \
    10 60);then
    echo -e "\033[34m 正在删除岁月插件 \033[0m";
    rm -rf /root/Yunzai-Bot/plugins/suiyue
    rm -rf /root/Yunzai-Bot/plugins/suiyue
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://gitee.com/Acceleratorsky/suiyue.git
    " 10 60
  echo "=================================="
  echo "正在安装插件，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 https://gitee.com/Acceleratorsky/suiyue.git ./plugins/suiyue
  echo;echo -e "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 21 ]];then
 if [ -d /root/Yunzai-Bot/plugins/plugins/windoge-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除风歌插件" \
    10 60);then
    echo -e "\033[34m 正在删除风歌插件 \033[0m";
    rm -rf /root/Yunzai-Bot/plugins/windoge-plugin
    rm -rf /root/Yunzai-Bot/plugins/windoge-plugin
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
  git clone --depth=1 https://ghproxy.com/https://github.com/gxy12345/windoge-plugin
  echo;echo -e "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 22 ]];then
 if [ -d /root/Yunzai-Bot/plugins/plugins/Atlas ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除Atlas图鉴" \
    10 60);then
    echo -e "\033[34m 正在删除Atlas图鉴 \033[0m";
    rm -rf /root/Yunzai-Bot/plugins/Atlas
    rm -rf /root/Yunzai-Bot/plugins/Atlas
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
  echo;echo -e "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 23 ]];then
 if [ -d /root/Yunzai-Bot/plugins/plugins/zhishui-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除止水插件" \
    10 60);then
    echo -e "\033[34m 正在删除止水 \033[0m";
    rm -rf /root/Yunzai-Bot/plugins/zhishui-plugin
    rm -rf /root/Yunzai-Bot/plugins/zhishui-plugin
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
  echo;echo -e "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 24 ]];then
 if [ -d /root/Yunzai-Bot/plugins/plugins/TRSS-Plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除trss插件" \
    10 60);then
    echo -e "\033[34m 正在删除trss插件 \033[0m";
    rm -rf /root/Yunzai-Bot/plugins/TRSS-Plugin
    rm -rf /root/Yunzai-Bot/plugins/TRSS-Plugin
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
  echo;echo -e "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 25 ]];then
 if [ -d /root/Yunzai-Bot/plugins/plugins/Jinmaocuicuisha-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除脆脆鲨插件" \
    10 60);then
    echo -e "\033[34m 正在删除脆脆鲨插件 \033[0m";
    rm -rf /root/Yunzai-Bot/plugins/Jinmaocuicuisha-plugin
    rm -rf /root/Yunzai-Bot/plugins/Jinmaocuicuisha-plugin
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
  echo;echo -e "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 26 ]];then
 if [ -d /root/Yunzai-Bot/plugins/plugins/alemon-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除半柠檬插件" \
    10 60);then
    echo -e "\033[34m 正在删除半柠檬插件 \033[0m";
    rm -rf /root/Yunzai-Bot/plugins/alemon-plugin
    rm -rf /root/Yunzai-Bot/plugins/alemon-plugin
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
  pushd $HOME/Yunzai-Bot
  echo;echo -e "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 27 ]];then
 if [ -d /root/Yunzai-Bot/plugins/plugins/liulian-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除榴莲插件" \
    10 60);then
    echo -e "\033[34m 正在删除榴莲插件 \033[0m";
    rm -rf /root/Yunzai-Bot/plugins/liulian-plugin
    rm -rf /root/Yunzai-Bot/plugins/liulian-plugin
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
  echo;echo -e "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 28 ]];then
 if [ -d /root/Yunzai-Bot/plugins/plugins/xiaoye-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除小叶插件" \
    10 60);then
    echo -e "\033[34m 正在删除小叶插件 \033[0m";
    rm -rf /root/Yunzai-Bot/plugins/xiaoye-plugin
    rm -rf /root/Yunzai-Bot/plugins/xiaoye-plugin
    echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
 fi
 else
  whiptail --title "白狐≧▽≦" --msgbox "
    建议到插件地址查看使用方法
    https://gitee.com/xiaoye12123/xiaoye-plugin
    " 10 60
  echo "=================================="
  echo "正在安装小叶檬插件，稍安勿躁～"
  echo "=================================="
  git clone --depth=1 https://gitee.com/xiaoye12123/xiaoye-plugin.git ./plugins/xiaoye-plugin/
  echo;echo -e "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 29 ]];then
 if [ -d /root/Yunzai-Bot/plugins/plugins/rconsole-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除R插件" \
    10 60);then
    echo -e "\033[34m 正在删除R插件 \033[0m";
    rm -rf /root/Yunzai-Bot/plugins/rconsole-plugin
    rm -rf /root/Yunzai-Bot/plugins/rconsole-plugin
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
  echo;echo -e "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 30 ]];then
 if [ -d /root/Yunzai-Bot/plugins/plugins/expand-plugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除扩展插件" \
    10 60);then
    echo -e "\033[34m 正在删除扩展插件 \033[0m";
    rm -rf /root/Yunzai-Bot/plugins/expand-plugin
    rm -rf /root/Yunzai-Bot/plugins/expand-plugin
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
  echo;echo -e "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 31 ]];then
 if [ -d /root/Yunzai-Bot/plugins/plugins/XiaoXuePlugin ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除小雪插件" \
    10 60);then
    echo -e "\033[34m 正在删除小雪插件 \033[0m";
    rm -rf /root/Yunzai-Bot/plugins/XiaoXuePlugin
    rm -rf /root/Yunzai-Bot/plugins/XiaoXuePlugin
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
  pushd $HOME/Yunzai-Bot
  echo;echo -e "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

if [[ ${plugin} = 32 ]];then
 if [ -d /root/Yunzai-Bot/plugins/plugins/Icepray ];then
 if (whiptail --title "白狐-Yunzai-Bot-plugin" \
    --yesno "是否删除冰祈插件" \
    10 60);then
    echo -e "\033[34m 正在删除冰祈插件 \033[0m";
    rm -rf /root/Yunzai-Bot/plugins/Icepray
    rm -rf /root/Yunzai-Bot/plugins/Icepray
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
  echo;echo -e "\033[32m 安装完成 回车返回\033[0m";read -p ""
 fi
fi

else
exit
fi
done
