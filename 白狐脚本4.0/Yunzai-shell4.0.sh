#!/bin/env bash
#if ping -c 1 baidu.com &> /dev/null
#then
#   Git=gitee
#elif ping -c 1 google.com &> /dev/null
#then
#   Git=github
#fi
ver=4.0
cd $HOME
version=`curl -s https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/version-bhyz.sh`
if [ "$version" != "$ver" ]; then
    rm /usr/local/bin/bhyz
    a=1
    function install(){
    curl -o bhyz https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/Yunzai-shell.sh
    mv bhyz /usr/local/bin/bhyz
    chmod +x /usr/local/bin/bhyz
    }
    install > /dev/null 2>&1 &
    {
       until command -v bhyz
        do
          a=$(($a+1))
          sleep 0.05s
          echo ${a}
        done
    } | whiptail --gauge "检测到新版本 正在更新" 6 60 0
    if ! [ -x "/usr/local/bin/bhyz" ];then
    whiptail --title "白狐≧▽≦" --msgbox \
    "安装失败 请检查网络" \
    8 25
    exit
    fi
    Aword=`curl -s https://api.vvhan.com/api/ian`
    whiptail --title "白狐≧▽≦" --msgbox \
    "${Aword}" \
    10 50
    bhyz
fi
#########################################################
function install(){
if ! apt install -y ^language-pack-zh fonts-wqy-microhei fonts-wqy-zenhei redis redis-server tmux
then
  echo -e ${red} 依赖安装失败 ${background}
  exit
fi
echo

if ! apt install -y chromium-browser
then
  echo -e ${red} 依赖安装失败 ${background}
  exit
fi
echo

case $(uname -m) in
  aarch64|arm64)
    node=arm64
    ;;
  amd64|x86_64)
    node=x64
    ;;
  arm|armel|armhf|armhfp|armv7|armv7l|armv7a|armv8l)
    node=armv7l
    ;;
  386|i386|i686|x86)
    echo -e "\033[31m暂不支持您的设备\033[0m"
    exit
    ;;
  *)
    echo -e "\033[31m暂不支持您的设备\033[0m"
    exit
    ;;
esac
if ! [ -x "$(command -v gzip)" ]
    then
    echo -e ${yellow}检测到未安装gzip 开始安装${background}
    apt update
    apt install gzip -y
    echo
fi
awk '{print $2}' /etc/issue > log
if grep -q 22.10 log ;then > /dev/null
NodeVersion1=v18.x
NodeVersion2=v18.16.0
elif grep -q 22.04 log ;then
NodeVersion1=v18.x
NodeVersion2=v18.16.0
elif grep -q 18.04 log ;then
NodeVersion1=v17.x
NodeVersion2=v17.9.0
else
NodeVersion1=v17.x
NodeVersion2=v17.9.0
fi
echo -e ${yellow}正在下载Node.js 请稍等${background}
if ! curl -o node.tar.gz https://cdn.npmmirror.com/binaries/node/latest-${NodeVersion1}/node-${NodeVersion2}-linux-${node}.tar.gz
  then
    echo -e ${red} Node.js下载失败失败 ${background}
    exit
fi
echo

mkdir -p /usr/local/lib/nodejs
echo -e ${yellow}正在解压Node.js 请稍等${background}
if ! tar -xzf node.tar.gz -C /usr/local/lib/nodejs && node.tar.gz
then
    echo -e ${red} Node.js下载解压失败 ${background}
    exit
fi
echo

echo "# Nodejs
DISTRO=${node}
export PATH=/usr/local/lib/nodejs/node-${NodeVersion2}-linux-${DISTRO}/lib/node_modules:$PATH" > ~/.profile
source ~/.profile

file=/usr/local/lib/nodejs/node-${NodeVersion2}-linux-${node}/lib/node_modules
#npm
ln -sf ${file}/npm/bin/npm-cli.js /usr/local/bin/npm
#pnpm
#pm2
ln -sf ${file}/pm2/bin/pm2 /usr/local/bin/pnpm

file=/usr/local/lib/node_modules/
ln -sf ${file}/node /usr/local/bin/node
ln -sf ${file}/npm /usr/local/bin/npm

