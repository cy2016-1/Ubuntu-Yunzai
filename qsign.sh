if [ "$(uname -o)" = "Android" ];then
echo -e ${red}你是大聪明吗?${background}
exit
fi
if [ ! "$(uname)" = "Linux" ]; then
	echo -e ${red}你是大聪明吗?${background}
    exit
fi
if [ ! "$(id -u)" = "0" ]; then
    echo -e ${red}请使用root用户${background}
    exit 0
fi
export red="\033[31m"
export green="\033[32m"
export yellow="\033[33m"
export blue="\033[34m"
export purple="\033[35m"
export cyan="\033[36m"
export white="\033[37m"
export background="\033[0m"
cd $HOME
echo -e ${white}"#####"${green}白狐-Yunzai-Bot${white}"#####"${background}
echo -e ${blue}请选择您要为哪一个bot管理插件${background}
echo "#########################"
echo -e ${green}1.  ${cyan}Yunzai-Bot${background}
echo -e ${green}2.  ${cyan}Miao-Yunzai${background}
echo -e ${green}3.  ${cyan}yunzai-bot-lite${background}
echo -e ${green}4.  ${cyan}TRSS-Yunzai${background}
echo -e ${green}5.  ${cyan}Yxy-Bot${background}
echo -e ${green}0.  ${cyan}退出${background}
echo "#########################"
echo -e ${green}白狐API的ICQQ适配版本为${cyan}0.4.12${background}
echo -e ${green}白狐API的共享库版本为${cyan}8.9.70${background}
echo "#########################"
echo -e ${green}QQ群:${cyan}狐狸窝:705226976${background}
echo "#########################"
echo
echo -en ${green}请输入您的选项: ${background};read number
#clear
}
choose_page
case ${number} in
1)
if [ -d /root/TRSS_AllBot ];then
  name=Yunzai
else
  name=Yunzai-Bot
fi
;;
2)
name=Miao-Yunzai
;;
3)
name=yunzai-bot-lite
;;
4)
name=TRSS-Yunzai
;;
5)
name=yxybot
;;
6)
page=echo_page
robot_path
main
;;
0)
exit
;;
*)
echo
echo -e ${red}输入错误${background}
exit
;;
esac
if [ -d "/root/${name}" ];then
path="/root/${name}"
elif [ -d "/root/fox@bot/${name}" ];then
path="/root/fox@bot/${name}"
elif [ -d "/home/lighthouse/ubuntu/${name}" ];then
path="/home/lighthouse/ubuntu/${name}"
elif [ -d "/home/lighthouse/centos/${name}" ];then
path="/home/lighthouse/centos/${name}"
elif [ -d "/home/lighthouse/debian/${name}" ];then
path="/home/lighthouse/debian/${name}"
elif [ -d "/home/lighthouse/debian/${name}" ];then
path="/home/lighthouse/debian/${name}"
elif [ -d "/root/TRSS_AllBot/${name}" ];then
path="/root/TRSS_AllBot/${name}"
elif [ -d "/root/TRSS_AllBot/${name}" ];then
path="/root/TRSS_AllBot/${name}"
elif [ -d "plugins" ];then
path="."
else
echo
echo -e ${red}未在此目录下找到${name}的插件文件夹${background}
echo -e ${red}请进入 ${name}目录 之后使用本脚本${background}
exit
fi
cd ${path}/
sed -i '/sign_api_addr/d' config/config/bot.yaml
sed -i '$a\sign_api_addr: http://118.31.34.48:10017/sign?key=baihu' config/config/bot.yaml
if grep "118.31.34.48" config/config/bot.yaml;then
echo -e ${green}您的签名服务器已被更改为 ${cyan}118.31.34.48:10017${background}
echo -e ${green}欢迎加入${cyan}狐狸窝:705226976${green}获取API最新消息${background}
fi