#!/bin/bash
read -r -p " 请输入您要修复的账号: " qq
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
echo -e "\033[34m 修复完成 [注:一次不行 多试几次 实在不行 换一个号] \033[0m";
else
echo -e "\033[31m 错误: ${qq} 该账号没有登录过 \033[0m";
fi