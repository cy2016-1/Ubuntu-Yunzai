pushd ${home}
#判断系统是否为Ubuntu
lsb_release -i | grep -q "Ubuntu"
if [ $? -eq 0 ]; then
  echo
else
  echo -e "\033[44m 非ubuntu系统 停止运行! \033[0m";
  exit
fi
#检测是否为root用户
if [ "$(whoami)" == "root" ]; then
    echo
else
    echo -e "\033[44m 非root用户 请登录root用户后使用该脚本 \033[0m";
fi
#检测curl安装状态
if ! [ -x "$(command -v curl)" ]
    then
    echo -e "\033[44m 未检测到未安装curl 开始安装 \033[0m";
    apt update
    apt install curl -y
fi
#检测wget安装状态
if ! [ -x "$(command -v wget)" ]
    then
    echo -e "\033[44m 未检测到未安装wget 开始安装 \033[0m";
    apt update
    apt install wget -y
fi
#检测whiptail安装状态
if ! [ -x "$(command -v whiptail)" ]
    then
    echo -e "\033[44m 未检测到未安装whiptail 开始安装 \033[0m";
    apt update
    apt install whiptail -y
fi

while true
do
baihu=$(whiptail \
--title "白狐≧▽≦" \
--menu "0.1" \
20 45 10 \
"1" "管理Yunzai-Bot" \
"2" "安装Yunzai-Bot" \
"3" "安装Yunzai插件" \
"4" "打开附加安装菜单" \
"5" "报错修复" \
"6" "帮助" \
"0" "退出" \
3>&1 1>&2 2>&3 )
ctmd=$?

if [[ ${ctmd} = 0 ]]
then



else
    exit
fi




done