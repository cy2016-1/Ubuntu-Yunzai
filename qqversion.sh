#!/bin/bash
qq=$(whiptail \
--title "白狐≧▽≦" \
--inputbox "请输入您的机器人qq号 输完后回车" \
10 60 \
3>&1 1>&2 2>&3)

if [ -d "/root/Yunzai-Bot/data/${qq}" ]; then
pushd /root/Yunzai-Bot/data/${qq}
#随机输生成
function baihuqq(){
min=$1
max=$(($2-$min+1))
num=$(date +%s%N)
echo $(($num%$max+$min))
}
imeibh=$(baihuqq 100000000000000 999999999999999)
sed -i '15s/.*/ \"imei\": \"wcnm\",/g' device-${qq}.json
sed -i 15s/wcnm/${imeibh}/g device-${qq}.json
whiptail --title "白狐≧▽≦" --msgbox \
"修复完成 [注:一次不行 多试几次 实在不行 换一个号]" \
10 60
else
whiptail --title "白狐≧▽≦" --msgbox \
"错误: ${qq} 该账号没有登录过" \
10 60
fi