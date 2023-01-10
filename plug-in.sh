pushd ~/
if [ -f /etc/lsb-release ]
    then
    echo
else
    echo -e "\033[44m 非ubuntu系统 停止运行! \033[0m";
    exit 0
fi
#检测是否为root用户
if [[ $EUID != 0 ]]
    then
    echo -e "\033[44m 非root用户 请登录root用户后使用该脚本 \033[0m";
    exit 0
fi
#检测curl安装状态
if ! [ -x "$(command -v curl)" ]
    then
    echo -e "\033[44m 未检测到未安装curl  \033[0m";
    apt update
    apt install curl -y
fi
#检测wget安装状态
if ! [ -x "$(command -v wget)" ]
    then
    echo -e "\033[44m 未检测到未安装wget 开始安装 \033[0m";
    apt update
    apt install wget -y
fi
#检测whiptail安装状态
if ! [ -x "$(command -v whiptail)" ]
    then
    echo -e "\033[44m 未检测到未安装whiptail 开始安装 \033[0m";
    apt update
    apt install whiptail -y
fi

1 "Atlas                  图鉴插件"\
  2 "suiyue                 碎月插件"\
  3 "Icepray                冰祈插件"\
  4 "l-plugin                  L插件"\
  5 "huasheng               花生插件"\
  6 "ap-plugin            AI绘图插件"\
  7 "lin-plugin               麟插件"\
  8 "zhi-plugin             白纸插件"\
  9 "auto-plugin          自动化插件"\
  10 "k423-plugin            k423插件"\
  12 "mora-plugin            摩拉插件"\
  13 "ayaka-plugin           绫华插件"\
  14 "Guoba-Plugin           锅巴插件"\
  15 "sanyi-plugin           三一插件"\
  16 "seven-plugin           七七插件"\
  17 "yenai-plugin           椰奶插件"\
  18 "flower-plugin          抽卡插件"\
  19 "python-plugin          旧Py插件"\
  20 "qianyu-plugin          千羽插件"\
  21 "tangxi-plugin          小月插件"\
  22 "xiaoye-plugin          小叶插件"\
  23 "xitian-plugin        JS插件管理"\
  24 "earth-k-plugin         土块插件"\
  25 "hs-qiqi-plugin         枫叶插件"\
  26 "liulian-plugin         榴莲插件"\
  27 "windoge-plugin         风歌插件"\
  28 "xianxin-plugin         闲心插件"\
  29 "xiaofei-plugin         小飞插件"\
  30 "xiaoxue-plugin         小雪插件"\
  31 "zhishui-plugin         止水插件"\
  32 "recreation-plugin      娱乐插件"\
  33 "yunzai-c-v-plugin    清凉图插件"\
  34 "xiaoyao-cvs-plugin     图鉴插件"\
  35 "Xiuxian-Plugin-Box     修仙插件"\
  36 "achievements-plugin    成就查漏"\
  37 "ff14-composite-plugin  FF14插件"\
  38 "akasha-terminal-plugin 虚空插件"\
  
pushd ~/Yunzai-Bot
plugin=$(whiptail \
--title "白狐-Yunzai-Bot-plugin" \
--menu "您想安装什么插件？" \
0 50 0 \
"1" "安装tangxi-plugin             [小月插件]    [#小月帮助]" \
"2" "安装miao-plugin               [喵喵插件]    [#喵喵帮助]" \
"3" "安装xiaoyao-cvs-plugin        [逍遥图鉴]    [#图鉴帮助]" \
"4" "安装Guoba-Plugin              [锅巴插件]    [#锅巴帮助]" \
"5" "安装zhi-plugin                [白纸插件]    [#白纸帮助]" \
"6" "安装xitian-plugin             [戏天插件]    [#插件帮助]" \
"7" "安装hs-qiqi-Plugin            [枫叶插件]    [#枫叶帮助]" \
"8" "安装Akasha-Terminal-plugin    [虚空插件]    [#虚空帮助]" \
"9" "安装Icepray-plugin            [冰祈插件]    [#冰祈帮助]" \
"10" "安装Xiuxian-Plugin-Box-V2     [修仙插件]    [#修仙帮助]" \
"11" "安装Yenai-Plugin              [椰奶插件]    [#椰羊帮助]" \
"12" "安装xiaofei-plugin            [小飞插件]    [#小飞帮助]" \
"13" "安装earth-k-plugin            [土块插件]    [#土块帮助]" \
"14" "安装py-plugin                 [旧版py插件]  [#py帮助]" \
"15" "安装py-plugin                 [新版py插件]  [#py帮助]" \
"16" "安装xianxin-plugin            [闲心插件]    [#闲心帮助]" \
"17" "安装lin-plugin                [麟插件]      [#lin帮助]" \
"18" "安装l-plugin                  [L插件]       [#L插件帮助]" \
"19" "安装qianyu-plugin             [千羽插件]    [#千羽帮助]" \
"20" "安装yunzai-c-v-pluginstar     [清凉图插件]  [#cv帮助]" \
"21" "安装flower-plugin             [抽卡插件]    [#抽卡帮助]" \
"22" "安装auto-plugin               [自动化插件]  " \
"23" "安装recreation-plugin         [娱乐插件]    " \
"24" "安装suiyue-plugin             [碎月插件]    " \
"25" "安装windoge-plugin            [窗口插件]    " \
"26" "安装Atlas                     [原神图鉴]    " \
"27" "安装zhishui-plugin            [止水插件]    " \
3>&1 1>&2 2>&3)
  
while true
do
baihu=$(whiptail \
--title "白狐≧▽≦" \
--menu "0.1" \
18 45 10 \
"1" "miao-plugin            喵喵插件" \
"2" "Guoba-Plugin           锅巴插件" \
"3" "xitian-plugin          戏天插件" \
"4" "xiaoyao-cvs-plugin    逍遥图鉴" \
"5" "Yenai-Plugin             椰奶插件" \
"6" "xiaofei-plugin            小飞插件" \
"7" "xianxin-plugin            闲心插件" \
"8" "flower-plugin             抽卡插件" \
"9" "py-plugin                 py插件" \
"10" "earth-k-plugin        土块插件" \
"11"
"12"
"13
"14"
"15"
"16"
"17"
"18"
"19"
"20"
"21"
"22"
"23"
"24"
"25"
"26"
"27"
"28"
"29"
"30"
3>&1 1>&2 2>&3)
ctmd=$?
if [[ ${ctmd} = 0 ]]
then

if [[ ${baihu} = 1 ]];then

fi

if [[ ${baihu} = 1 ]];then

fi

if [[ ${baihu} = 1 ]];then

if [[ ${baihu} = 1 ]];then

if [[ ${baihu} = 1 ]];then

if [[ ${baihu} = 1 ]];then

else
    exit
fi
done