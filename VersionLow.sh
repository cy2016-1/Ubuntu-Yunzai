#!/bin/bash
function debian()
{
if ! [ -x "$(command -v whiptail)" ];then
    echo -e "\033[36m检测到未安装whiptail 开始安装 \033[0m";
    apt update -y
    apt install whiptail -y
fi
}
function ubuntu()
{
if ! [ -x "$(command -v whiptail)" ];then
    echo -e "\033[36m检测到未安装whiptail 开始安装 \033[0m";
    apt update -y
    apt install whiptail -y
fi
}
function centos()
{
if ! [ -x "$(command -v whiptail)" ];then
    echo -e "\033[36m检测到未安装whiptail 开始安装 \033[0m";
    yum update -y
    yum install whiptail -y
fi
}
function archlinux()
{
if ! [ -x "$(command -v whiptail)" ];then
    echo -e "\033[36m检测到未安装whiptail 开始安装 \033[0m";
    pacman -Syu
    pacman -S whiptail
fi
}

if [[ -f /etc/redhat-release ]]; then
       centos
elif grep -q -E -i "debian" /etc/issue; then
    debian
elif grep -q -E -i "ubuntu" /etc/issue; then
    ubuntu
elif grep -q -E -i "centos|red hat|redhat" /etc/issue; then
    centos
elif grep -q -E -i "Arch|Manjaro" /etc/issue; then
    archlinux
elif grep -q -E -i "debian" /proc/version; then
    debian
elif grep -q -E -i "ubuntu" /proc/version; then
    ubuntu
elif grep -q -E -i "centos|red hat|redhat" /proc/version; then
    centos
else
echo;echo -en "\033[32m 插件安装暂不支持该Linux发行版 \033[0m";read -p ""
exit
fi

VersionLow=$(whiptail \
--title "白狐≧▽≦" \
--menu "建议方法1 不行再使用方法2" \
17 35 7 \
"1" "方法1:简单[成功率低]" \
"2" "方法2:复杂[成功率高]" \
3>&1 1>&2 2>&3)
if [[ ${VersionLow} = 1 ]];then
qq=$(whiptail \
--title "白狐≧▽≦" \
--inputbox "请输入您的机器人qq号 输完后回车" \
10 60 \
3>&1 1>&2 2>&3)

if [ -d "$HOME/Yunzai-Bot/data/${qq}" ]; then
#随机输生成
function baihuqq(){
min=$1
max=$(($2-$min+1))
num=$(date +%s%N)
echo $(($num%$max+$min))
}
imeibh=$(baihuqq 100000000000000 999999999999999)
sed -i '15s/.*/ \"imei\": \"wcnm\",/g' $HOME/Yunzai-Bot/data/${qq}/device-${qq}.json
sed -i 15s/wcnm/${imeibh}/g $HOME/Yunzai-Bot/data/${qq}/device-${qq}.json
whiptail --title "白狐≧▽≦" --msgbox \
"修复完成 [注:一次不行 多试几次 实在不行 换一个号]" \
10 60
else
whiptail --title "白狐≧▽≦" --msgbox \
"错误: ${qq} 该账号没有登录过" \
10 60
fi
fi

if [[ ${VersionLow} = 2 ]];then
qq=$(whiptail \
--title "白狐≧▽≦" \
--inputbox "请输入您的机器人qq号 输完后回车" \
10 60 \
3>&1 1>&2 2>&3)

if [ -d "$HOME/Yunzai-Bot/data/${qq}" ]
then
pushd $HOME
if [ -e "$HOME/version/session.token" ];then
pushd $HOME/version
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
sed -i "s/$old/$new/g" $file
mv $HOME/Yunzai-Bot/data/$qq
./AIxPha
mv token $HOME/Yunzai-Bot/data/${qq}
function baihuqq(){
min=$1
max=$(($2-$min+1))
num=$(date +%s%N)
echo $(($num%$max+$min))
}
imeibh=$(baihuqq 100000000000000 999999999999999)
sed -i '15s/.*/ \"imei\": \"wcnm\",/g' $HOME/Yunzai-Bot/data/${qq}/device-${qq}.json
sed -i 15s/wcnm/${imeibh}/g $HOME/Yunzai-Bot/data/${qq}/device-${qq}.json
whiptail --title "白狐≧▽≦" --msgbox \
"修复完成 [注:一次不行 多试几次 实在不行 换一个号]" \
10 60
rm session.token
pushd $HOME
rm -rf version
fi
git clone --depth=1 https://gitee.com/haanxuan/version.git ./VersionLow
if [ $(uname -m) == "aarch64" ]
 then
mkdir version
cp -r $HOME/VersionLow/ARM/* $HOME/version
rm -rf VersionLow > bh.log
rm -rf VersionLow > bh.log
elif [ $(uname -m) == "x86_64" ]
 then 
mkdir version
cp -r $HOME/VersionLow/AMD/* $HOME/version
rm -rf VersionLow > bh.log
rm -rf VersionLow > bh.log
else
echo -e "\033[34m 您是干什么的呀？ \033[0m";
fi
chmod +777 $HOME/version/go-cqhttp $HOME/version/AIxPha
whiptail --title "白狐≧▽≦" --msgbox \
"不会扫码就先修改账密再登录\n登录成功后退出日志界面\n---------------\n按小键盘上的CTRL\n先再按手机键盘上的英文状态下的c\n就可以退出\n退出之后再用这个功能会自动修复" \
13 50
./version/go-cqhttp -faststart
else
whiptail --title "白狐≧▽≦" --msgbox \
"错误: ${qq} 该账号没有登录过" \
10 60
fi
fi