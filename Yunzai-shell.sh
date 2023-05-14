#!/bin/bash
#if ping -c 1 baidu.com &> /dev/null
#then
#   Git=gitee
#elif ping -c 1 google.com &> /dev/null
#then
#   Git=github
#fi
if [ -d ~/fox@bot ];then
  mv fox@bot .fox@bot
  rm -rf fox@bot > /dev/null
fi

if ! [ -L ~/Yunzai-Bot ];then
  if [ ! -d ~/.fox@bot ];then
    mkdir ~/.fox@bot
  fi
    mv ~/Yunzai-Bot ~/.fox@bot/Yunzai-Bot
    ln -sf ~/.fox@bot/Yunzai-Bot ~/Yunzai-Bot
fi

if [ -e .baihu ];then
  rm .baihu
  sed -i "s/cat \/root\/.baihu//g" .bashrc
fi
ver=4.4.5.9
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
echo
echo -e ${yellow}正在更新软件源${background}
until apt-get -y update
do
echo -e ${red}软件源更新失败 ${green}正在重试${background}
done
echo

if ! [ -x "$(command -v fonts-wqy-microhei)" ] && [ -x "$(command -v fonts-wqy-zenhei)" ];then
    echo -e ${yellow}安装中文字体${background}
    until apt install -y fonts-wqy-microhei fonts-wqy-zenhei  language-pack-zh*
    do
      echo -e ${red}中文字体安装失败 ${green}正在重试${background}
    done
    echo "LANG=\"zh_CN.UTF-8\"
    export LANG">>/etc/profile
    source /etc/profile
    echo
fi

if ! [ -x "$(command -v redis-server)" ];then
    echo -e ${yellow}安装redis数据库${background}
    until apt install -y redis redis-server
    do
      echo -e ${red}redis数据库安装失败 ${green}正在重试${background}
    done
    echo
fi

if ! [ -x "$(command -v chromium-browser)" ];then
    echo -e ${yellow}安装chromium浏览器${background}
    until apt install -y chromium-browser
    do
       echo -e ${red}chromium浏览器安装失败 ${green}正在重试${background}
    done
    echo
fi

function setup_nodejs_install(){
if awk '{print $2}' /etc/issue | grep -q -E 22.*
then
  echo -e ${yellow}安装nodejs${background}
  rm /etc/apt/sources.list.d/nodesource.list > /dev/null 2>&1
  curl https://deb.nodesource.com/setup_18.x | bash
else
  echo -e ${yellow}安装nodejs${background}
  rm /etc/apt/sources.list.d/nodesource.list > /dev/null 2>&1
  curl https://deb.nodesource.com/setup_16.x | bash # | sed "s/sleep 20/sleep 2/g" | sed "s/Continuing in 20 seconds .../Continuing in 2 seconds .../g" | bash
fi
apt autoremove -y nodejs
curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | gpg --dearmor | tee /usr/share/keyrings/nodesource.gpg >/dev/null
apt update -y
apt install -y nodejs
echo
} #nodejs_install

function nvm_nodejs_install(){
curl https://ghproxy.com/https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | sed 's/https:\/\/ghproxy.com\/https:\/\/raw.githubusercontent.com/https:\/\/raw.githubusercontent.com/' | bash
source ~/.bashrc
export NVM_NODEJS_ORG_MIRROR=https://mirrors.ustc.edu.cn/node/
if awk '{print $2}' /etc/issue | grep -q -E 22.*
then
  nvm install --lts
else
  nvm install 16.19.0
fi
source ~/.bashrc
echo
}

Nodsjs_Version=$(node -v | cut -d '.' -f1)
if ! [[ "$Nodsjs_Version" == "v16" || "$Nodsjs_Version" == "v17" || "$Nodsjs_Version" == "v18" || "$Nodsjs_Version" == "v19" || "$Nodsjs_Version" == "v20" ]] && ! [ -x "$(command -v npm)" ];then
  if (whiptail --title "白狐" \
   --yes-button "nvm" \
   --no-button "setup" \
   --yesno "请选择nodejs安装方式 \n国内用户建议使用nvm脚本安装 \n国际用户建议使用setup脚本安装" 10 50)
   then
     nodejs_install=setup_nodejs_install
   else
     nodejs_install=nvm_nodejs_install
  fi
  echo -e ${yellow}安装nodejs和npm${background}
  until ${nodejs_install}
  do
    echo -e ${red}NodeJS和npm安装失败 ${green}正在重试${background}
  done
  echo
fi

if ! [ -x "$(command -v pnpm)" ];then
    echo -e ${yellow}正在使用npm安装pnpm${background}
    npm config set registry https://registry.npmmirror.com
    until npm install -g pnpm
    do
      echo -e ${red}pnpm安装失败 ${green}正在重试${background}
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

