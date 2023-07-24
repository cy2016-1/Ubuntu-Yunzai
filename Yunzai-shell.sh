#!/bin/bash
#if ping -c 1 baidu.com &> /dev/null
#then
#   Git=gitee
#elif ping -c 1 google.com &> /dev/null
#then
#   Git=github
#fi
if [ -d /usr/local/node/bin ];then
PATH=$PATH:/usr/local/node/bin
export PNPM_HOME=/usr/local/node/bin
fi
ver=5.4.2
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
    #if ! [ -x "/usr/local/bin/bhyz" ];then
    #whiptail --title "白狐≧▽≦" --msgbox \
    #"安装失败 请检查网络" \
    # 8 25
    #exit
    # fi
    update_log=$(curl -sL https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/update.log)
    echo -e ${update_log}
    echo
    echo -en ${yellow}回车继续${background};read
    if [ -x "/usr/local/bin/bhyz" ];then
    whiptail --title "白狐≧▽≦" --msgbox \
    "安装成功 祝您使用愉快!" \
    8 25
    fi
    bhyz
    exit
fi
#########################################################
function install(){
echo
echo -e ${yellow}正在更新软件源${background}
a=0
until apt-get -y update
do
  echo -e ${red}软件源更新失败 ${green}正在重试${background}
  a=$(($a+1))
  if [ "${a}" == "3" ];then
    echo -e ${red}错误次数过多 退出${background}
    exit
  fi
done
echo

pkg_list=("fonts-wqy-zenhei" "fonts-wqy-microhei")
for pkg in ${pkg_list[@]}; do
if ! dpkg -s ${pkg} >/dev/null 2>&1 ; then
    apt install -y ${pkg}
fi
done

if ! [ -x "$(command -v redis-server)" ];then
    echo -e ${yellow}安装redis数据库${background}
    until apt install -y redis redis-server
    do
      echo -e ${red}redis数据库安装失败 ${green}正在重试${background}
    done
    echo
fi

#if ! [ -x "$(command -v catimg)" ];then
#    echo -e ${yellow}安装catimg${background}
#    until apt install -y catimg
#    do
#      echo -e ${red}catimg安装失败 ${green}正在重试${background}
#    done
#    echo
#fi

function chromium_install(){
echo "deb http://ftp.cn.debian.org/debian sid main" >> /etc/apt/sources.list
apt install -y gnupg gnupg1 gnupg2
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0E98404D386FA1D9 6ED0E7B82643E131
apt-key adv --refresh-keys --keyserver keyserver.ubuntu.com
apt update -y
apt install -y chromium
rm -rf /etc/apt/trusted.gpg
sed -i "s/deb http:\/\/ftp.cn.debian.org\/debian sid main//g" /etc/apt/sources.list
chromium > /dev/null
}

if [ ! -x "$(command -v chromium-browser)" ] ||  [ ! -x "$(command -v chromium)" ] || [ ! -x "$(command -v chrome)" ];then
    echo -e ${yellow}安装chromium浏览器${background}
    if awk '{print $2}' /etc/issue | grep -q -E 20.*
        then
            until chromium_install
            do
               echo -e ${red}chromium浏览器安装失败 ${green}正在重试${background}
            done
    elif awk '{print $2}' /etc/issue | grep -q -E 22.*
        then
            bash <(curl https://gitee.com/baihu433/chromium/raw/master/chromium.sh)
    elif awk '{print $2}' /etc/issue | grep -q -E 23.*
        then
            until chromium_install
            do
               echo -e ${red}chromium浏览器安装失败 ${green}正在重试${background}
            done          
    else
        until apt install -y chromium-browser
            do
               apt install -y chromium-browser
               echo -e ${red}chromium浏览器安装失败 ${green}正在重试${background}
            done
    fi
fi

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

function setup_nodejs_install(){
if awk '{print $2}' /etc/issue | grep -q -E 22.* | grep -q -E 23.*
then
  echo -e ${yellow}安装nodejs${background}
  rm /etc/apt/sources.list.d/nodesource.list > /dev/null 2>&1
  curl https://deb.nodesource.com/setup_18.x | bash
else
  echo -e ${yellow}安装nodejs${background}
  rm /etc/apt/sources.list.d/nodesource.list > /dev/null 2>&1
  curl https://deb.nodesource.com/setup_16.x | bash 
  # | sed "s/sleep 20/sleep 2/g" | sed "s/Continuing in 20 seconds .../Continuing in 2 seconds .../g" | bash
fi
apt autoremove -y nodejs
curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | gpg --dearmor | tee /usr/share/keyrings/nodesource.gpg > /dev/null
apt update -y
apt install -y nodejs
echo
} #nodejs_install
function nvm_nodejs_install(){
rm -rf $HOME/.nvm > /dev/null
echo -e ${yellow}正在安装nvm 这需要一些时间'\n'${cyan}[如果中途没有任何输出 那是在处理安装 请耐心等待]${background}
curl https://ghproxy.com/https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | sed "s/https:\/\/raw.githubusercontent.com/https:\/\/ghproxy.com\/https:\/\/raw.githubusercontent.com/g" | sed "s/https:\/\/github.com/https:\/\/ghproxy.com\/https:\/\/github.com/g" | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
export NVM_NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node/
echo "export NVM_NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node/" >> ~/.bashrc
if awk '{print $2}' /etc/issue | grep -q -E 22.* || grep -q -E 23.*
then
  nvm install --lts
else
  nvm install 16.20.0
fi
source ~/.bashrc
echo
}

function binaries_nodejs_install(){
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
echo -e ${red}不受支持的框架 自动切换为setup脚本${background}
setup_nodejs_install
return
#echo ${red}您的框架为${yellow}$(uname -m)${red},快让白狐做适配.${background}
esac
if awk '{print $2}' /etc/issue | grep -q -E 22.*
    then
        curl -o node.tar.xz https://cdn.npmmirror.com/binaries/node/latest-v18.x/node-v18.17.0-linux-${node}.tar.xz
elif awk '{print $2}' /etc/issue | grep -q -E 23.*
    then
        curl -o node.tar.xz https://cdn.npmmirror.com/binaries/node/latest-v18.x/node-v18.17.0-linux-${node}.tar.xz     
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
}

Nodsjs_Version=$(node -v | cut -d '.' -f1)
if ! [[ "$Nodsjs_Version" == "v16" || "$Nodsjs_Version" == "v17" || "$Nodsjs_Version" == "v18" || "$Nodsjs_Version" == "v19" || "$Nodsjs_Version" == "v20" || "$Nodsjs_Version" == "v20" ]] && ! [ -x "$(command -v npm)" ];then
  if (whiptail --title "白狐" \
   --yes-button "二进制文件" \
   --no-button "setup脚本" \
   --yesno "请选择nodejs安装方式 \n国内用户建议使用二进制文件安装 \n国际用户建议使用setup脚本安装" 10 50)
   then
     nodejs_install=binaries_nodejs_install
   else
     nodejs_install=setup_nodejs_install
  fi
  echo -e ${yellow}安装nodejs和npm${background}
  a=0
  until ${nodejs_install}
  do
    echo -e ${red}NodeJS和npm安装失败 ${green}正在重试${background}
    a=$(($a+1))
    if [ "${a}" == "3" ];then
      echo -e ${red}错误次数过多 退出${background}
      exit
    fi
  done
  echo
fi

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
pnpm install -w icqq@0.4.11
cd ~/.fox@bot/${name}
echo -en ${yellow}正在初始化${background}
pnpm start
pnpm stop
rm -rf ~/.pm2/logs/*.log
echo -en ${yellow}初始化完成${background}
echo
echo -en ${yellow}安装完成 回车继续${background};read
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
"2" "降级puppeteer版本" \
"3" "修改${name}主人qq" \
"4" "修改登录设备" \
"5" "修复redis数据库" \
"6" "检查各项依赖" \
"0" "返回" \
3>&1 1>&2 2>&3)
feedback=$?
if ! [ $feedback = 0 ]
then
return
fi
case ${ErrorRepair} in
1)
echo "deb http://ftp.cn.debian.org/debian sid main" >> /etc/apt/sources.list
apt install -y gnupg gnupg1 gnupg2
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0E98404D386FA1D9 6ED0E7B82643E131
apt-key adv --refresh-keys --keyserver keyserver.ubuntu.com
apt update -y
apt install -y chromium
rm -rf /etc/apt/trusted.gpg
sed -i "s/deb http:\/\/ftp.cn.debian.org\/debian sid main//g" /etc/apt/sources.list
chromium > /dev/null
cd ~/.fox@bot/${name}
chromium_path=$(grep chromium_path: config/config/bot.yaml)
sed -i "s/${chromium_path}/chromium_path: \/usr\/bin\/chromium/g" config/config/bot.yaml
echo -e ${green}回车返回${background};read
;;
2)
cd ~/.fox@bot/${name}
echo "Y" | pnpm install
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
"6" "Tim" \
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
6)
YZ=true
install
echo -e ${green}检查完成 回车返回${background};read
;;
esac
}
function main(){
baihu=$(whiptail \
--title "白狐≧▽≦" \
--menu "${ver},注意:第一次启动,请使用前台启动" \
20 45 12 \
"1" "打开${name}日志" \
"2" "后台启动${name}" \
"3" "停止${name}运行" \
"4" "管理${name}插件" \
"5" "${name}重新登陆" \
"6" "填写签名服务器" \
"7" "前台启动${name}" \
"8" "${name}报错修复" \
"9" "帮助[实时更新]" \
"10" "卸崽! 删除${name}" \
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
pnpm run log
echo
echo -en ${cyan}回车返回${background};read
;;
2)
Redis=$(redis-cli ping)
if ! [ "${Redis}" = "PONG" ]; then
 redis-server &
 echo
fi
if [ -e ~/${name}/config/config/qq.yaml ];then
cd ~/${name}
pnpm run start
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
else
echo
echo -en ${red}请使用前台启动后，在使用后台启动${background};read
fi
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
pnpm run login
echo
echo -en ${cyan}回车返回${background};read
;;
6)
#bash <(curl -sL https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/version.sh)
cd ~/${name}
echo -e ${yellow}正在更新 $(ls ..)${background}
git pull
#icqq=$(grep version node_modules/icqq/package.json | awk '{print $2}' | sed 's/\"//g' | sed 's/,//g')
#icqq_latest=$(curl -sL https://ghproxy.com/https://github.com/icqqjs/icqq/raw/main/package.json | grep version | awk '{print $2}' | sed 's/\"//g' | sed 's/,//g')
#if [ ! "${icqq_latest}" = "${icqq}" ];then
#sed -i "s/${icqq}/${icqq_latest}/g" package.json
#echo "Y" | pnpm install
#pnpm uninstall icqq -w
#pnpm install icqq@latest -w
#fi
if (whiptail --title "白狐" \
--yes-button "第三方签名服务器" \
--no-button "本机签名服务器" \
--yesno "请选择签名服务器类型" 10 50)
  then
    if grep -q sign_api_addr config/config/bot.yaml
    then
        #http://127.0.0.1:8080/sign
        #sign_api_addr: http://127.0.0.1:8080/sign?key=123456
        #sign_api_addr: 112.74.57.142
        sed -i '/sign_api_addr/d' config/config/bot.yaml
        apilink=$(whiptail --title "白狐≧▽≦" --inputbox "请输入您准备好的api链接\n请注意,原链接末尾有sign的不要忘记了，如果有key请带上" \
        10 60 3>&1 1>&2 2>&3)
        if echo ${apilink} | grep -q sign_api_addr: ;then
            apilink=$(echo ${apilink} | sed 's/sign_api_addr: //g')
        fi
        if echo ${apilink} | grep -q http;then
            apilink=$(echo ${apilink} | sed "s/http://g")
            http=http://
        fi
        if echo ${apilink} | grep -q https;then
            apilink=$(echo ${apilink} | sed "s/https://g")
            http=https://
        fi
        if echo ${apilink} | grep -q \/;then
            apilink=$(echo ${apilink} | sed "s/\///g")
        fi
        if echo ${apilink} | grep -q sign;then
            apilink1=$(echo ${apilink} | sed "s/sign/ /g")
            apilink=$(echo ${apilink} | sed "s/sign//g")
            sign=/sign
        fi
        if echo ${apilink} | grep -q key;then
            key=$(echo ${apilink1} | awk '{print $2}' | sed "s/?key=//g")
            apilink=$(echo ${apilink} | sed "s/?key=${key}//g")
            key="?key=${key}"   
        fi
        if ! echo ${http} | grep -q http;then
            http=http://
        fi
        #echo "sign_api_addr: ${http}${apilink}${sign}${key}"
        sed -i "\$a\sign_api_addr: ${http}${apilink}${sign}${key}" config/config/bot.yaml
    else
        echo -e ${red}您的BOT应该至少启动过一次${background}
    fi
  else
        sed -i '/sign_api_addr/d' config/config/bot.yaml
        file="$HOME/QSignServer/txlib/8.9.68/config.json"
        port="$(grep -E port ${file} | awk '{print $2}' | sed "s/\"//g" | sed "s/://g" )"
        key="$(grep -E key ${file} | awk '{print $2}' | sed "s/\"//g" | sed "s/,//g" )"
        echo -e "http://127.0.0.1:${port}/sign?key=${key}"
        sed -i "\$a\sign_api_addr: http://127.0.0.1:${prot}/sign?key=${key}" config/config/bot.yaml
fi
echo -en ${yellow}执行完成 回车继续${background};read
;;
7)
Redis=$(redis-cli ping)
if ! [ "${Redis}" = "PONG" ]; then
 redis-server --daemonize yes &
 echo
fi
cd ~/${name}
pnpm run stop
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
       echo -en ${cyan}删除完成 回车返回${background};read
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
"4" "Yunzai-Bot-Llite" \
"5" "Alemon-Bot" \
"6" "白狐脚本附件安装" \
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
6)
Number=$(whiptail \
--title "白狐 QQ群:705226976" \
--menu "请选择bot" \
20 40 10 \
"1" "安装ffmpeg" \
"2" "安装python3.10 pip poetry" \
"3" "部署签名服务器" \
"0" "退出" \
3>&1 1>&2 2>&3)
feedback=$?
if ! [ $feedback = 0 ]
then
exit
fi
case ${Number} in
1)
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
curl -o static.tar.xz https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-${ffmpeg}-static.tar.xz
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
;;
2)
apt update -y
if [ -x "$(command -v python3.10)" ];then
apt autoremove python3.10 -y
fi
until echo -e "\n" | add-apt-repository ppa:deadsnakes/ppa && apt update -y
do
apt install software-properties-common -y
echo -e "\n" | add-apt-repository ppa:deadsnakes/ppa 
done
until apt install python3.10-full python3.10-venv -y
do
apt install software-properties-common -y
echo -e "\n" | add-apt-repository ppa:deadsnakes/ppa
apt install python3.10-full python3.10-venv -y
done
until curl https://bootstrap.pypa.io/get-pip.py | python3.10
do
curl https://bootstrap.pypa.io/get-pip.py | python3.10
done
python3.10 -m pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
python3.10 -m pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
python3.10 -m pip install --upgrade pip
until curl https://install.python-poetry.org | POETRY_HOME=/usr/local/lib/python3.10/dist-packages/poetry python3.10 -
do
curl https://install.python-poetry.org | POETRY_HOME=/usr/local/lib/python3.10/dist-packages/poetry python3.10 -
done
echo
echo -en ${yellow}安装完成 回车返回${background};read
;;
3)
bash <(curl -sL https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/QSignServer2.0.sh)
;;
0)
return
;;
esac
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
