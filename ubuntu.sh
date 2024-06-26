#!/data/data/com.termux/files/usr/bin/bash
if ! [ "$(uname -o)" = "Android" ]; then
	echo "非termux 停止运行"
	exit 1
fi
echo -e ${yellow} - ${cyan}此脚本已停止维护${background}
echo -e ${yellow} - ${cyan}请到 ${green}https://gtiee.com/baihu433/Yunzai-Bot-Shell${cyan}获取新脚本${background}
echo -e ${yellow} - ${cyan}如有疑问 请添加QQ群聊${green}879718035 ${cyan}获取帮助${background}
exit
folder=ubuntu
if [ -d "${folder}" ]; then
	first=1
fi
if [ -d ubuntu ];then
echo -e '\033[33mubuntu已安装\033[0m'
exit
fi
echo -e '\033[33m卡住直接回车\033[0m'
sleep 1s
echo -e '\033[33m卡住直接回车\033[0m'
sleep 1s 
echo -e '\033[33m卡住直接回车\033[0m'
sleep 1s
sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.bfsu.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list
yes Y | pkg update -y | pkg upgrade -y
sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.bfsu.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list
yes Y | pkg update -y | pkg upgrade -y
sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.bfsu.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list
yes Y | pkg update -y && pkg upgrade -y
pkg install openssl-tool pulseaudio proot -y
rootfs="ubuntu-rootfs.tar.xz"
if [ "${first}" != 1 ];then
		echo "下载rootfs，可能需要一段时间，取决于您的互联网速度."
		case $(uname -m) in
		arm64|aarch64)
		  frame=arm64
		  ;;
		arm|armhf|armel)
		  frame=armhf
		  ;;
		amd64|x86_64)
		  frame=amd64
		  ;;
		*)
			echo "您的设备框架为$(dpkg --print-architecture),快让白狐做适配!!"; exit 1 ;;
		esac
		
    date=$(curl https://mirrors.bfsu.edu.cn/lxc-images/images/ubuntu/jammy/${frame}/default/ | \
    grep 'class="link"><a href=' | \
    tail -n 1 | \
    grep -o 'title="[^"]*"' | \
    awk -F'"' '{print $2}' )
      
    if ! curl -o ${rootfs} https://mirrors.bfsu.edu.cn/lxc-images/images/ubuntu/jammy/${frame}/default/${date}/rootfs.tar.xz
      then
      echo "下载失败 请检查网络!!"
      exit 1
    fi
    
	path=$(pwd)
	mkdir -p "${folder}"
	cd "${folder}"
	echo "开始解压rootfs"
	proot --link2symlink tar -xJf ${path}/${rootfs}||:
	cd "${path}"
fi

bin=start-ubuntu.sh
cat > ${bin} << EOM
#!/bin/bash
cd \$(dirname \$0)
pulseaudio --start
unset LD_PRELOAD
command="proot"
command+=" --link2symlink"
command+=" -0"
command+=" -r ubuntu"
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
50462:x:50462:
1079:x:1079:" >> ubuntu/etc/group
sed -i "s/ports.ubuntu.com/mirrors.bfsu.edu.cn/g" ~/ubuntu/etc/apt/sources.list
rm ~/ubuntu/etc/resolv.conf > /dev/null
echo "nameserver 114.114.114.114" > ~/ubuntu/etc/resolv.conf
termux-fix-shebang ${bin}
chmod +x ${bin}
rm ${rootfs}
curl -o YZ.sh https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/YZ.sh
mv YZ.sh ~/ubuntu/root/YZ.sh
mkdir ~/ubuntu/root/.fox@bot > /dev/null
ln -sf ~/ubuntu/root/.fox@bot $HOME/fox@bot > /dev/null
echo "clear" >> ~/ubuntu/root/.bashrc
echo "bash YZ.sh" >> ~/ubuntu/root/.bashrc
echo "./${bin}" > .bashrc
./${bin}