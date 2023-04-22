#!/bin/bash
case "$1" in
  -h | --help)
  echo
  echo "##########白狐脚本#############"
  echo "bhyz                启动白狐脚本"
  echo "bhyz -n             前台启动Yunzai -Bot"
  echo "bhyz -h  | --help   获取白狐脚本帮助"
  echo "bhyz -s  | --start  启动Yunzai -Bot"
  echo "bhyz -st | --stop   重新登陆Yunzai-Bot账号"
  echo "bhyz -l  | --log    打开Yunzai-Bot日志"
  echo "bhyz -li | --login  重新登陆Yunzai-Bot账号"
  echo "bhyz -p  | --plugin 打开插件管理"
  echo "############################"
  echo "注意:脚本完全免费,如果你是购买所得,请退款"
  echo "脚本有任何问题都可以加入QQ群:705226976"
  echo "############################"
  echo
  exit
  ;;
  -n)
  echo 正在启动Yunzai-Bot
  redis-server --daemonize yes
  cd ~/Yunzai-Bot
  if pgrep node > /dev/null ; then
  echo "Yunzai-Bot已启动"
  else
  node app
  fi
  read -p "回车返回"
  ;;
  -s | --start)
  echo 正在启动Yunzai-Bot
  redis-server --daemonize yes
  cd ~/Yunzai-Bot
  if pgrep Yunzai-Bot > /dev/null ; then
  echo "Yunzai-Bot已启动"
  else
  pnpm run start
  fi
  exit
  ;;
  -st | stop)
  echo 正在停止Yunzai-Bot运行
  cd ~/Yunzai-Bot
  pnpm run stop
  exit
  ;;
  -l | -log)
  echo 正在打开Yunzai-Bot日志
  cd ~/Yunzai-Bot
  pnpm run log
  exit
  ;; 
  -li | --login)
  cd ~/Yunzai-Bot
  pnpm run login
  exit
  ;;
  -p | --plugins)
  bash <(curl -sL https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/plug-in.sh)
  exit
  ;;
esac
ver=3.7.2
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
sed -i 's/cat \/root\/.baihu/ /g' $HOME/.bashrc
if ! grep -q "cat $HOME/.baihu" $HOME/.bashrc
then
  sed -i 's/cat $HOME\/.baihu/ /g' $HOME/.bashrc
    echo "
  1.打开白狐脚本的命令为 bhyz
  2.查看白狐脚本帮助为 bhyz -h
" > .baihu
   echo "cat $HOME/.baihu" >> .bashrc
fi
if grep -q "705226976" $HOME/.baihu
then
    echo "
  1.打开白狐脚本的命令为 bhyz
  2.查看白狐脚本帮助为 bhyz -h
" > .baihu
fi
while true
do
baihu=$(whiptail \
--title "白狐≧▽≦" \
--menu "${ver}" \
17 35 7 \
"1" "管理Yunzai-Bot" \
"2" "安装Yunzai-Bot" \
"3" "管理Yunzai插件" \
"4" "附加安装" \
"5" "帮助" \
"0" "退出" \
3>&1 1>&2 2>&3)

