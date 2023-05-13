#!/bin/bash
red="\033[31m"
green="\033[32m"
yellow="\033[33m"
blue="\033[34m"
purple="\033[35m"
cyan="\033[36m"
white="\033[37m"
background="\033[0m"
echo
echo
echo -e ${white}"#####"${green}白狐-Yunzai-Bot${white}"#####"${background}
echo -e ${blue}请选择您的bot${background}
echo "#########################"
echo -e ${green}1.  ${cyan}Yunzai-Bot${background}
echo -e ${green}2.  ${cyan}Miao-Yunzai${background}
echo -e ${green}3.  ${cyan}yunzai-bot-lite${background}
echo -e ${green}4.  ${cyan}TRSS-Yunzai${background}
echo -e ${green}0.  ${cyan}退出${background}
echo "#########################"
echo -e ${green}QQ群:${cyan}狐狸窝:705226976${background}
echo "#########################"
echo
echo -en ${green}请输入您的选项: ${background};read number
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
elif [ -d "/root/.fox@bot/${name}" ];then
path="/root/.fox@bot/${name}"
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
elif [ -d "config" ];then
path="."
else
echo
echo -e ${red}未在此目录下找到${name}的配置文件${background}
echo -e ${red}请进入 ${name}目录 之后使用本脚本${background}
fi
cd ${path}
if ! grep -q "icqq" package.json;then > /dev/null
echo
echo -e ${red} - ${cyan}请进入 ${yellow}云崽/喵崽/TRSS崽 ${cyan}目录之后运行本脚本${background}
exit
fi
if ! [ -e config/config/qq.yaml ];then
echo
echo -e ${red} - ${cyan}您的 ${yellow}云崽/喵崽/TRSS崽 ${cyan}应该至少启动过一次${background}
exit
fi
icqq_local=`grep icqq package.json | awk '{print $2}' | sed 's/\"//g' | sed 's/,//g' | sed 's/\^//g'`
#这边实在是想不出来怎么写了，希望各位大佬看到后不要喷，同时，也希望各位大佬提出您们宝贵的意见
echo
echo -e ${green} - ${cyan} 正在获取icqq最新版本${background}
#icqq_latest=`curl -sL https://raw.github.com/icqqjs/icqq/main/package.json | grep version | awk '{print $2}' | sed 's/\"//g' | sed 's/,//g'`
#if test -z "${icqq_latest}";then
  icqq_latest=`curl -sL https://ghproxy.com/https://raw.github.com/main/package.json | grep version | awk '{print $2}' | sed 's/\"//g' | sed 's/,//g'`
    if test -z "${icqq_latest}";then 
      icqq_latest=`curl -sL https://gitee.com/baihu433/icqq/raw/main/package.json | grep version | awk '{print $2}' | sed 's/\"//g' | sed 's/,//g'`
        if test -z "${icqq_latest}";then 
          echo -e "\033[31m" 请检查网络"\033[0m"
        fi
    fi
#fi
echo
echo -e ${yellow} - ${green}icqq最新版本为 ${cyan}${icqq_latest} ${background}
echo -e ${yellow} - ${green}本地icqq版本为 ${red}${icqq_local} ${background}
if [ "${icqq_local}" == "${icqq_latest}" ]
then
echo
echo -e ${yellow} - ${green}icqq已为最新${cyan}${icqq_latest} ${background}
echo
else
echo
echo -e ${yellow} - ${green}正在更新icqq${cyan}${background}
sed -i "s/${icqq_local}/${icqq_latest}/g" package.json
echo "Y" | pnpm uninstall icqq
echo "Y" | pnpm install icqq@latest -w
fi
echo
function device(){
echo -e ${white}"#####"${cyan}白狐-Yunzai-Bot${white}"#####"${background}
echo -e ${cyan}请选择您的登陆设备${background}
echo -e ${white}"#########################"${background}
echo -e ${green}1. ${cyan}安卓手机${background}
echo -e ${green}2. ${cyan}aPad${background}
echo -e ${green}3. ${cyan}安卓手表${background}
echo -e ${green}4. ${cyan}MacOS${background}
echo -e ${green}5. ${cyan}iPad${background}
echo -e ${green}6. ${cyan}old_Android${background}
echo -e ${white}"#########################"${background}
echo -e ${green}QQ群:狐狸窝:${cyan}705226976${background}
echo ${white}"#########################"${background}
echo -en ${green}请输入您的选项:${background} ;read number
new="platform: ${number}"
file=config/config/qq.yaml
grep platform ${file}
old_equipment=`grep platform ${file}`
new_equipment="platform: 6"
sed -i "s/${old_equipment}/${new_equipment}/g" $file
rm data/device.json > /dev/null
rm -rf data/icqq > /dev/null
}
echo
echo -e ${white}"#####"${cyan}白狐-Yunzai-Bot${white}"#####"${background}
echo -e ${cyan}请选择您的报错类型${background}
echo -e ${white}"#########################"${background}
echo -e ${green}1. ${cyan}错误码:${red}45${background}
echo -e ${green}2. ${cyan}错误码:${red}235${background}
echo -e ${green}3. ${cyan}错误码:${red}237${background}
echo -e ${green}4. ${cyan}错误码:${red}238${background}
echo -e ${green}5. ${cyan}仅更改登录端口\(设备\)${background}
echo -e ${green}6. ${cyan}仅降级icqq版本${background}
echo -e ${white}"#########################"${background}
echo -e ${green}QQ群:狐狸窝:${cyan}705226976${background}
echo -e ${green}注意:${cyan}手表协议和Macos协议都无法戳一戳"\n"因为本身这两种设备都不支持.${background}
echo -e ${white}"#########################"${background}
echo -en ${green}请输入您的选项:${background} ;read number
case $number in
1|45)
echo -e ${cyan}错误码:${red}45'\n'${cayn}建议使用${yellow}MacOS或${yellow}iPad或${yellow}old_Android'\n'回车继续${background};read
echo "Y" | pnpm install -P && echo "Y" | pnpm install
device
;;
2|235)
echo -en ${cyan}错误码:${red}235'\n'${cayn}建议先使用手表协议然后扫码登录'\n'回车继续${background};read
echo "Y" | pnpm install -P && echo "Y" | pnpm install
device
;;
3|237)
echo "Y" | pnpm install -P && echo "Y" | pnpm install
echo "Y" | pnpm uninstall icqq
pnpm install icqq@0.2.3 -w
echo -en ${cyan}错误码:${red}237'\n'${cayn}建议使用iPad协议登录'\n'回车继续${background};read
device
;;
4|238)
echo "Y" | pnpm install -P && echo "Y" | pnpm install
echo -en ${cyan}错误码:${red}238'\n'${cayn}建议命令换手表协议后再换回iPad协议[全部用密码]'\n'回车继续${background};read
device
;;
5)
device
;;
6)
echo "Y" | pnpm install -P && echo "Y" | pnpm install
echo "Y" | pnpm uninstall icqq
echo -en ${green}请输入您指定的icqq版本:${background} ;read IcqqVersion
echo "Y" | pnpm install icqq@${IcqqVersion} -w
;;
*)
echo -en ${red}输入错误${background} ;read
exit
;;
esac
echo -en ${green}执行完成 ${cyan}回车退出${background};read