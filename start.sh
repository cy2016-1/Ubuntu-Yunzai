#!/data/data/com.termux/files/usr/bin/bash
cd $HOME
if [ "$(uname -o)" = "Android" ]; then
	echo "非termux 停止运行"
	exit 1
fi
if [ -d "../usr/var/lib/proot-distro/installed-rootfs/ubuntu/root/" ];then
echo
echo -e "\033[32m检测到您已经安装ubuntu\033[0m"
echo -e "\033[32m请使用这条命令启动\033[0m"
echo -e "\033[33mproot-distro login ubuntu\033[0m"
exit 0
fi
sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.bfsu.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list
sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.bfsu.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list
sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.bfsu.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list
echo -e '\033[33m卡住直接回车\033[0m'
sleep 1s
echo -e '\033[33m卡住直接回车\033[0m'
sleep 1s 
echo -e '\033[33m卡住直接回车\033[0m'
sleep 1s
apt update -y && apt upgrade -y
apt update -y && apt upgrade -y
apt install git wget proot-distro -y
echo -e '\033[36m请允许存储与后台权\033[0m'
sleep 1s
termux-setup-storage
sleep 3s
termux-wake-lock
echo "proot-distro login ubuntu" > $PREFIX/bin/U
chmod +x $PREFIX/bin/U
echo >> $HOME/.bashrc
if ! grep -q "Ubuntu" $HOME/.bashrc
then
echo 'echo;echo 输入U 启动Ubuntu[大写];echo' >> $HOME/.bashrc
fi
if ! [ -d "../usr/var/lib/proot-distro/dlcache" ];then
mkdir -p ../usr/var/lib/proot-distro/dlcache
fi
case $(arch) in
  arm64|aarch64)
    ubuntu=arm64
    ;;
  amd64|x86_64)
    ubuntu=amd64
    ;;
  arm|armhf|armel)
    ubuntu=arm
    ;;
  *)
    echo -e "\033[31m暂不支持您的设备\033[0m"
    exit
    ;;
esac
wget -O ubuntu-${ubuntu}-pd-v3.5.1.tar.xz https://ghproxy.com/https://github.com/termux/proot-distro/releases/download/v3.5.1/ubuntu-${ubuntu}-pd-v3.5.1.tar.xz
mv ubuntu-${ubuntu}-pd-v3.5.1.tar.xz ../usr/var/lib/proot-distro/dlcache
proot-distro install ubuntu
wget -O YZ.sh https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/YZ.sh
mv YZ.sh ../usr/var/lib/proot-distro/installed-rootfs/ubuntu/root/
echo "bash YZ.sh" >> ../usr/var/lib/proot-distro/installed-rootfs/ubuntu/root/.bashrc
ln -s ../usr/var/lib/proot-distro/installed-rootfs/ubuntu/root $HOME/root
proot-distro login ubuntu
echo "proot-distro login ubuntu" > .bashrc