#!/bin/bash
sed -i "s/bash YZ.sh//g" $HOME/.bashrc
rm YZ.sh > /dev/null
sed -i 's/ports.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list
apt update -y
apt install eatmydata -y
eatmydata apt install -y whiptail
eatmydata apt install -y fonts-wqy* language-pack-zh* locales-all redis redis-server git curl wget tar gzip xz-utils
echo 'export LANG="zh_CN.UTF-8"' >> /etc/profile
export LANG="zh_CN.UTF-8"
bash <(curl https://gitee.com/baihu433/chromium/raw/master/chromium.sh)
echo -e ${yellow}正在安装ffmpeg${background}
bash <(curl https://gitee.com/baihu433/ffmpeg/raw/master/ffmpeg.sh)
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

if awk '{print $2}' /etc/issue | grep -q -E 22.*
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
if [ ! -d $HOME/.local/share/pnpm ];then
    mkdir -p $HOME/.local/share/pnpm
fi
echo '
#Node.JS
export PATH=$PATH:/usr/local/node/bin
export PATH=$PATH:/root/.local/share/pnpm
export PNPM_HOME=/root/.local/share/pnpm' >> /etc/profile
export PATH=$PATH:/usr/local/node/bin
export PATH=$PATH:/root/.local/share/pnpm
export PNPM_HOME=/root/.local/share/pnpm
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
mkdir -p ~/.fox@bot/
git clone --depth=1 https://gitee.com/yoimiya-kokomi/Yunzai-Bot.git ~/.fox@bot/Yunzai-Bot
ln -s ~/.fox@bot/Yunzai-Bot Yunzai-Bot
echo -e ${yellow}正在使用pnpm安装依赖${background}
cd ~/.fox@bot/Yunzai-Bot
pnpm config set registry https://registry.npmmirror.com
pnpm config set registry https://registry.npmmirror.com
until echo "Y" | pnpm install -P && echo "Y" | pnpm install
do
  echo -e ${red}依赖安装失败 ${green}正在重试${background}
  if [ ! -d $HOME/.local/share/pnpm ];then
    mkdir -p $HOME/.local/share/pnpm
  fi
  export PATH=$PATH:$HOME/.local/share/pnpm
  export PNPM_HOME=$HOME/.local/share/pnpm
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
cd ~/.fox@bot/Yunzai-Bot
echo -en ${yellow}正在初始化${background}
pnpm start
sleep 5s
pnpm stop
rm -rf ~/.pm2/logs/*.log
echo -en ${yellow}初始化完成${background}
echo
export install_QSignServer=true
bash <(curl -sL https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/QSignServer2.0.sh)
curl -o /usr/local/bin/bhyz https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/Yunzai-shell.sh
chmod +x /usr/local/bin/bhyz
bhyz