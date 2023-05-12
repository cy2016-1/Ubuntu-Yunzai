#!/bin/env bash
#if ping -c 1 baidu.com &> /dev/null
#then
#   Git=gitee
#elif ping -c 1 google.com &> /dev/null
#then
#   Git=github
#fi
function cs(){
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
}
#########################################################
function install(){
echo -e ${yellow}正在更新软件源${background}
until apt-get -y update
do
echo -e ${red}软件源更新失败 ${green}正在重试${background}
done
echo

if ! [ -x "$(command -v fonts-wqy-microhei)" ] && [ -x "$(command -v fonts-wqy-zenhei)" ];then
    echo -e ${yellow}安装中文字体${background}
    until apt install -y fonts-wqy-microhei fonts-wqy-zenhei
    do
      echo -e ${red}中文字体安装失败 ${green}正在重试${background}
    done
fi
echo

if ! [ -x "$(command -v redis-server)" ];then
    echo -e ${yellow}安装redis数据库${background}
    until apt install -y redis redis-server
    do
      echo -e ${red}redis数据库安装失败 ${green}正在重试${background}
    done
fi
echo

if ! [ -x "$(command -v chromium-browser)" ];then
    echo -e ${yellow}安装chromium浏览器${background}
    until apt install -y chromium-browser
    do
       echo -e ${red}chromium浏览器安装失败 ${green}正在重试${background}
    done
fi
echo

function nodejs_install(){
if awk '{print $2}' /etc/issue | grep -q -E 22.*
then
  echo -e ${yellow}安装nodejs${background}
  rm /etc/apt/sources.list.d/nodesource.list > /dev/null 2>&1
  bash <(curl -sL https://deb.nodesource.com/setup_18.x)
else
  echo -e ${yellow}安装nodejs${background}
  rm /etc/apt/sources.list.d/nodesource.list > /dev/null 2>&1
  curl -sL https://deb.nodesource.com/setup_17.x | sed "s/sleep 20/sleep 2/g" | sed "s/Continuing in 20 seconds .../Continuing in 2 seconds .../g" | bash
fi
apt autoremove -y nodejs
apt update -y
apt install -y nodejs
echo
} #nodejs_install
Nodsjs_Version=$(node -v | cut -d '.' -f1)
if ! [[ "$Nodsjs_Version" == "v16" || "$Nodsjs_Version" == "v17" || "$Nodsjs_Version" == "v18" || "$Nodsjs_Version" == "v19" || "$Nodsjs_Version" == "v20" ]] && ! [ -x "$(command -v npm)" ];then
  echo -e ${yellow}安装nodejs和npm${background}
  until nodejs_install
  do
    echo -e ${red}NodeJS和npm安装失败 ${green}正在重试${background}
  done
fi
echo

if ! [ -x "$(command -v pnpm)" ];then
    echo -e ${yellow}正在使用npm安装pnpm${background}
    npm config set registry https://registry.npmmirror.com
    until npm install -g pnpm
    do
      echo -e ${red}pnpm安装失败 ${green}正在重试${background}
    done
fi
echo

if ! [ -x "$(command -v pm2)" ];then
    echo -e ${yellow}正在使用npm安装pm2${background}
    npm config set registry https://registry.npmmirror.com
    until npm install -g pm2
    do
      echo -e ${red}pm2安装失败 ${green}正在重试${background}
    done
fi

echo -e ${yellow}正在使用pnpm安装依赖${background}
cd ./fox@bot/${name}
until echo Y | pnpm install && echo Y | pnpm install
do
echo -e ${red}依赖安装失败 ${green}正在重试${background}
pnpm setup
done
echo

if ! [ -x "$(command -v ffmpeg)" ];then
    echo -e ${yellow}正在安装ffmpeg${background}
    until bash <(curl -sL https://gitee.com/baihu433/ffmpeg/raw/master/ffmpeg.sh)
    do
        echo -e ${red}ffmpeg安装失败 ${cyan}正在重试${background}
    done
fi
echo
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
       install
  fi
else
main
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
     install
  fi
else
main
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
echo ${cyan} 正在咕咕 回车返回${background}
read
}
function error(){
ErrorRepair=$(whiptail \
--title "白狐≧▽≦" \
--menu "${ver}" \
20 45 15 \
"1" "修复chromium启动失败" \
"2" "修复chromium调用失败" \
"3" "修改${name}主人qq" \
"4" "修改登录设备" \
"0" "返回" \
3>&1 1>&2 2>&3)
feedback=$?
if ! [ $feedback = 0 ]
then
return
fi
case ErrorRepair in
1)
bash <(curl https://gitee.com/baihu433/chromium/raw/master/chromium.sh)
;;
2)
pnpm install
pnpm uninstall puppeteer
pnpm install puppeteer@19.0.0 -w
node ./node_modules/puppeteer/install.js
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
;;
4)
pushd ~/Yunzai-Bot
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
new="platform: ${equipment}"
file="$HOME/Yunzai-Bot/config/config/qq.yaml"
old_equipment="platform: [0-5]"
new_equipment="platform: ${equipment}"
sed -i "s/$old_equipment/$new_equipment/g" $file
rm $HOME/Yunzai-Bot/data/device.json
;;
esac
}
function main(){
path=fox@bot/${name}
cd ${path}
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
"9" "帮助[实时更新]" \
"0" "返回" \
3>&1 1>&2 2>&3)
feedback=$?
if ! [ $feedback = 0 ]
then
return
fi
case ${baihu} in 
1)
cd ~/fox@bot/${name}
pnpm run log
echo
echo -e ${cyan}回车返回${background};read
;;
2)
Redis=$(redis-cli ping)
if ! [ "${Redis}" = "PONG" ]; then
 redis-server --daemonize yes &
 echo
fi
cd ~/fox@bot/${name}
pnpm run start
echo -en ${yellow}${name}启动完成 ${green}是否打开日志 ${cyan}[Y/n] ${background}
read -p "" num
      case $num in
     Y|y)
       cd ~/fox@bot/${name}
       pnpm run log
       echo
       echo -e ${cyan}回车返回${background};read
       ;;
     n|N)
       echo -e ${cyan}回车返回${background};read
       ;;
     *)
       echo -e ${cyan}回车返回${background};read
       ;;
       esac
;;
3)
cd ~/fox@bot/${name}
pnpm stop
echo
echo -e ${cyan}回车返回${background};read
;;
4)
bash <(curl -sL https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/plug-in.sh)
;;
5)
Redis=$(redis-cli ping)
if ! [ "${Redis}" = "PONG" ]; then
 redis-server --daemonize yes &
 echo
fi
cd ~/fox@bot/${name}
pnpm run login
echo
echo -e ${cyan}回车返回${background};read
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
cd ~/fox@bot/${name}
pnpm run stop
node app
echo
echo -e ${cyan}回车返回${background};read
;;
8)
error
;;
9)
help
;;
0)
return
;;
esac
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
"1" "Yunzai[icqq版]" \
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