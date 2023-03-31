#!/data/data/com.termux/files/usr/bin/bash
if [ ! -d /data/data/com.termux ];then
echo
echo -e "\033[31m非termux请使用这条命令\033[0m"
echo
echo -e "\033[36mbash <(curl -sL https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/install.sh)\033[0m"
exit
fi
sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.bfsu.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list
sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.bfsu.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list
sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.bfsu.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list
apt update
apt update
until pkg install proot-distro
do
sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.bfsu.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list
apt update
pkg install proot-distro
done
if [ -d "../usr/var/lib/proot-distro/installed-rootfs/ubuntu/root/" ];then
echo "检测到您已经安装ubuntu 即将为您启动"
echo
proot-distro login ubuntu
fi
until proot-distro install ubuntu
do
proot-distro install ubuntu
done
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
wget -O YZ.sh https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/YZ.sh
mv YZ.sh ../usr/var/lib/proot-distro/installed-rootfs/ubuntu/root/
echo "bash YZ.sh" >> ../usr/var/lib/proot-distro/installed-rootfs/ubuntu/root/.bashrc
proot-distro login ubuntu