echo -e ${yellow}正在使用npm安装pnpm 更新提示不用管${background}
npm config set registry https://registry.npmmirror.com
if ! npm install -g pnpm && ln -sf ${file}/pnpm/bin/pnpm.cjs /usr/local/bin/pnpm
then
  echo -e ${red} pnpm安装失败 ${background}
  exit
fi
echo

echo -e ${yellow}正在使用npm安装依赖pm2${background}
if ! npm install -g pm2 && ln -sf ${file}/pm2/bin/pm2 /usr/local/bin/pm2
then
  echo -e ${red} pm2安装失败 ${background}
  exit
fi

echo -e ${yellow}正在使用npm安装依赖cnpm${background}
if ! npm install -g pm2 && ln -sf ${file}/pm2/bin/pm2 /usr/local/bin/pm2
then
  echo -e ${red} pm2安装失败 ${background}
  exit
fi

echo -e ${yellow}正在使用pnpm安装依赖${background}
cd ./fox@bot/${name}
pnpm install -P && pnpm install
icqq_local=`grep icqq package.json`
icqq_latest=`curl -sL https://raw.github.com/icqqjs/icqq/main/package.json | grep version | awk '{print $2}' | sed 's/\"//g' | sed 's/,//g'`
sed -i 's/${icqq_local}/"icqq": "^${icqq_latest}",/g' package.json
rm node_modules/puppeteer node_modules/icqq
pnpm install puppeteer@19.0.0 icqq@latest -w
echo

echo -e ${yellow}正在安装ffmpeg${background}
bash <(curl -sL https://gitee.com/baihu433/ffmpeg/raw/master/ffmpeg.sh)
echo
echo > $HOME/.baihu.log
} #install
#########################################################
function install_Yunzai_Bot(){
if ! [ -d fox@bot/${name} ];then
  if (whiptail --title "白狐" \
     --yes-button "安装" \
     --no-button "返回" \
     --yesno "${name}未安装，是否开始安装?" 10 50)
     then
       if (whiptail --title "白狐" \
       --yes-button "Gitee" \
       --no-button "Github" \
       --yesno "请选择${name}的下载服务器\n国内用户建议选择Gitee" 10 50)
         then
           if ! git clone --depth=1 ${Gitee} ./fox@bot/${name};then
             echo -e ${red} 克隆失败 ${cyan}试试Github ${background}
             exit
           fi
         else
           if ! git clone --depth=1 ${Github} ./fox@bot/${name};then
             echo -e ${red} 克隆失败 ${cyan}试试Gitee ${background}
             exit
           fi
       fi     
  fi
fi
if [ ! -e .baihu.log ];then
install
fi
} #install_Yunzai_Bot
#########################################################
function install_Miao_Yunzai(){
if ! [ -d fox@bot/${name} ];then
  if (whiptail --title "白狐" \
     --yes-button "安装" \
     --no-button "返回" \
     --yesno "${name}未安装，是否开始安装?" 10 50)
     then
       if (whiptail --title "白狐" \
       --yes-button "Gitee" \
       --no-button "Github" \
       --yesno "请选择${name}的下载服务器\n国内用户建议选择Gitee" 10 50)
         then
           if ! git clone --depth=1 ${GiteeMZ} ./fox@bot/${name};then
             echo -e ${red} 克隆失败 ${cyan}试试Github ${background}
             exit
           fi
         else
           if ! git clone --depth=1 ${GithubMZ} ./fox@bot/${name};then
             echo -e ${red} 克隆失败 ${cyan}试试Gitee ${background}
             exit
           fi
         install_Miao_Plugin
       fi     
  fi
fi
if [ ! -e .baihu.log ];then
install
fi
} #install_Miao_Yunzai
######################################################### 

