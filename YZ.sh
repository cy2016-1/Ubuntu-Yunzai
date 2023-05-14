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
eatmydata apt install -y curl git whiptail lsb-release
curl -o /usr/local/bin/bhyz https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/Yunzai-shell.sh
chmod +x /usr/local/bin/bhyz
rm wget.log > /dev/null 2>&1
bhyz