feedback=$?
if [ $feedback = 0 ];then
  #调用管理脚本
  if [[ ${baihu} = 1 ]]
   then
     if [ -d "$HOME/Yunzai-Bot" ];then
       admin=$(whiptail \
       --title "白狐≧▽≦" \
       --menu "${ver}" \
       17 40 10 \
       "1" "启动Yunzai-Bot" \
       "2" "停止Yunzai-Bot" \
       "3" "后台启动Yunzai-Bot" \
       "4" "查看后台Yunzai-Bot日志" \
       "5" "重置Yunzai-Bot账号" \
       "6" "修改登录设备" \
       "7" "修复账号无法登陆" \
       "8" "修改主人QQ" \
       "9" "修复Redis服务器错误" \
       "10" "py服务器依赖和端口报错" \
       "11" "修复chromium启动失败" \
       "12" "修复puppeteer chromium调用失败" \
       "0" "打开安装脚本" \
       3>&1 1>&2 2>&3 )
          #启动
           if [[ ${admin} = 1 ]];then
              pushd ~/Yunzai-Bot
              pnpm run stop
              redis-server --daemonize yes 
              node app
           fi
           
           #停止
           if [[ ${admin} = 2 ]];then
              pushd ~/Yunzai-Bot
              pnpm run stop
           fi
           
           if [[ ${admin} = 3 ]];then
             pushd ~/Yunzai-Bot
             redis-server --daemonize yes
             if pgrep Yunzai-Bot > /dev/null ; then
             echo "Yunzai-Bot已启动"
             else
             pnpm run start
             fi
           fi
             
           if [[ ${admin} = 4 ]];then
              pushd ~/Yunzai-Bot
              pnpm run log
           fi
           
           if [[ ${admin} = 5 ]];then
           pushd ~/Yunzai-Bot
           rm $HOME/Yunzai-Bot/data/device.json
           pnpm run login
           fi
           
           if [[ ${admin} = 6 ]];then
           pushd ~/Yunzai-Bot
           equipment=$(whiptail \
           --title "白狐≧▽≦" \
           --menu "请选择登录设备" \
           17 35 7 \
           "1" "安卓手机" \
           "2" "aPad" \
           "3" "安卓手表" \
           "4" "MacOS" \
           "5" "iPad[推荐]" \
           3>&1 1>&2 2>&3 )
           new="platform: ${equipment}"
           file="$HOME/Yunzai-Bot/config/config/qq.yaml"
           old_equipment="platform: [0-5]"
           new_equipment="platform: ${equipment}"
           sed -i "s/$old_equipment/$new_equipment/g" $file
           rm $HOME/Yunzai-Bot/data/device.json
           fi
        
           #报错修复
          if [[ ${admin} = 7 ]];then
            cd Yunzai-Bot 
            git pull
            rm node_modules/icqq
            pnpm install
            pnpm update icqq@latest -w
            equipment=$(whiptail \
            --title "白狐≧▽≦" \
            --menu "请选择登录设备" \
            17 35 7 \
            "1" "安卓手机" \
            "2" "aPad" \
            "3" "安卓手表" \
            "4" "MacOS" \
            "5" "iPad" \
            3>&1 1>&2 2>&3 )
            new="platform: ${equipment}"
            file="$HOME/Yunzai-Bot/config/config/qq.yaml"
            old_equipment="platform: [0-5]"
            new_equipment="platform: ${equipment}"
            sed -i "s/$old_equipment/$new_equipment/g" $file
            function imei(){
              min=$1
              max=$(($2-$min+1))
              num=$(date +%s%N)
              echo $(($num%$max+$min))
            }
            imeinumber=$(imei 100000000000000 999999999999999)
            file=$HOME/Yunzai-Bot/data/device.json
            sed -i '15s/.*/  \"imei\": \"imeinumber\"\,/g' ${file}
            sed -i s/imeinumber/${imeinumber}/g ${file}
            echo 
            grep "platform:" config/config/qq.yaml
            echo
            cat -n data/device.json
            echo
            echo;echo -en "\033[32m 修复完成 回车返回\033[0m";read
          fi
           
           if [[ ${admin} = 8 ]];then
             qq=$(whiptail \
             --title "白狐≧▽≦" \
             --inputbox "请输入您要更改后的主人qq号" \
             10 60 \
             3>&1 1>&2 2>&3)
             
             if [[ $qq =~ ^[0-9]+$ ]]; then
               if [ $qq -gt 9999 ]; then
                 sed -i '7s/.*/'" - $qq"'/' $HOME/Yunzai-Bot/config/config/other.yaml
                 whiptail --title "白狐≧▽≦" --msgbox \
                 "主人QQ已更改为${qq}" \
                 10 60
               else
                 echo -e "\033[31m 请输入正确的QQ号！\033[0m"
                 exit
               fi
             else
                 echo -e "\033[31m 请输入正确的QQ号！\033[0m"
                 exit
             fi
           fi
           
           #redis报错
           if [[ ${admin} = 9 ]];then
           echo
           echo redis修复暂时噶了
           exit
           cd ${home}/Yunzai-Bot
           git pull
           case $(uname -m) in
             aarch64|arm64)
               redis=arm64
             ;;
             amd64|x86_64)
               redis=amd64
             ;;
             *)
             echo -e "\033[31m暂不支持您的设备\033[0m"
             exit
             ;;
           esac
           curl -o redis-server.tar.gz
           mkdir redis-server
           cd redis-server
           ln -s redis-server /usr/bin/redis-server
           fi
           
           #py报错
           if [[ ${admin} = 10 ]];then
             if [ -d $HOME/Yunzai-Bot/plugins/py-plugin ];then
               if ! [ -x "$(command -v python3.10)" ];then
               echo -e "\033[31m 小子 你还没有安装python呢\n 快到附加安装 安装python3.10吧\033[0m";
               exit
               fi
               if ! [ -x "$(command -v pip)" ];then
               echo -e "\033[31m 小子 你还没有安装pip呢\n 快到附加安装 安装pip吧\033[0m";
               exit
               fi
               if ! [ -x "$(command -v poetry)" ];then
               echo -e "\033[31m 小子 你还没有安装poetry呢\n 快到附加安装 安装poetry吧\033[0m";
               exit
               fi
               pushd  $HOME/Yunzai-Bot/plugins/py-plugin
               poetry install 
               poetry install
               function py(){
               min=$1
               max=$(($2-$min+1))
               num=$(date +%s%N)
               echo $(($num%$max+$min))
               }
               pyport=$(py 40000 60000)
               sed -i "15s/.*/port: ${pyport}/g" $HOME/Yunzai-Bot/plugins/py-plugin/config.yaml
               pushd $HOME
               whiptail --title "白狐≧▽≦" --msgbox \
               "修复完成 [注:一次不行 多试几次]" \
              10 60
             else
               whiptail --title "白狐≧▽≦" --msgbox \
               "错误: 您好像还没有安装py插件" \
               10 60
             fi
           fi
       
           if [[ ${admin} = 11 ]];then
           bash <(curl https://gitee.com/baihu433/chromium/raw/master/chromium.sh)
           fi
           
           if [[ ${admin} = 11 ]];then
           cd ${home}/Yunzai-Bot
           pnpm install
           pnpm install puppeteer@19.0.0 -w
           cd ../
           fi
           
           #返回安装脚本
           if [[ ${admin} = 0 ]];then
           bhyz
           fi
     else
           whiptail --title "白狐≧▽≦" --msgbox "
           您好像还没有未安装云崽呢，快去安装吧!
           " 10 43        
     fi
   fi
   
  #安装脚本
  if [[ ${baihu} = 2 ]]
    then
      if [ -d "$HOME/Yunzai-Bot" ];then
         whiptail --title "白狐≧▽≦" --msgbox "
         您已安装云崽 禁止套娃
         " 10 43
      else
       # 更新软件源和软件
        echo -e "\033[34m 更新软件源 \033[0m";
        apt update -y
        echo -e "\033[34m 更新完成 \033[0m";
        echo

        # 安装nodejs
        Ubuntuv=$(lsb_release -r | awk '{print $2}')
        until npm -v
        do
        if [ "$Ubuntuv" == "18.04" ]; then
          rm /etc/apt/sources.list.d/nodesource.list > /dev/null
          bash <(curl -sL https://deb.nodesource.com/setup_16.x)
        elif [ "$Ubuntuv" == "22.04" ]; then
          rm /etc/apt/sources.list.d/nodesource.list > /dev/null
          bash <(curl -sL https://deb.nodesource.com/setup_18.x)
        elif [ "$Ubuntuv" == "22.10" ]; then
          rm /etc/apt/sources.list.d/nodesource.list > /dev/null
          bash <(curl -sL https://deb.nodesource.com/setup_18.x)
        else
          rm /etc/apt/sources.list.d/nodesource.list > /dev/null
          bash <(curl -sL https://deb.nodesource.com/setup_16.x)
        fi
        apt remove nodejs -y
        apt autoremove -y
        apt update -y
        apt install -y nodejs
        done
        
        #安装pnpm
        echo -e "\033[34m 开始安装pnpm  \033[0m";
        npm config set registry https://registry.npmmirror.com
        npm install -g npm
        if npm install pnpm -g --registry=https://registry.npmmirror.com
        then
          echo -e "\033[32m 安装pnpm成功 \033[0m";
        else
          echo -e "\033[31m 安装pnpm失败 \033[0m";
          exit
        fi
        echo
        
        # 安装并运行redis
        echo -e "\033[34m 安装redis \033[0m";
        if apt-get install redis redis-server -y
        then
          echo -e "\033[32m 安装redis成功 \033[0m";
        else
          echo -e "\033[31m 安装redis失败 \033[0m";
        fi
        redis-server --daemonize yes
        echo

        # 安装chromium
        echo -e "\033[34m 安装chromium \033[0m";
        if apt-get install chromium-browser -y
        then
          echo -e "\033[32m 安装chromium-browser成功 \033[0m";
        else
          echo -e "\033[31m 安装chromium-browser失败 \033[0m";
        fi
        echo
        
        #安装中文字体
        echo -e "\033[34m 安装并设置中文字体 \033[0m";
        apt-get install -y fonts-wqy-microhei fonts-wqy-zenhei
        apt install -y ^language-pack-zh
        echo "LANG=\"zh_CN.UTF-8\"
        export LANG">>/etc/profile
        source /etc/profile
        
        # 克隆项目
        echo -e "\033[34m 正在克隆Yunzai-Bot \033[0m";
        pushd ~/
        pnpm install puppeteer@latest -w
        if git clone --depth=1 https://gitee.com/yoimiya-kokomi/Yunzai-Bot
        then
          echo -e "\033[32m 克隆成功 \033[0m";
        else
          echo -e "\033[31m 克隆失败 \033[0m";
        fi
        echo
        
        #安装Yunzai依赖
        echo -e "\033[34m 安装依赖 \033[0m";
        pushd ~/Yunzai-Bot
        pnpm install -P && pnpm install -P
        echo;echo -en "\033[32m 安装完成 回车返回\033[0m";
      fi
   fi
  
  #调用插件脚本
  if [[ ${baihu} = 3 ]]
   then
      if [ -d "$HOME/Yunzai-Bot" ];then
       bash <(curl -sL https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/plug-in.sh)
     else
      whiptail --title "白狐≧▽≦" --msgbox "
       您好像还没有未安装云崽呢，快去安装吧!
       " 10 43
     fi
   fi
  
  #调用附加安装脚本
  if [[ ${baihu} = 4 ]]
    then
       installing=$(whiptail \
       --title "白狐≧▽≦" \
       --menu "${ver}" \
       20 45 10 \
       "1" "安装python3.10和pip和poetry" \
       "2" "安装ffmpeg" \
       3>&1 1>&2 2>&3)
       ctmd=$?

function 18pythonpippoetry()
{
if [ -x "$(command -v python3.10)" ];then
apt purge python3.10 -y
apt autoremove -y
fi
apt install software-properties-common -y
until apt install python3.10-full python3.10-venv -y
do
apt install software-properties-common -y
echo -e "\n" | add-apt-repository ppa:deadsnakes/ppa
apt install python3.10-full python3.10-venv -y
done
until curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
do
echo -e "\033[31mget-pip.py文件下载失败 三秒后重新下载\033[0m"
sleep 3s
done
if ! [ -x "$(command -v python3.10)" ];then
echo -e "\033[31mPython3.10安装失败\033[0m"
exit
fi
python3.10 get-pip.py
rm get-pip.py
if ! [ -x "$(command -v pip)" ];then
echo -e "\033[31mPython3.10安装失败\033[0m"
exit
fi
echo -e "\033[32m 正在为pip更换默认源\033[0m"
python3.10 -m pip config set global.index-url https://pypi.mirrors.ustc.edu.cn/simple/
python3.10 -m pip config set global.index-url https://pypi.mirrors.ustc.edu.cn/simple/
python3.10 -m pip install --upgrade pip
echo -e "\033[32m poetry安装较久 请耐心等待 \033[0m"
python3.10 -m pip install poetry
if ! [ -x "$(command -v poetry)" ];then
echo -e "\033[31mpoetry安装失败\033[0m"
exit
fi
echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
}

function 22pythonpippoetry()
{
apt install python3.10-full python3.10-venv -y
apt install python3.10-full python3.10-venv -y
if ! [ -x "$(command -v python3.10)" ];then
echo -e "\033[31mPython3.10安装失败\033[0m"
exit
fi
until curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
do
echo -e "\033[31mget-pip.py文件下载失败 三秒后重新下载\033[0m"
sleep 3s
done
python3.10 get-pip.py
rm get-pip.py
if ! [ -x "$(command -v pip)" ];then
echo -e "\033[31m pip安装失败\033[0m"
exit
fi
echo -e "\033[32m 正在更新pip\033[0m"
python3.10 -m pip install -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade pip
echo -e "\033[32m 正在为pip更换默认源\033[0m"
python3.10 -m pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
python3.10 -m pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
python3.10 -m pip install --upgrade pip
echo -e "\033[32m poetry安装较久 请耐心等待 \033[0m"
python3.10 -m pip install poetry
if ! [ -x "$(command -v poetry)" ];then
echo -e "\033[31mpoetry安装失败\033[0m"
exit
fi
echo;echo -en "\033[32m 安装完成 回车返回\033[0m";read -p ""
}

      if [[ ${installing} = 1 ]]
         then
         pushd $HOME
        Ubuntuv=$(lsb_release -r | awk '{print $2}')
        if [ "$Ubuntuv" == "18.04" ]; then
          18pythonpippoetry
        elif [ "$Ubuntuv" == "22.04" ]; then
          22pythonpippoetry
        elif [ "$Ubuntuv"= "22.10" ]; then
          22pythonpippoetry
        else
          18pythonpippoetry
        fi
      fi
      
       if [[ ${installing} = 2 ]];then
         bash <(curl -sL https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/ffmpge.sh)
       fi
   fi
  
  if [[ ${baihu} = 5 ]]
   then
    #作者信息？？？
    whiptail --title "白狐≧▽≦" --msgbox "
    注意：脚本完全免费，禁止倒卖
    此脚本作者为白狐
    [QQ:1522099983[Q群:705226976]
    什么?脚本不会用?快进群殴打白狐
    项目地址:
    https://gitee.com/baihu433/Ubuntu-Yunzai
    " 17 40 7
  fi
  
  #退出
  if [[ ${baihu} = 0 ]]
  then
  exit 0
  fi

else
    exit
fi
done