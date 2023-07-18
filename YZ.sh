#!/bin/bash
sed -i "s/bash YZ.sh//g" $HOME/.bashrc
rm YZ.sh > /dev/null
sed -i 's/ports.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list
apt update -y
apt install eatmydata -y
eatmydata apt install -y whiptail
eatmydata apt install -y fonts-wqy* language-pack-zh* locales-all redis redis-server git curl wget unar axel
echo 'export LANG="zh_CN.UTF-8"' >> /etc/profile
export LANG="zh_CN.UTF-8"
echo "deb http://ftp.cn.debian.org/debian sid main" >> /etc/apt/sources.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0E98404D386FA1D9 6ED0E7B82643E131
apt-key adv --refresh-keys --keyserver keyserver.ubuntu.com
apt update -y
eatmydata apt install -y gnupg gnupg1 gnupg2
eatmydata apt install -y chromium
rm -rf /etc/apt/trusted.gpg
sed -i "s/deb http:\/\/ftp.cn.debian.org\/debian sid main//g" /etc/apt/sources.list
chromium 2&> /dev/null
if ! [ -x "$(command -v ffmpeg)" ];then
echo -e ${yellow}正在安装ffmpeg${background}
  case $(uname -m) in
  aarch64|arm64)
    ffmpeg=arm64
    ;;
  amd64|x86_64)
    ffmpeg=amd64
    ;;
  armel)
    ffmpeg=armel
    ;;
  armhf)
    ffmpeg=armhf
    ;;
  i686)
    ffmpeg=i686
    ;;
  *)
  echo -e "\033[33m您的框架为\033[31m $(uname -m)\033[33m 快截图 让白狐做适配!!\033[0m"
  exit
    ;;
esac
if ! [ -x "$(command -v axel)" ];then
apt install -y axel
fi
axel -n 32 -o static.tar.xz https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-${ffmpeg}-static.tar.xz
if ! [ -x "$(command -v unar)" ];then
apt install -y unar
fi
echo -e "\033[33m正在解压\033[0m"
unar -o static static.tar.xz
mv -f static/$(ls static)/ffmpeg /usr/local/bin/ffmpeg
mv -f static/$(ls static)/ffprobe /usr/local/bin/ffprobe
mv -f static/$(ls static)/qt-faststart /usr/local/bin/qt-faststart
chmod +x /usr/local/bin/ffmpeg /usr/local/bin/ffprobe /usr/local/bin/qt-faststart
rm -rf static.tar.xz static > /dev/null
rm -rf static.tar.xz static > /dev/null
echo
fi

case $(uname -m) in
x86_64|amd64)
node=x64
;;
arm64|aarch64|armv8*)
node=arm64
;;
armhf|armel|armv7*)
node=armv7l
;;
*)
echo ${red}您的框架为${yellow}$(uname -m)${red},快让白狐做适配.${background}
exit
esac

if awk '{print $2}' /etc/issue | grep -q -E 22.* || grep -q -E 23.*
then
  curl -o node.tar.xz https://cdn.npmmirror.com/binaries/node/latest-v18.x/node-v18.16.0-linux-${node}.tar.xz
else
  curl -o node.tar.xz https://cdn.npmmirror.com/binaries/node/latest-v16.x/node-v16.20.0-linux-${node}.tar.xz
fi
if [ ! -d node ];then
mkdir node
fi
echo -e ${yellow}正在解压二进制文件压缩包${background}
if ! tar -xf node.tar.xz -C node ;then
  echo -e ${red}tar命令解压失败 正在安装并使用unar${background}
  if ! [ -x "$(command -v unar)" ];then
    apt install -y unar
  fi
  unar node.tar.xz -o node
fi
rm -rf /usr/local/node > /dev/null
rm -rf /usr/local/node > /dev/null
mv -f node/$(ls node) /usr/local/node
echo '
#Node.JS
export PATH=$PATH:/usr/local/node/bin
export PNPM_HOME=/usr/local/node/bin' >> /etc/profile
PATH=$PATH:/usr/local/node/bin
export PNPM_HOME=/usr/local/node/bin
source /etc/profile
rm -rf node node.tar.xz > /dev/null
rm -rf node node.tar.xz > /dev/null

if ! [ -x "$(command -v pnpm)" ];then
    echo -e ${yellow}正在使用npm安装pnpm${background}
    a=0
    npm config set registry https://registry.npmmirror.com
    npm config set registry https://registry.npmmirror.com
    npm install -g npm@latest
    until npm install -g pnpm@latest
    do
      echo -e ${red}pnpm安装失败 ${green}正在重试${background}
      a=$(($a+1))
      if [ "${a}" == "3" ];then
        echo -e ${red}错误次数过多 退出${background}
        exit
      fi
    done
    echo
fi

#if ! [ -x "$(command -v pm2)" ];then
#    echo -e ${yellow}正在使用npm安装pnpm${background}
#    until npm install -g pm2
#    do
#      echo -e ${red}pm2安装失败 ${green}正在重试${background}
#    done
#    echo
#fi

if [ ! -e ~/${name}/config/config/bot.yaml ];then
a=0
echo -e ${yellow}正在使用pnpm安装依赖${background}
cd ~/.fox@bot/${name}
pnpm config set registry https://registry.npmmirror.com
pnpm config set registry https://registry.npmmirror.com
until echo "Y" | pnpm install -P && echo "Y" | pnpm install
do
  echo -e ${red}依赖安装失败 ${green}正在重试${background}
  pnpm setup
  source ~/.bashrc
  a=$(($a+1))
  if [ "${a}" == "3" ];then
    echo -e ${red}错误次数过多 退出${background}
    exit 
  fi
done
pnpm uninstall puppeteer -w
pnpm install puppeteer@19.0.0 -w
pnpm uninstall icqq -w
pnpm install -w icqq@latest
cd ~/.fox@bot/${name}
echo -en ${yellow}正在初始化${background}
pnpm start
pnpm stop
rm -rf ~/.pm2/logs/*.log
echo -en ${yellow}初始化完成${background}
echo
echo -en ${yellow}安装完成 回车继续${background}
fi
curl -o /usr/local/bin/bhyz https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/Yunzai-shell.sh
chmod +x /usr/local/bin/bhyz
rm wget.log > /dev/null 2>&1
bhyz