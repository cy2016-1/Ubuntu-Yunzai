#!/bin/env bash
if ! grep -q -s -i -E "icqq" package.json;then > /dev/null
    echo -e "\033[31m" 请进入 "\033[33m"云崽/喵崽/TRSS崽 "\033[31m"目录之后运行本脚本"\033[0m"
exit 0
fi
if ! [ -e config/config/qq.yaml ];then
echo -e "\033[31m" 您的 "\033[33m"云崽/喵崽/TRSS崽 "\033[31m"应该至少启动过一次"\033[0m"
fi
pnpm install -P && pnpm install
icqq_local=`grep icqq package.json`
#这边实在是想不出来怎么写了，希望各位大佬看到后不要喷，同时，也希望各位大佬提出您们宝贵的意见
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
sed -i 's/${icqq_local}/"icqq": "^${icqq_latest}",/g' package.json
rm node_modules/icqq
pnpm install icqq@latest -w
pnpm install -P && pnpm install
echo -e "#####"白狐-Yunzai-Bot"#####"
echo -e 请选择您的登陆设备
echo "#########################"
echo -e 1. 安卓手机
echo -e 2. aPad
echo -e 3. 安卓手表
echo -e 4. MacOS
echo -e 5. iPad
echo -e 6. old_Android
echo "#########################"
echo -e QQ群:狐狸窝:705226976
echo "#########################"
echo -en 请输入您的选项: ;read number
new="platform: ${number}"
file="$HOME/Yunzai-Bot/config/config/qq.yaml"
grep platform ${file}
old_equipment=`grep platform ${file}`
new_equipment="platform: 6"
sed -i "s/${old_equipment}/${new_equipment}/g" $file
echo
echo 执行完成;read