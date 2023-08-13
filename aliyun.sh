echo -e '\033[36m请允许存储与后台权\033[0m'
echo y | termux-setup-storage
sleep 2s
termux-wake-lock
sleep 2s
echo 'deb https://mirrors.bfsu.edu.cn/termux/termux-packages-24 stable main' > $PREFIX/etc/apt/sources.list
yes Y | pkg update -y && pkg upgrade -y
echo 'deb https://mirrors.bfsu.edu.cn/termux/termux-packages-24 stable main' > $PREFIX/etc/apt/sources.list
pkg update -y
pkg install git wget proot-distro -y
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
until wget -O ubuntu-${ubuntu}-pd-v3.10.0.tar.xz -c https://ghproxy.com/https://github.com/termux/proot-distro/releases/download/v3.10.0/ubuntu-${ubuntu}-pd-v3.10.0.tar.xz
do
echo -e "\033[31m下载失败 重试中\033[0m"
done
mv -f ubuntu-${ubuntu}-pd-v3.10.0.tar.xz ../usr/var/lib/proot-distro/dlcache
echo > ../usr/var/lib/proot-distro/installed-rootfs/ubuntu/usr/bin/locale-check
chmod +x ../usr/var/lib/proot-distro/installed-rootfs/ubuntu/usr/bin/locale-check
echo "1077:x:1077:" >> ../usr/var/lib/proot-distro/installed-rootfs/ubuntu/etc/group
echo "proot-distro login ubuntu" > .bashrc
proot-distro login ubuntu