#!/bin/env bash
red="\033[31m"
green="\033[32m"
yellow="\033[33m"
blue="\033[34m"
purple="\033[35m"
cyan="\033[36m"
white="\033[37m"
background="\033[0m"
if ! grep -q -s -i -E "icqq" package.json;then > /dev/null
    echo -e ${red} - ${cyan}请进入 ${yellow}云崽/喵崽/TRSS崽 ${cyan}目录之后运行本脚本${background}
exit 0
fi
if ! [ -e config/config/qq.yaml ];then
echo -e ${red} - ${cyan}您的 ${yellow}云崽/喵崽/TRSS崽 ${cyan}应该至少启动过一次${background}
fi
pnpm install -P && pnpm install
icqq_local=`grep icqq package.json`
#这边实在是想不出来怎么写了，希望各位大佬看到后不要喷，同时，也希望各位大佬提出您们宝贵的意见
echo -e ${green} - ${cyan} 正在获取icqq最新版本${background}
icqq_latest=`curl -sL https://raw.github.com/icqqjs/icqq/main/package.json | grep version | awk '{print $2}' | sed 's/\"//g' | sed 's/,//g'`
if test -z "${icqq_latest}";then
  icqq_latest=`curl -sL https://ghproxy.com/https://raw.github.com/main/package.json | grep version | awk '{print $2}' | sed 's/\"//g' | sed 's/,//g'`
    if test -z "${icqq_latest}";then 
      icqq_latest=`curl -sL https://gitee.com/baihu433/icqq/raw/main/package.json | grep version | awk '{print $2}' | sed 's/\"//g' | sed 's/,//g'`
        if test -z "${icqq_latest}";then 
          echo -e "\033[31m" 请检查网络"\033[0m"
        fi
    fi
fi
echo -e ${green} - ${cyan}最新版本为 ${blue}${icqq_latest}${background}
sed -i "s/${icqq_local}/\"icqq\": \"^${icqq_latest}\",/g" package.json
pnpm uninstall icqq
pnpm install icqq@latest -w
pnpm install -P && pnpm install
function device(){
echo -e ${green}"#####"${cyan}白狐-Yunzai-Bot${green}"#####"${background}
echo -e ${cyan}请选择您的登陆设备${background}
echo ${green}"#########################"${background}
echo -e ${green}1. ${cyan}安卓手机${background}
echo -e ${green}2. ${cyan}aPad${background}
echo -e ${green}3. ${cyan}安卓手表${background}
echo -e ${green}4. ${cyan}MacOS${background}
echo -e ${green}5. ${cyan}iPad${background}
echo -e ${green}6. ${cyan}old_Android${background}
echo ${green}"#########################"${background}
echo -e ${green}QQ群:狐狸窝:${cyan}705226976${background}
echo ${green}"#########################"${background}
echo -en ${green}请输入您的选项:${background} ;read number
new="platform: ${number}"
file="$HOME/Yunzai-Bot/config/config/qq.yaml"
grep platform ${file}
old_equipment=`grep platform ${file}`
new_equipment="platform: 6"
sed -i "s/${old_equipment}/${new_equipment}/g" $file
rm data/device.json > /dev/null
rm data/icqq > /dev/null
}
echo
echo -e ${green}"#####"${cyan}白狐-Yunzai-Bot${green}"#####"${background}
echo -e ${cyan}请选择您的报错类型${background}
echo ${green}"#########################"${background}
echo -e ${green}1. ${cyan}错误码:${red}45${background}
echo -e ${green}2. ${cyan}错误码:${red}235${background}
echo -e ${green}3. ${cyan}错误码:${red}237${background}
echo -e ${green}4. ${cyan}错误码:${red}238${background}
echo -e ${green}5. ${cyan}仅更改登录端口(设备)${background}
echo ${green}"#########################"${background}
echo -e ${green}QQ群:狐狸窝:${cyan}705226976${background}
echo -e ${green}注意:${cyan}手表协议和Macos协议都无法戳一戳,因为本身这两种设备都不支持.${background}
echo ${green}"#########################"${background}
echo -en ${green}请输入您的选项:${background} ;read number
case number in
1)
echo -e ${cyan}错误码:${red}45'\n'${cayn}建议使用${yellow}MacOS或${yellow}iPad或${yellow}old_Android'\n'回车继续${background};read
device
;;
2)
echo -en ${cyan}错误码:${red}235'\n'${cayn}建议先使用手表协议然后扫码登录'\n'回车继续${background};read
device
;;
3)
pnpm uninstall icqq
pnpm install icqq@0.2.3 -w
echo -en ${cyan}错误码:${red}237'\n'${cayn}建议使用iPad协议登录'\n'回车继续${background};read
device
;;
4)
echo -en ${cyan}错误码:${red}238'\n'${cayn}建议命令换手表协议后再换回iPad协议[全部用密码]'\n'回车继续${background};read
device
;;
esac
pnpm run login
echo ${green}执行完成 ${cyan}回车退出${background};read