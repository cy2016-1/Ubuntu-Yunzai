#!/data/data/com.termux/files/usr/bin/bash
cd $HOME
if ! [ "$(uname -o)" = "Android" ]; then
	echo "看来你是大聪明 加Q群获取帮助吧 596660282"
	exit
fi
echo -e ${yellow} - ${cyan}此脚本已停止维护${background}
echo -e ${yellow} - ${cyan}请到 ${green}https://gtiee.com/baihu433/Yunzai-Bot-Shell${cyan}获取新脚本${background}
echo -e ${yellow} - ${cyan}如有疑问 请添加QQ群聊${green}879718035 ${cyan}获取帮助${background}
exit
if [ -d "../usr/var/lib/proot-distro/installed-rootfs/ubuntu/root/" ];then
echo
echo -e "\033[32m检测到您已经安装ubuntu\033[0m"
echo -e "\033[32m请使用这条命令启动\033[0m"
echo -e "\033[33mproot-distro login ubuntu\033[0m"
exit 0
fi
echo -e '\033[36m请允许存储与后台权\033[0m'
echo y | termux-setup-storage
sleep 2s
termux-wake-lock
sleep 2s
echo 'deb https://mirrors.bfsu.edu.cn/termux/termux-packages-24 stable main' > $PREFIX/etc/apt/sources.list
yes Y | apt update -y && apt upgrade -y
echo 'deb https://mirrors.bfsu.edu.cn/termux/termux-packages-24 stable main' > $PREFIX/etc/apt/sources.list
yes Y | apt update -y && apt upgrade -y
apt install git wget proot-distro -y
echo "proot-distro login ubuntu" > $PREFIX/bin/U
chmod +x $PREFIX/bin/U
if ! [ -d "../usr/var/lib/proot-distro/dlcache" ];then
mkdir -p ../usr/var/lib/proot-distro/dlcache
fi
case $(uname -m) in
  arm64|aarch64)
    ubuntu=aarch64
    ;;
  amd64|x86_64)
    ubuntu=x86_64
    ;;
  arm|armhf|armel)
    ubuntu=arm
    ;;
  *)
    echo -e "\033[31m暂不支持您的设备\033[0m"
    exit
    ;;
esac
wget -O ubuntu-${ubuntu}-pd-v3.10.0.tar.xz -c https://ghproxy.com/https://github.com/termux/proot-distro/releases/download/v3.10.0/ubuntu-${ubuntu}-pd-v3.10.0.tar.xz
mv -f ubuntu-${ubuntu}-pd-v3.10.0.tar.xz ../usr/var/lib/proot-distro/dlcache
proot-distro install ubuntu
wget -O YZ.sh https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/YZ.sh
mv YZ.sh ../usr/var/lib/proot-distro/installed-rootfs/ubuntu/root/
mkdir ../usr/var/lib/proot-distro/installed-rootfs/ubuntu/root/.fox@bot
echo > ../usr/var/lib/proot-distro/installed-rootfs/ubuntu/usr/bin/locale-check
chmod +x ../usr/var/lib/proot-distro/installed-rootfs/ubuntu/usr/bin/locale-check
echo "bash YZ.sh" >> ../usr/var/lib/proot-distro/installed-rootfs/ubuntu/root/.bashrc
echo "1077:x:1077:" >> ../usr/var/lib/proot-distro/installed-rootfs/ubuntu/etc/group
ln -s ../usr/var/lib/proot-distro/installed-rootfs/ubuntu/root/.fox@bot $HOME/fox@bot
echo "proot-distro login ubuntu" > .bashrc
proot-distro login ubuntu