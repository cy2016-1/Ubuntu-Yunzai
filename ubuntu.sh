#!/data/data/com.termux/files/usr/bin/bash
if ! [ "$(uname -o)" = "Android" ]; then
	echo "非termux 停止运行"
	exit 1
fi
if ! [ -d /data/data/com.termux ];then
	echo "非termux 停止运行"
	exit 1
fi
folder=ubuntu
if [ -d "${folder}" ]; then
	first=1
fi
tarball="ubuntu-rootfs.tar.xz"
sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.bfsu.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list
sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.bfsu.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list
sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.bfsu.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list
echo -e '\033[33m卡住直接回车\033[0m'
sleep 1s
echo -e '\033[33m卡住直接回车\033[0m'
sleep 1s 
echo -e '\033[33m卡住直接回车\033[0m'
sleep 1s
pkg install openssl-tool proot -y
if [ "${first}" != 1 ];then
		echo "下载rootfs，可能需要一段时间，取决于您的互联网速度."
		case `dpkg --print-architecture` in
		arm64|aarch64)
		  curl -o ${tarball} https://mirrors.bfsu.edu.cn/lxc-images/images/ubuntu/jammy/arm64/cloud/20230512_12:41/rootfs.tar.xz
		  ;;
		arm|armhf|armel)
		  curl -o ${tarball} https://mirrors.bfsu.edu.cn/lxc-images/images/ubuntu/jammy/armhf/cloud/20230512_13:43/rootfs.tar.xz
		  ;;
		amd64|x86_64)
		  curl -o ${tarball} https://mirrors.bfsu.edu.cn/lxc-images/images/ubuntu/jammy/amd64/cloud/20230512_10:35/rootfs.tar.xz
		  ;;
		*)
			echo "您的设备框架为$(dpkg --print-architecture),快让白狐做适配!!"; exit 1 ;;
		esac
	cur=`pwd`
	mkdir -p "${folder}"
	cd "${folder}"
	echo "开始解压rootfs"
	proot --link2symlink tar -xJf ${cur}/${tarball}||:
	cd "${cur}"
fi
bin=start-ubuntu.sh
cat > ${bin} <<- EOM
#!/bin/bash
cd \$(dirname \$0)
pulseaudio --start
unset LD_PRELOAD
command="proot"
command+=" --link2symlink"
command+=" -0"
command+=" -r ${folder}"
command+=" -b /dev"
command+=" -b /proc"
command+=" -b ubuntu/root:/dev/shm"
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
pkg install pulseaudio -y
if grep -q "anonymous" ~/../usr/etc/pulse/default.pa;then
    echo "模块已存在"
else
    echo "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" >> ~/../usr/etc/pulse/default.pa
fi
echo "exit-idle-time = -1" >> ~/../usr/etc/pulse/daemon.conf
echo "autospawn = no" >> ~/../usr/etc/pulse/client.conf
echo "export PULSE_SERVER=127.0.0.1" >> ~/ubuntu/etc/profile
echo "1077:x:1077:
3003:x:3003:
9997:x:9997:
20462:x:20462:
50462:x:50462:" >>ubuntu/etc/group
sed -i "s/ports.ubuntu.com/mirrors.bfsu.edu.cn/g" ~/ubuntu/etc/apt/sources.list
rm ~/ubuntu/etc/resolv.conf
echo "nameserver 114.114.114.114" > ~/ubuntu/etc/resolv.conf
termux-fix-shebang ${bin}
chmod +x ${bin}
rm ${tarball}
curl -o YZ.sh https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/YZ.sh
mv YZ.sh ~/ubuntu/root/YZ.sh
mkdir ~/ubuntu/root/.fox@bot
ln -s ~/ubuntu/root/.fox@bot $HOME/fox@bot
echo "./${bin}" > .bashrc
./${bin}