echo -e ${yellow}正在使用pnpm安装依赖${background}
cd ~/.fox@bot/${name}
pnpm config set registry https://registry.npmmirror.com
until echo "Y" | pnpm install -P && echo "Y" | pnpm install
do
echo -e ${red}依赖安装失败 ${green}正在重试${background}
pnpm setup
source ~/.bashrc
done

if ! [ -x "$(command -v ffmpeg)" ];then
    echo -e ${yellow}正在安装ffmpeg${background}
    until bash <(curl -sL https://gitee.com/baihu433/ffmpeg/raw/master/ffmpeg.sh)
    do
        echo -e ${red}ffmpeg安装失败 ${cyan}正在重试${background}
    done
    echo
fi
} #install
#########################################################
function install_Yunzai_Bot(){
if ! [ -d ~/.fox@bot/${name} ];then
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
           if ! git clone --depth=1 ${Gitee} ~/.fox@bot/${name};then
             echo -e ${red} 克隆失败 ${cyan}试试Github ${background}
             exit
           fi
         else
           if ! git clone --depth=1 ${Github} ~/.fox@bot/${name};then
             echo -e ${red} 克隆失败 ${cyan}试试Gitee ${background}
             exit
           fi
       fi
       ln -sf ~/.fox@bot/${name} ~/${name}
       install
       main
  fi
else
bot_path
main
fi
} #install_Yunzai_Bot
#########################################################
function install_Miao_Yunzai(){
if ! [ -d ~/.fox@bot/${name} ];then
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
           if ! git clone --depth=1 ${GiteeMZ} ~/.fox@bot/${name};then
             echo -e ${red} 克隆失败 ${cyan}试试Github ${background}
             exit
           fi
         else
           if ! git clone --depth=1 ${GithubMZ} ~/.fox@bot/${name};then
             echo -e ${red} 克隆失败 ${cyan}试试Gitee ${background}
             exit
           fi
       fi
     ln -sf ~/.fox@bot/${name} ~/${name}
     install_Miao_Plugin
     install
     main
  fi
else
bot_path
main
fi
} #install_Miao_Yunzai
######################################################### 

#########################################################
function install_Miao_Plugin(){
if (whiptail --title "白狐" \
--yes-button "Gitee" \
--no-button "Github" \
--yesno "请选择的miao-plugin下载服务器\n国内用户建议选择Gitee" 10 50)
  then
    if ! git clone --depth=1 ${GiteeMP} ~/.fox@bot/${name}/plugins/miao-plugin
    then
      echo -e ${red} 克隆失败 ${cyan}试试Github ${background}
      exit
    fi
  else
    if ! git clone --depth=1 ${GithubMP} ~/.fox@bot/${name}/plugins/miao-plugin
    then
      echo -e ${red} 克隆失败 ${cyan}试试Gitee ${background}
      exit
    fi
fi
} #install_Miao_Plugin
#########################################################
function help(){
echo -en ${cyan} 正在咕咕 回车返回${background}
read
}
function error(){
ErrorRepair=$(whiptail \
--title "白狐≧▽≦" \
--menu "${ver}" \
20 40 10 \
"1" "修复chromium启动失败" \
"2" "修复chromium调用失败" \
"3" "修改${name}主人qq" \
"4" "修改登录设备" \
"5" "修复redis数据库" \
"0" "返回" \
3>&1 1>&2 2>&3)
feedback=$?
if ! [ $feedback = 0 ]
then
return
fi
case ${ErrorRepair} in
1)
bash <(curl https://gitee.com/baihu433/chromium/raw/master/chromium.sh)
echo -e ${green}回车返回${background};read
;;
2)
cd ${name}
pnpm install
pnpm uninstall puppeteer
pnpm install puppeteer@19.0.0 -w
node ./node_modules/puppeteer/install.js
echo -e ${green}回车返回${background};read
;;
3)
qq=$(whiptail \
--title "白狐≧▽≦" \
--inputbox "请输入您要更改后的主人qq号" \
10 60 \
3>&1 1>&2 2>&3)
if [[ ${qq} =~ ^[0-9]+$ ]]; then
  if [ ${qq} -gt 9999 ]; then
    sed -i '7s/.*/'" - $qq"'/' $HOME/Yunzai-Bot/config/config/other.yaml
    whiptail --title "白狐≧▽≦" --msgbox \
    "主人QQ已更改为${qq}" \
    10 60
  else
    echo -e ${red}请输入正确的QQ!${background}
    exit
  fi
else
    echo -e ${red}请输入正确的QQ号${background}
    exit
