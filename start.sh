#!/data/data/com.termux/files/usr/bin/bash
cd $HOME
if [ ! -d /data/data/com.termux ];then
echo
echo -e "\033[31m非termux请使用这条命令\033[0m"
echo -e "\033[36mbash <(curl -sL https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/install.sh)\033[0m"
exit
fi
if [ -d "../usr/var/lib/proot-distro/installed-rootfs/ubuntu/root/" ];then
echo
echo -e "\033[32m检测到您已经安装ubuntu\033[0m"
echo -e "\033[32m请使用这条命令启动\033[0m"
echo -e "\033[36mproot-distro login ubuntu\033[0m"
exit 0
fi
sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.bfsu.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list
sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.bfsu.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list
sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.bfsu.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list
apt update
apt update
apt install git wget proot-distro
echo -e '\033[36m请允许存储与后台权\033[0m'
sleep 1s
termux-setup-storage
sleep 3s
termux-wake-lock
echo "proot-distro login ubuntu" > $PREFIX/bin/U
chmod +x $PREFIX/bin/U
if ! grep -q "Ubuntu" $HOME/.bashrc
then
echo 'echo;echo 输入U 启动Ubuntu[大写];echo' >> $HOME/.bashrc
fi
git clone --depth=1 https://gitee.com/baihu433/Ubuntu-Yunzai.git
mv Ubuntu-Yunzai/ubuntu-aarch64-pd-v3.5.1.tar.xz ../usr/var/lib/proot-distro/dlcache
rm -rf Ubuntu-Yunzai
rm -rf Ubuntu-Yunzai
proot-distro reset ubuntu
wget -O YZ.sh https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/YZ.sh
mv YZ.sh ../usr/var/lib/proot-distro/installed-rootfs/ubuntu/root/
echo "bash YZ.sh" >> ../usr/var/lib/proot-distro/installed-rootfs/ubuntu/root/.bashrc

proot-distro login ubuntu