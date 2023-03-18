#!/bin/bash
sed -i 's/ports.ubuntu.com/http://mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list
apt update -y
apt install curl wget git whiptail -y
wget -O /usr/local/bin/bhyz https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/Yunzai-shell.sh >> wget.log 2>&1 &
{
for ((i = 0 ; i <= 100 ; i+=1))
do
    sleep 0.01s
    echo $i
done
} | whiptail --gauge "未安装 正在安装" 6 60 0
if ! [ -e "/usr/local/bin/bhyz" ];then
whiptail --title "白狐≧▽≦" --msgbox \
"安装失败 请检查网络" \
8 25
exit
fi
chmod +x /usr/local/bin/bhyz
rm wget.log
bhyz
rm -rf .profile
mv .profile.bak .profile