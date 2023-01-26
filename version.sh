#!/bin/bash
read -r -p " 请输入您要修复的账号: " qq
if [ -d "$HOME/Yunzai-Bot/data/${qq}" ]; then
function baihuqq(){
min=$1
max=$(($2-$min+1))
num=$(date +%s%N)
echo $(($num%$max+$min))
 }
imeibh=$(baihuqq 100000000000000 999999999999999)
    sed -i "s/imei.*/"imei": "$imeibh",/"  $HOME/Yunzai-Bot/data/$qq/device-$qq.json
    echo -e "\033[34m 修复完成 [注:一次不行 多试几次 实在不行 换一个号] \033[0m"
    echo -e "\033[34m 项目地址 https://gitee.com/baihu433/Ubuntu-Yunzai \033[0m"
else
echo -e "\033[31m 文件不存在,请确认是否登录过qq $qq \033[0m";
fi