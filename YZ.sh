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
curl -o /usr/local/bin/bhyz https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/Yunzai-shell.sh
if ! [ -e "/usr/local/bin/bhyz" ];then
whiptail --title "白狐≧▽≦" --msgbox \
"安装失败 请检查网络" \
8 25
exit
fi
chmod +x /usr/local/bin/bhyz 
rm wget.log