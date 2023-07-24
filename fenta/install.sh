#!/data/data/com.termux/files/usr/bin/bash
fturl="https://gitee.com/zhou-ziming-zzm/yz-deployment"
bfsu="https://mirrors.bfsu.edu.cn/lxc-images/images"
case `whoami` in
u0*)
    ;;
*)
    echo "请使用termux原生环境" && exit 1 ;;
esac
cd $HOME
cat <<u
================================                 纷沓Script  
           项目地址${fturl}       
===============================
  -- 1. Archlinux
  -- 2. CentOS7.9
  -- 3. Debian10
  -- 4. Ubuntu22.04
  -- 5. 无
    输入数字安装或启动容器
Ubuntu启动出现groups报错不影响使用
u

read yn
case "$yn" in
1)
    folder=arch
    cmd=a
    sys=archlinux/current;;
2)
    folder=centos
    cmd=c
    sys=centos/7;;
3)
    folder=debian
    cmd=d
    sys=debian/buster;;
4)
    folder=ubuntu
    cmd=u
    sys=ubuntu/jammy;;
5)
if [ -d "$HOME/debian" ]; then
    echo "已安装debian,该项无法使用"
    exit 1
fi
    exit 1;;
*)
    exit 1
esac
if [ -d "$HOME/$folder" ]; then
    echo "检测到存在,开始启动"
    bash $PREFIX/bin/$cmd 
    exit 1
fi
    echo "开始安装"
tarball="${folder}-rootfs.tar.xz" #镜像名
    echo "正在更换软件源..."
    sed -i 's@packages.termux.org@mirrors.ustc.edu.cn/termux@' $PREFIX/etc/apt/sources.list && yes n | pkg up -y
if ! [ -x "$(command -v tar)" ]; then
    pkg install -y tar
fi
if ! [ -x "$(command -v proot)" ]; then
    apt install proot -y
fi
if ! [ -x "$(command -v wget)" ]; then
    apt install wget -y
fi
if [ -d "$folder" ]; then
	first=1
fi
if [ "$first" != 1 ];then
if [ ! -f $tarball ]; then
case `uname -m` in
aarch64)
	archurl="arm64" ;;
arm)
	archurl="armhf" ;;
amd64)
	archurl="amd64" ;;
x86_64)
	archurl="amd64" ;;
*)
	 echo "暂不支持`uname -m`架构"; exit 1 ;;
esac
    date=`curl -sL ${bfsu}/${sys}/${archurl}/default | grep "href" | tail -n 1 | sed 's/.*href="//;s/".*//' | sed 's#/$##g'`
	wget -c "${bfsu}/${sys}/${archurl}/default/${date}/rootfs.tar.xz" -O $tarball
fi
    cur=`pwd`
	mkdir -p "$folder"
	cd "$folder"
	proot --link2symlink tar -xvJf ${cur}/${tarball} --exclude='dev'||:
	echo "127.0.0.1 localhost" > etc/hosts
    rm -rf etc/resolv.conf && echo -e "nameserver 8.8.8.8 \n nameserver 8.8.4.4" > etc/resolv.conf
    echo -e "inet:x:3003: \n sdcard_rw:x:9997: \n all_a831:x:50831: \n 20304:x:20304: \n 50304:x:50304:" >> etc/group
    cd $HOME
fi
mkdir -p $folder/tmp
read -p "是否y允许容器读取内部储存,允许y拒绝n,请输入" yn
case $yn in
y)
termux-setup-storage
sd='command+=" -b /sdcard"';;
n);;
*);;
esac
cat > $PREFIX/bin/$cmd <<- EOM
#!/bin/bash
echo "赞美纷沓"
cd \$(dirname \$0)
unset LD_PRELOAD
command="proot"
command+=" --link2symlink"
command+=" -0"
command+=" -r $HOME/$folder"
$sd
command+=" -b /dev"
command+=" -b /proc"
command+=" -w /root"
command+=" /usr/bin/env -i"
command+=" HOME=/root"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
command+=" TERM=\$TERM"
command+=" LANG=C.UTF-8"
command+=" /bin/bash --login"
com="\$@"
if [ -z "\$1" ];then
    exec \$command
else
    \$command -c "\$com"
fi
EOM
if ! grep -q "启动${folder}请输入$cmd" $HOME/.bashrc; then
    echo "echo 启动${folder}请输入$cmd" >> $HOME/.bashrc
fi
termux-fix-shebang $PREFIX/bin/$cmd
chmod +x $PREFIX/bin/$cmd
read -p "是否保留镜像文件，保留请输入y " image
case "$image" in
y)
    echo "已保留镜像文件" ;;
*)
    rm -rf $HOME/$tarball && echo "已删除镜像文件" || echo "镜像删除失败,请自行删除"
esac
    echo "输入 $cmd 启动${folder}"