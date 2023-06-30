#!/bin/bash
red="\033[31m"
green="\033[32m"
yellow="\033[33m"
blue="\033[34m"
purple="\033[35m"
cyan="\033[36m"
white="\033[37m"
background="\033[0m"
if ! [ "$(uname -o)" = "Android" ]; then
	echo -e ${red}非termux 停止运行${background}
	exit
fi
if ! [ -d /data/data/com.termux ];then
	echo -e ${red}非termux 停止运行${background}
	exit
fi
echo y | termux-setup-storage > /dev/null
sleep 3s
termux-wake-lock
sleep 3s
case $(uname -m) in
arm64|aarch64)
  structure=arm64
  ;;
arm|armhf|armel)
  structure=armhf
  ;;
amd64|x86_64)
  structure=amd64
  ;;
*)
	echo "您的设备框架为$(dpkg --print-architecture) 暂时不支持"; exit 1 ;;
esac
if grep "packages.termux.org" $PREFIX/etc/apt/sources.list;then
echo 'deb https://mirror.iscas.ac.cn/termux/apt/termux-main stable main' > $PREFIX/etc/apt/sources.list
yes Y | apt update -y && yes Y | apt upgrade -y
apt autoremove -y
fi
pkg install -y openssl-tool pulseaudio proot
echo 目前可用Ubuntu版本
echo ------------------
echo 1. ubuntu23
echo 2. ubuntu22
echo 3. ubuntu20
echo 4. ubuntu18
echo -------------------
echo 请输入您要安装的ubuntu版本的序号: ;read num
if [ "${num}"="1" ];then
ubuntu=lunar
ubuntu_version=23
elif [ "${num}"="2" ];then
ubuntu=jammy
ubuntu_version=22
elif [ "${num}"="3" ];then
ubuntu=focal
ubuntu_version20
elif [ "${num}"="4" ];then
ubuntu=bionic
ubuntu_version=18
else
echo -e ${red}输入错误${background}
exit
fi
date=$(curl https://mirrors.bfsu.edu.cn/lxc-images/images/ubuntu/${ubuntu}/${structure}/default/ | \
grep 'class="link"><a href=' | \
tail -n 1 | \
grep -o 'title="[^"]*"' | \
awk -F'"' '{print $2}' )
if ! curl -o rootfs.tar.xz https://mirrors.bfsu.edu.cn/lxc-images/images/ubuntu/${ubuntu}/${structure}/default/${date}/rootfs.tar.xz
  then
    echo "下载失败 请检查网络!!"
    exit 1
fi
mkdir ubuntu${ubuntu_version}
path=$(pwd)
cd ubuntu${ubuntu_version}
echo "2秒后开始解压"
sleep 2s
proot --link2symlink tar -xvJf ${path}/rootfs.tar.xz ||:
echo "解压解压完成"
cd ${path}
cat > start-ubuntu.sh << EOM
cd \$(dirname \$0)
pulseaudio --start
unset LD_PRELOAD
command="proot"
command+=" --link2symlink"
command+=" -0"
command+=" -r ubuntu${ubuntu_version}"
command+=" -b /dev"
command+=" -b /proc"
command+=" -b ubuntu${ubuntu_version}/root:/dev/shm"
command+=" -b /sdcard"
command+=" -w /root"
command+=" /usr/bin/env -i"
command+=" HOME=/root"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
command+=" TERM=\${TERM}"
command+=" LANG=C.UTF-8"
command+=" /bin/bash --login"
com="\$@"
if [ -z "\$1" ];then
    exec \${command}
else
    \${command} -c "\${com}"
fi
EOM
termux-fix-shebang start-ubuntu.sh
chmod +x start-ubuntu.sh
mv start-ubuntu.sh U${ubuntu_version}
rm rootfs.tar.xz
echo 'rm /etc/resolv.conf > /dev/null
echo "nameserver 8.8.8.8" > /etc/resolv.conf
sed -i "s/ports.ubuntu.com/mirrors.bfsu.edu.cn/g" /etc/apt/sources.list
apt -y update
apt -y upgrade
apt install -y curl
apt install -y language-pack-zh*
apt install -y locales-all
echo "export LANG=\"zh_CN.UTF-8\"" >> /etc/profile
export LANG="zh_CN.UTF-8"
sed -i "s/http/https/g" /etc/apt/sources.list
apt -y update
rm initialization.sh
sed -i "s/bash initialization.sh//g" .bashrc ' > initialization.sh
mv initialization.sh ubuntu${ubuntu_version}/root/initialization.sh
echo "bash initialization.sh" >> ubuntu${ubuntu_version}/root/.bashrc
#echo "./U${ubuntu_version}" > .bashrc
#这一条命令属于可选，如果取消注释，则会在启动termux的时候，启动ubuntu
./U${ubuntu_version}