fi
echo -e ${green}回车返回${background};read
;;
4)
cd ~/.fox@bot/${name}
equipment=$(whiptail \
--title "白狐≧▽≦" \
--menu "请选择登录设备" \
17 35 7 \
"1" "安卓手机" \
"2" "aPad" \
"3" "安卓手表" \
"4" "MacOS" \
"5" "iPad" \
"6" "old_Android" \
3>&1 1>&2 2>&3)
feedback=$?
if ! [ $feedback = 0 ]
then
return
fi
new="platform: ${equipment}"
file="~/.fox@bot/${name}/config/config/qq.yaml"
old_equipment="platform: [0-5]"
new_equipment="platform: ${equipment}"
sed -i "s/${old_equipment}/${new_equipment}/g" ${file}
rm ~/.fox@bot/${name}/data/device.json
echo -e ${green}回车返回${background};read
;;
5)
apt autoremove -y redis redis-server
apt install -y redis redis-server
echo -e ${green}回车返回${background};read
;;
esac
}
function main(){
baihu=$(whiptail \
--title "白狐≧▽≦" \
--menu "${ver}" \
20 45 12 \
"1" "打开${name}日志" \
"2" "后台启动${name}" \
"3" "停止${name}运行" \
"4" "管理${name}插件" \
"5" "${name}重新登陆" \
"6" "${name}无法登录" \
"7" "前台启动${name}" \
"8" "${name}报错修复" \
"9" "白狐脚本附件安装" \
"10" "帮助[实时更新]" \
"11" "卸崽! 删除${name}" \
"0" "返回" \
3>&1 1>&2 2>&3)
feedback=$?
if ! [ $feedback = 0 ]
then
return
fi
case ${baihu} in 
1)
cd ~/${name}
pnpm log
echo
echo -en ${cyan}回车返回${background};read
;;
2)
Redis=$(redis-cli ping)
if ! [ "${Redis}" = "PONG" ]; then
 redis-server &
 echo
fi
cd ~/${name}
pnpm start
echo -e ${yellow}${name}启动完成 ${green}是否打开日志 ${cyan}[Y/n] ${background}
read -p "" num
      case $num in
     Y|y)
       cd ~/.fox@bot/${name}
       pnpm run log
       echo
       echo -en ${cyan}回车返回${background};read
       ;;
     n|N)
       echo -en ${cyan}回车返回${background};read
       ;;
     *)
       echo -en ${cyan}回车返回${background};read
       ;;
       esac
;;
3)
cd ~/${name}
pnpm stop
echo
echo -en ${cyan}回车返回${background};read
;;
4)
bash <(curl -sL https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/plug-in.sh)
;;
5)
Redis=$(redis-cli ping)
if ! [ "${Redis}" = "PONG" ]; then
 redis-server &
 echo
fi
cd ~/${name}
pnpm login
echo
echo -en ${cyan}回车返回${background};read
;;
6)
bash <(curl -sL https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/version.sh)
;;
7)
Redis=$(redis-cli ping)
if ! [ "${Redis}" = "PONG" ]; then
 redis-server --daemonize yes &
 echo
fi
cd ~/${name}
pnpm stop
node app
echo
echo -en ${cyan}回车返回${background};read
;;
8)
error
;;
9)
echo -en ${cyan} 正在咕咕 回车返回${background}
;;
10)
help
;;
11)
echo -e ${yellow}是否删除${red}${name}${cyan}[N/y] ${background};read -p "" num
      case $num in
     Y|y)
       echo -e ${red}3${background}
       sleep 1
       echo -e ${red}2${background}
       sleep 1
       echo -e ${red}1${background}
       sleep 1
       echo -e ${red}正在删除${name}${background}
       rm -rf ~/${name} > /dev/null
       rm -rf ~/${name} > /dev/null
       rm -rf ~/.fox@bot/${name} > /dev/null
       rm -rf ~/.fox@bot/${name} > /dev/null
       echo -en ${cyan}删除完成 回车返回${background}
       ;;
     n|N)
       echo -en ${cyan}回车返回${background};read
       ;;
     *)
       echo -en ${red}输入错误${cyan}回车返回${background};read
       ;;
       esac
;;
0)
return
;;
esac
}
#########################################################
function bot_path(){
if ! [ -L ~/${name} ];then
  if [ ! -d ~/.fox@bot ];then
    mkdir ~/.fox@bot
  fi
    mv ~/${name} ~/.fox@bot/${name}
    ln -sf ~/.fox@bot/${name} ~/${name}
fi
}
#########################################################
function install_bot(){
cd ~
if ! [ -d .fox@bot ];then
mkdir .fox@bot
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
"1" "Yunzai[icqq版]" \
"2" "Miao-Yunzai" \
"3" "TRSS-Yunzai" \
"4" "yunzai-bot-lite" \
"5" "alemon-bot" \
"0" "退出" \
3>&1 1>&2 2>&3)
feedback=$?
if ! [ $feedback = 0 ]
then
exit
fi
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
install_Miao_Yunzai
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
;;
5)
name=Alemon-Bot
Gitee=https://gitee.com/ningmengchongshui/alemon-bot.git
Github=https://github.com/ningmengchongshui/alemon-bot.git
install_Yunzai_Bot
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