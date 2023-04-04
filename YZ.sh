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
eatmydata apt-get install redis -y
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
git clone --depth=1 https://gitee.com/Ganyu256/chromium
apt-get autoremove chromium-browser -y
pushd chromium
bash install.sh
pushd $HOME
rm -rf chromium
rm -rf chromium
pushd Yunzai-Bot
pnpm install -P
echo echo 正在启动Yunzai-Bot > /usr/bin/yz
sed -i -e '1a redis-server --daemonize yes --save 900 1 --save 300 10 && cd ~/Yunzai-Bot && node app' /usr/bin/yz 
chmod 777 /usr/bin/yz
echo echo 正在打开Yunzai-Bot后台日志 > /usr/bin/yzlog
sed -i -e '1a cd ~/Yunzai-Bot && pnpm run log' /usr/bin/yzlog
chmod 777 /usr/bin/yzlog
echo echo 正在启动Yunzai-Bot登录配置 > /usr/bin/yzlogin
sed -i -e '1a cd ~/Yunzai-Bot && pnpm run login' /usr/bin/yzlogin
chmod 777 /usr/bin/yzlogin
echo echo 正在停止Yunzai-Bot后台运行 > /usr/bin/yzstop
sed -i -e '1a cd ~/Yunzai-Bot && pnpm stop' /usr/bin/yzstop
chmod 777 /usr/bin/yzstop
pushd $HOME
echo
if ! grep -q "cat $HOME/.baihu" $HOME/.bashrc
then
    echo "
  1.启动Yunzai-Bot的命令为 yz
  2.查看Yunzai-Bot后台日志的命令为 yzlog
  3.重新配置Yunzai-Bot账户的命令为 yzlogin
  4.停止Yunzai-Bit后台运行的命令为 yzstop
  5.打开白狐脚本的命令为 bhyz
  6.注意:脚本完全免费,如果你是购买所得,请退款
  7.脚本有任何问题都可以加入QQ群:705226976
" > .baihu
   echo cat $HOME/.baihu >> .bashrc
fi
clear
echo -e '\033[37m安装完成\033[0m'
echo "1.启动Yunzai-Bot的命令为 yz"
echo "2.查看Yunzai-Bot后台日志的命令为 yzlog"
echo "3.重新配置Yunzai-Bot账户的命令为 yzlogin"
echo "4.停止Yunzai-Bit后台运行的命令为 yzstop"
echo "5.打开白狐脚本的命令为 bhyz"
echo "6.注意:脚本完全免费,如果你是购买所得,请退款"
echo "7.脚本有任何问题都可以加入QQ群:705226976"
#创建日志文件
echo >.bh.log
