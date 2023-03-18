#!/bin/bash
sed -i 's/ports.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list
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
rm -rf .profile
mv .profile.bak .profile
until npm -v
do
bash <(curl -sL https://deb.nodesource.com/setup_18.x)
apt remove nodejs -y
apt update -y
apt install -y nodejs
done
npm config set registry http://registry.npm.taobao.org/
npm install -g npm
npm install -g pnpm
pnpm config set registry http://registry.npm.taobao.org/
pnpm install -g pnpm
if ! [ -x "$(command -v pnpm)" ];then
    echo -e "\033[31m pnpm安装失败\033[0m";
    exit
fi
apt install chromium-browser -y
if ! [ -x "$(command -v chromium-browser)" ];then
    echo -e "\033[31m chromium-browser安装失败\033[0m";
    exit
fi
apt-get install redis -y
if ! [ -x "$(command -v redis)" ];then
    echo -e "\033[31m redis安装失败\033[0m";
    exit
fi
redis-server --daemonize yes
apt-get install -y fonts-wqy-microhei fonts-wqy-zenhei
pushd ~/
git clone --depth=1 -b main https://gitee.com/Le-niao/Yunzai-Bot.git
if ! [ -d ~/Yunzai-Bot ]
then
echo -e "\033[31m 项目克隆失败 请检查网络\033[0m";
exit
fi
pushd ~/Yunzai-Bot
pnpm install -P && pnpm install -P
pushd ../
