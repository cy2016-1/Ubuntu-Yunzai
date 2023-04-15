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
  if pgrep node > /dev/null ; then
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
ver=3.5.7
cd $HOME
if [ ! -f "/usr/local/bin/bhyz" ]; then
    rm -rf ${home}/fox@bot/bhyz
    curl -o ${home}/fox@bot/bhyz https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/Yunzai-shell.sh
    if ! [ -e "/usr/local/bin/bhyz" ];then
    whiptail --title "白狐≧▽≦" --msgbox \
    "安装失败 请检查网络" \
    8 25
    exit
    fi
    Aword=`curl -s https://api.vvhan.com/api/ian`
    whiptail --title "白狐≧▽≦" --msgbox \
    "${Aword}" \
    10 50
    chmod +x /usr/local/bin/bhyz
    bhyz
fi
version=`curl -s https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/version-bhyz.sh`
if [ "$version" != "$ver" ]; then
    rm -rf ${home}/fox@bot/bhyz
    curl -o ${home}/fox@bot/bhyz https://gitee.com/baihu433/Ubuntu-Yunzai/raw/master/Yunzai-shell.sh
    if ! [ -e "/usr/local/bin/bhyz" ];then
    whiptail --title "白狐≧▽≦" --msgbox \
    "安装失败 请检查网络" \
    8 25
    exit
    fi
    Aword=`curl -s https://api.vvhan.com/api/ian`
    whiptail --title "白狐≧▽≦" --msgbox \
    "${Aword}" \
    10 50
    chmod +x /usr/local/bin/bhyz
    bhyz
fi




