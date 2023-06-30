#!/bin/bash
echo -e "\033[33m本脚本有白狐[B站:https://b23.tv/N1fRgS0]制作\033[31m禁止倒卖\033[0m"
echo -e "\033[31m本脚本完全免费 如果是购买所得 请联系白狐 打压倒卖狗 从你我做起\033[0m"
echo -e "\033[31m目前授权给小海_SeaSmall 等风来使用\033[0m"
echo -e '\033[31m请允许存储权限与后台权限 \033[0m'
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
sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.bfsu.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list
yes Y | apt update -y && yes Y | apt upgrade -y
sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.bfsu.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list
yes Y | apt update -y && yes Y | apt upgrade -y
pkg install openssl-tool pulseaudio proot -y
echo 目前可用Ubuntu版本
echo ------------------
echo 1. ubuntu23
echo 2. ubuntu22
echo 3. ubuntu20
echo 4. ubuntu18
echo -------------------
read -p 请输入您要安装的ubuntu版本的序号:  num
case ${num} in
1)
ubuntu=lunar
ubuntu_version=23
;;
2)
ubuntu=jammy
ubuntu_version=22
;;
3)
ubuntu=focal
ubuntu_version20
;;
4)
ubuntu=bionic
ubuntu_version=18
;;
*)
echo "输入错误!!"
exit
;;
esac
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
./U${ubuntu_version}


