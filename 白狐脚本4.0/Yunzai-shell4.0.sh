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
echo -e ${yellow}正在更新软件源${background}
if ! apt-get -y update
  then
    echo -e ${red}更新软件源失败${background}
    exit
fi
echo

if ! [ -x "$(command -v fonts-wqy-microhei)" ] && [ -x "$(command -v fonts-wqy-zenhei)" ];then
    echo -e ${yellow}安装中文字体${background}
    if ! apt install -y fonts-wqy-microhei fonts-wqy-zenhei
      then
        echo -e ${red}安装中文字体失败${background}
        exit
    fi
fi
echo

if ! [ -x "$(command -v redis-server)" ];then
    echo -e ${yellow}安装redis数据库${background}
    if ! apt install -y redis redis-server
      then
        echo -e ${red}安装redis数据库失败${background}
        exit
    fi
fi
echo

if ! [ -x "$(command -v chromium-browser)" ];then
    echo -e ${yellow}安装chromium浏览器${background}
    if ! apt install -y chromium-browser
      then
        echo -e ${red}安装chromium浏览器失败${background}
        exit
    fi
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
  rm setup_17.x
  curl -O https://deb.nodesource.com/setup_17.x
  sed -i "s/sleep 20/sleep 2/g" setup_17.x
  sed -i "s/Continuing in 20 seconds .../Continuing in 2 seconds .../g" setup_17.x
  bash setup_17.x
  rm setup_17.x > /dev/null 2>&1
fi
apt autoremove -y nodejs
apt update -y
apt install -y nodejs
echo
} #nodejs_install
Nodsjs_Version=$(node -v | cut -d '.' -f1)
if ! [[ "$Nodsjs_Version" == "v16" || "$Nodsjs_Version" == "v17" || "$Nodsjs_Version" == "v18" || "$Nodsjs_Version" == "v19" || "$Nodsjs_Version" == "v20" ]];then
  echo -e ${yellow}安装nodejs和npm${background}
  until nodejs_install
  do
    nodejs_install
  done
fi
echo


if ! [ -x "$(command -v pnpm)" ];then
    echo -e ${yellow}正在使用npm安装pnpm${background}
    npm config set registry https://registry.npmmirror.com
    if ! npm install -g pnpm
      then
        echo -e ${red}pnpm安装失败${background}
        exit
    fi
fi
echo

echo -e ${yellow}正在使用pnpm安装依赖${background}
cd ./fox@bot/${name}
pnpm install -P && pnpm install
icqq_local=`grep icqq package.json | awk '{print $2}' | sed 's/\"//g' | sed 's/,//g' | sed 's/\^//g'`
icqq_latest=`curl -sL https://raw.github.com/icqqjs/icqq/main/package.json | grep version | awk '{print $2}' | sed 's/\"//g' | sed 's/,//g'`
if test -z "${icqq_latest}";then
  icqq_latest=`curl -sL https://ghproxy.com/https://raw.github.com/icqqjs/icqq/main/package.json | grep version | awk '{print $2}' | sed 's/\"//g' | sed 's/,//g'`
    if test -z "${icqq_latest}";then 
      icqq_latest=`curl -sL https://gitee.com/baihu433/icqq/raw/main/package.json | grep version | awk '{print $2}' | sed 's/\"//g' | sed 's/,//g'`
        if test -z "${icqq_latest}";then 
          echo -e ${red}请检查网络${background}
          exit
        fi
    fi
fi
if ! [ ${icqq_latest} = "0.3.2" ];then
  if [ "${icqq_local}" != "${icqq_latest}" ];then
    sed -i "s/\"icqq\": \"^${icqq_local}\",/\"icqq\": \"^${icqq_latest}\",/g" package.json
  fi
fi
rm node_modules/puppeteer node_modules/icqq
pnpm install puppeteer@19.0.0 icqq@0.3.1 -w
echo

if ! [ -x "$(command -v ffmpeg)" ];then
    echo -e ${yellow}正在安装ffmpeg${background}
    if ! bash <(curl -sL https://gitee.com/baihu433/ffmpeg/raw/master/ffmpeg.sh)
      then
        echo -e ${red}ffmpeg安装失败${background}
        exit
    fi
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
  fi
fi
install
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
install
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
echo -e ${green}tmux使用教程${background}
echo -e ${green}如果要退出窗口 请使用 ${yellow} CTRL + b d ${background}
echo -e ${green}如果要切换窗口 请使用 ${yellow} CTRL + b s ${background}
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
case ErrorRepair in
1)
bash <(curl https://gitee.com/baihu433/chromium/raw/master/chromium.sh)
;;
2)
pnpm install
rm node_modules/puppeteer
pnpm install puppeteer@19.0.0 -w
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
"1" "打开${name}窗口" \
"2" "后台启动${name}" \
"3" "停止${name}运行" \
"4" "管理${name}插件" \
"5" "${name}无法登录" \
"6" "前台启动${name}" \
"7" "备份${name}数据" \
"8" "清楚${name}数据" \
"9" "${name}报错修复" \
"10" "帮助[实时更新]" \
"0" "返回" \
3>&1 1>&2 2>&3)
if ! $? neq 0 then
return
fi
case ${baihu} in 
1)
pnpm
;;
2)
cd /root/fox@bot/${name}
pnpm run start
echo -e ${cyan}回车返回${background};read
;;
3)
tmux kill-session -t ${name}
cd ~/fox@bot/${name} && pnpm stop && cd
echo
echo -e ${cyan}执行完成 回车返回${background};read
;;
4)
bash <(curl -sL https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/plug-in.sh)
;;
5)
bash <(curl -sL https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/version.sh)
;;
6)
cd ~/fox@bot/${name} && node app
echo
echo -e ${cyan}回车返回${background};read
;;
7)
echo -e ${cyan}还没写 回车返回${background};read
;;
8)
echo -e ${cyan}还没写 回车返回${background};read
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