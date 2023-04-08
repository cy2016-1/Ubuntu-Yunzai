#!/bin/bash
if grep -q "bash YZ.sh" $HOME/.bashrc
then
sed -i "s/bash YZ.sh/ /g" $HOME/.bashrc
fi
rm YZ.sh > /dev/null
if [ -e .bh.log ];then
exit
fi
sed -i 's/ports.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list
apt update -y
apt install eatmydata -y
eatmydata apt install -y locales-all
eatmydata apt install -y ^language-pack-zh
echo "LANG=\"zh_CN.UTF-8\"
export LANG">>/etc/profile
source /etc/profile
eatmydata apt install -y curl wget git whiptail lsb-release
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
until npm -v
do
rm /etc/apt/sources.list.d/nodesource.list > /dev/null
bash <(curl -sL https://deb.nodesource.com/setup_18.x)
apt remove nodejs -y
eatmydata apt update -y
eatmydata apt install -y nodejs
done
npm config set registry http://registry.npm.taobao.org/
npm install -g npm
npm install -g pnpm
if ! [ -x "$(command -v pnpm)" ];then
    echo -e "\033[31m pnpm安装失败\033[0m";
    exit
fi
eatmydata apt-get install redis redis-server -y
redis-server --daemonize yes
eatmydata apt install chromium-browser fonts-wqy-microhei fonts-wqy-zenhei -y
pushd ~/
git clone --depth=1 https://gitee.com/yoimiya-kokomi/Yunzai-Bot
if ! [ -d ~/Yunzai-Bot ]
then
echo -e "\033[31m 项目克隆失败 请检查网络\033[0m";
exit
fi
pushd ~/Yunzai-Bot
pnpm install -P && pnpm install -P
clear
pushd $HOME
bash <(curl https://gitee.com/baihu433/chromium/raw/master/chromium.sh)
pnpm install puppeteer@19.0.0 -w
if ! grep -q "cat $HOME/.baihu" $HOME/.bashrc
then
    echo "
  1.打开白狐脚本的命令为 bhyz
  2.查看白狐脚本帮助为 bhyz -h
  3.注意:脚本完全免费,如果你是购买所得,请退款
  4.脚本有任何问题都可以加入QQ群:705226976
" > .baihu
   echo cat $HOME/.baihu >> .bashrc
fi
#创建日志文件
echo >.bh.log