#########################################################
function install_Miao_Plugin(){
if (whiptail --title "白狐" \
--yes-button "Gitee" \
--no-button "Github" \
--yesno "请选择${name}的下载服务器\n国内用户建议选择Gitee" 10 50)
  then
    if ! git clone --depth=1 ${GiteeMP} ./fox@bot/${name}/plugins/miao-plugin
    then
      echo -e ${red} 克隆失败 ${cyan}试试Github ${background}
      exit
    fi
  else
    if ! git clone --depth=1 ${GithubMP} ./fox@bot/${name}/plugins/miao-plugin
    then
      echo -e ${red} 克隆失败 ${cyan}试试Gitee ${background}
      exit
    fi
fi
} #install_Miao_Plugin
#########################################################
function help(){
echo ${cyan} 正在咕咕 回车返回${background};read
}
function error(){
ErrorRepair=$(whiptail \
--title "白狐≧▽≦" \
--menu "${ver}" \
20 30 12 \
"1" "修复chromium启动失败" \
"2" "修复chromium调用失败" \
"3" "修改${name}主人QQ" \
"4" "管理${name}插件" \
"5" "${name}无法登录" \
"6" "前台启动${name}" \
"7" "备份${name}数据" \
"8" "清楚${name}数据" \
"9" "${name}报错修复" \
"10" "白狐脚本帮助" \
"0" "返回" \
3>&1 1>&2 2>&3)





)




}
function main(){
path=fox@bot/${name}
cd ${path}
baihu=$(whiptail \
--title "白狐≧▽≦" \
--menu "${ver}" \
20 45 12 \
"1" "打开${name}窗口" \
"2" "后台启动${name}" \
"3" "停止${name}运行" \
"4" "管理${name}插件" \
"5" "${name}无法登录" \
"6" "${name}前台启动" \
"7" "备份${name}数据" \
"8" "清楚${name}数据" \
"9" "${name}报错修复" \
"10" "白狐脚本帮助" \
"0" "返回" \
3>&1 1>&2 2>&3)
if ! $? neq 0 then
return
fi
case ${baihu} in 
1)

;;
2)

;;
3)

;;
4)

;;
5)

;;
6)

;;
7)

;;
8)

;;
9)
error
;;
10)
help
;;
0)
return
;;
}
#########################################################
function install_bot(){
cd ~
if ! [ -d fox@bot ];then
mkdir fox@bot
fi
red="\033[31m"
green="\033[32m"
yellow="\033[33m"
blue="\033[34m"
purple="\033[35m"
cyan="\033[36m"
white="\033[37m"
background="\033[0m"
Number=$(whiptail \
--title "白狐 QQ群:705226976" \
--menu "请选择bot" \
20 40 10 \
"1" "Le-Yunzai" \
"2" "Miao-Yunzai" \
"3" "TRSS-Yunzai" \
"4" "yunzai-bot-lite" \
"5" "alemon-bot" \
"0" "退出" \
3>&1 1>&2 2>&3)
case ${Number} in
1)
name=Yunzai-Bot
Gitee=https://gitee.com/yoimiya-kokomi/Yunzai-Bot.git
#GithubYZ=https://github.com/yoimiya-kokomi/Yunzai-Bot.git
install_Yunzai_Bot
main
;;
2)
name=Miao-Yunzai
GiteeMZ=https://gitee.com/yoimiya-kokomi/Miao-Yunzai.git
GiteeMP=https://gitee.com/yoimiya-kokomi/miao-plugin.git
GithubMZ=https://github.com/yoimiya-kokomi/Miao-Yunzai.git
GithubMP=https://github.com/yoimiya-kokomi/miao-plugin.git
install_Miao_Yunzai
install_Miao_Plugin
main
;;
3)
whiptail --title "白狐≧▽≦" --msgbox "
TRSS-Yunzai的安装正在咕咕
" 10 43
#name=TRSS-Yunzai
#GiteeTY=https://gitee.com/TimeRainStarSky/Yunzai.git
#GiteeMP=https://gitee.com/yoimiya-kokomi/miao-plugin.git
#GithubTY=https://github.com/TimeRainStarSky/Yunzai.git
#GithubMP=https://github.com/yoimiya-kokomi/miao-plugin.git
#main
;;
4)
name=Yunzai-Bot-Lite
Gitee=https://gitee.com/Nwflower/yunzai-bot-lite.git
Github=https://github.com/Nwflower/yunzai-bot-lite.git
install_Yunzai_Bot
main
;;
5)
name=Alemon-Bot
Gitee=https://gitee.com/ningmengchongshui/alemon-bot.git
Github=https://github.com/ningmengchongshui/alemon-bot.git
install_Yunzai_Bot
main
;;
0)
exit
;;
esac
}
function mainbak()
{
   while true
   do
       install_bot
       mainbak
   done
}
mainbak