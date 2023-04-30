#!/bin/env bash



if ping -c 1 baidu.com &> /dev/null
then
   Git=gitee
elif ping -c 1 google.com &> /dev/null
then
   Git=github
fi






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
if ! apt install -y ^language-pack-zh fonts-wqy-microhei fonts-wqy-zenhei redis redis-server aria2 tmux
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

echo -e ${yellow}正在安装nvm${background}
if ! bash -c "$(curl -fsSL https://gitee.com/RubyKids/nvm-cn/raw/main/install.sh)"
then
  echo -e ${red} nvm安装失败 ${background}
  exit
fi
#刷新环境变量
source ~/.bashrc
echo

echo -e ${yellow}正在使用nvm安装node和npm${background}
if ! nvm install 17.9.0
then
  echo -e ${red} nvm安装失败 ${background}
  exit
fi
source ~/.bashrc
echo

echo -e ${yellow}正在使用npm安装pnpm${background}
npm config set registry https://registry.npmmirror.com
if ! npm install -g pnpm
then
  echo -e ${red} pnpm安装失败 ${background}
  exit
fi
echo

echo -e ${yellow}正在使用pnpm安装依赖${background}
if ! pnpm install -g pm2
then
  echo -e ${red} pm2安装失败 ${background}
  exit
fi

echo -e ${yellow}正在使用pnpm安装依赖${background}
cd ./fox@bot/${name}
pnpm install -P && pnpm install
rm node_modules/puppeteer node_modules/icqq
pnpm install puppeteer@19.0.0 icqq@latest -w
echo

echo -e ${yellow}正在安装ffmpeg${background}
bash <(curl -sL https://gitee.com/baihu433/ffmpeg/raw/master/ffmpeg.sh)
echo
echo > .baihu.log
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
           if ! git clone --depth=1 ${Github} ./fox@bot/${name}
             echo -e ${red} 克隆失败 ${cyan}试试Gitee ${background}
             exit
           fi
       fi     
  fi
fi
if [ -e .baihu.log ];then
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
           if ! git clone --depth=1 ${GithubMZ} ./fox@bot/${name}
             echo -e ${red} 克隆失败 ${cyan}试试Gitee ${background}
             exit
           fi
         install_Miao_Plugin
       fi     
  fi
fi
if [ -e .baihu.log ];then
install
fi
} #install_Miao_Yunzai
#########################################################
function 







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
;;
2)
name=Miao-Yunzai
GiteeMZ=https://gitee.com/yoimiya-kokomi/Miao-Yunzai.git
GiteeMP=https://gitee.com/yoimiya-kokomi/miao-plugin.git
GithubMZ=https://github.com/yoimiya-kokomi/Miao-Yunzai.git
GithubMP=https://github.com/yoimiya-kokomi/miao-plugin.git
;;
3)
name=Yunzai-Bot-Lite
Gitee=https://gitee.com/Nwflower/yunzai-bot-lite.git
Github=https://github.com/Nwflower/yunzai-bot-lite.git
install_Yunzai_Bot
;;
4)
name=TRSS-Yunzai
GiteeTY=https://gitee.com/TimeRainStarSky/Yunzai.git
GiteeMP=https://gitee.com/yoimiya-kokomi/miao-plugin.git
GithubTY=https://github.com/TimeRainStarSky/Yunzai.git
GithubMP=https://github.com/yoimiya-kokomi/miao-plugin.git
;;
5)
name=Alemon-Bot
GiteeAB=https://gitee.com/ningmengchongshui/alemon-bot.git
GithubAB=https://github.com/ningmengchongshui/alemon-bot.git
install_Yunzai_Bot
;;
0)
exit
;;
esac