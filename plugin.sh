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

while true

do

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
"14" "安装py-plugin                 [python插件]  [#py帮助]" \
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
"27" "安装zhishui-plugin            [止水插件]    " 

3>&1 1>&2 2>&3)
  
if [[ ${plugin} = 1 ]];then
echo ==================================
echo 正在安装小月插件，稍安勿躁～
echo ==================================
echo
echo ps:安装程序正在后台运行，安装成功之后会自动返回插件选择菜单
nohup git clone --depth=1 https://gitee.com/txlx/tangxi-plugin.git 
./plugins/tangxi-plugin
fi

if [[ ${plugin} = 2 ]];then
echo ==================================
echo 正在安装喵喵插件，稍安勿躁～
echo ==================================
echo 
echo ps:安装程序正在后台运行，安装成功之后会自动返回插件选择菜单
nohop git clone https://gitee.com/yoimiya-kokomi/miao-plugin.git 
./plugins/miao-plugin/ 
fi

if [[ ${plugin} = 3 ]];then
echo ==================================
echo 正在安装逍遥插件，稍安勿躁～
echo ==================================
echo 
echo ps:安装程序正在后台运行，安装成功之后会自动返回插件选择菜单
echo 这个插件暂时莫得链接，应该会在一天之内补上，5秒后返回菜单
sleep 5
fi
if [[ ${plugin} = 4 ]];then
echo ==================================
echo 正在安装锅巴插件，稍安勿躁～
echo ==================================
echo
echo ps:安装程序正在后台运行，安装成功之后会自动返回插件选择菜单
nohup git clone --depth=1 https://gitee.com/guoba-yunzai/guoba-plugin.git 
nohup ./plugins/Guoba-Plugin/
fi
if [[ ${plugin} = 5 ]];then
echo ==================================
echo 正在安装白纸插件，稍安勿躁～
echo ==================================
echo
echo ps:安装程序正在后台运行，安装成功之后会自动返回插件选择菜单
nohup git clone --depth=1 https://gitee.com/headmastertan/zhi-plugin.git 
nohup ./plugins/zhi-plugin/
fi
if [[ ${plugin} = 6 ]];then
echo ==================================
echo 正在安装戏天插件，稍安勿躁～
echo ==================================
echo
echo ps:安装程序正在后台运行，安装成功之后会自动返回插件选择菜单
nohup git clone --depth=1 https://gitee.com/XiTianGame/xitian-plugin.git 
nohup ./plugins/xitian-plugin/
fi
if [[ ${plugin} = 7 ]];then
echo ==================================
echo 正在安装枫叶插件，稍安勿躁～
echo ==================================
echo
echo ps:安装程序正在后台运行，安装成功之后会自动返回插件选择菜单
nohup git clone --depth=1 https://gitee.com/kesally/hs-qiqi-cv-plugin.git  
nohup ./plugins/hs-qiqi-plugin
fi
if [[ ${plugin} = 8 ]];then
echo ==================================
echo 正在安装虚空插件，稍安勿躁～
echo ==================================
echo
echo ps:安装程序正在后台运行，安装成功之后会自动返回插件选择菜单
nohup git clone --depth=1 https://gitee.com/go-farther-and-farther/akasha-terminal-plugin.git 
nohup ./plugins/akasha-terminal-plugin/
fi
if [[ ${plugin} = 9 ]];then
echo ==================================
echo 正在安装冰祈插件，稍安勿躁～
echo ==================================
echo
echo ps:安装程序正在后台运行，安装成功之后会自动返回插件选择菜单
nohup git clone --depth=1 https://gitee.com/TimeRainStarSky/Yunzai-Icepray
nohup ./plugins/Icepray/
fi
if [[ ${plugin} = 10 ]];then
echo ==================================
echo 正在安装修仙插件，稍安勿躁～
echo ==================================
echo
echo ps:安装程序正在后台运行，安装成功之后会自动返回插件选择菜单
nohup git clone --depth=1 https://gitee.com/ningmengchongshui/Xiuxian-Plugin-Box
nohup ./plugins/Xiuxian-Plugin-Box/
fi
if [[ ${plugin} = 11 ]];then
echo ==================================
echo 正在安装椰羊插件，稍安勿躁～
echo ==================================
echo
echo ps:安装程序正在后台运行，安装成功之后会自动返回插件选择菜单
nohup git clone --depth=1 https://gitee.com/yeyang52/yenai-plugin.git ./plugins/yenai-plugin
fi
if [[ ${plugin} = 12 ]];then
echo ==================================
echo 正在安装小飞插件，稍安勿躁～
echo ==================================
echo
echo ps:安装程序正在后台运行，安装成功之后会自动返回插件选择菜单
nohup git clone https://gitee.com/xfdown/xiaofei-plugin.git ./plugins/xiaofei-plugin/
fi
if [[ ${plugin} = 13 ]];then
echo ==================================
echo 正在安装土块插件，稍安勿躁～
echo ==================================
echo
echo ps:安装程序正在后台运行，安装成功之后会自动返回插件选择菜单
nohup git clone https://gitee.com/SmallK111407/earth-k-plugin.git ./plugins/earth-k-plugin/
fi
if [[ ${plugin} = 14 ]];then
echo ==================================
echo 正在安装python插件，稍安勿躁～
echo ==================================
echo
echo ps:安装程序正在后台运行，安装成功之后会自动返回插件选择菜单(此插件需要安装系列依赖，耗时可能较长
echo 正在安装依赖:python3，如果已安装将自动跳过
nohup apt-get python3 -y
echo 5秒后安装poerty依赖，可能需要用户手动回车
sleep 5
curl -sSL https://install.python-poetry.org | python -
ln -s ${HOME}/.local/bin ${HOME}/.local/bin/poetry
echo 正在判断是否安装成功
if ! [ -x "$(command -v poetry)" ];then
echo 安装成功，进入下一步
git clone --depth=1 https://github.com/realhuhu/py-plugin.git
cd plugins/py-plugin/
nohup poetry install
else 
echo 安装失败，正在返回菜单并清除安装残留……
rm -rf ~/Yunzai-Bot/plugins/py-plugin
cd ~/Yunzai-Bot
sleep 3
fi
fi
if [[ ${plugin} = 15 ]];then
echo ==================================
echo 正在安装ChatGpt插件，稍安勿躁～
echo ==================================
echo ps:安装程序正在后台运行，安装成功之后会自动返回插件选择菜单
echo 正在安装依赖
nohup pnpm install -w undici showdown mathjax-node puppeteer-extra puppeteer-extra-plugin-stealth puppeteer-extra-plugin-recaptcha delay uuid
echo 正在安装本体
nohup git clone https://github.com/ikechan8370/chatgpt-plugin.git ./plugins/chatgpt-plugin
echo 此插件需要自备chatgpt账号，10秒后打开配置文件，只需填写username(填写chatgpt账号) 和 password(chatgpt密码)即可，按下ESC然后输入:wq 回车退出编辑并返回菜单
vim plugins/chatgpt/config/index.js
fi
if [[ ${plugin} = 16 ]];then
echo ==================================
echo 正在安装闲心插件，稍安勿躁～
echo ==================================
echo
echo ps:安装程序正在后台运行，安装成功之后会自动返回插件选择菜单
nohup git clone --depth=1 https://gitee.com/xianxincoder/xianxin-plugin.git ./plugins/xianxin-plugin/
fi
if [[ ${plugin} = 17 ]];then
echo ==================================
echo 正在安装麟插件，稍安勿躁～
echo ==================================
echo
echo ps:安装程序正在后台运行，安装成功之后会自动返回插件选择菜单
nohup git clone --depth=1 https://gitee.com/go-farther-and-farther/lin-plugin.git ./plugins/lin-plugin/
fi
if [[ ${plugin} = 18 ]];then
echo ==================================
echo 正在安装L插件，稍安勿躁～
echo ==================================
echo
echo ps:安装程序正在后台运行，安装成功之后会自动返回插件选择菜单(此插件使用github克隆，如果没有魔法可能会比较慢)
nohup git clone --depth=1 https://github.com/liuly0322/l-plugin.git ./plugins/l-plugin/
cd plugins/l-plugin
nohup pnpm install
cd docker
nohup docker build -t ubuntu-python-playground-img .
cd ~/Yunzai-Bot
fi
if [[ ${plugin} = 19 ]];then
echo ==================================
echo 正在安装千羽插件，稍安勿躁～
echo ==================================
echo
echo ps:安装程序正在后台运行，安装成功之后会自动返回插件选择菜单
nohup git clone --depth=1 https://gitee.com/think-first-sxs/qianyu-plugin.git ./plugins/qianyu-plugin/
fi
if [[ ${plugin} = 20 ]];then
echo ==================================
echo 正在安装清凉图插件，稍安勿躁～
echo ==================================
echo
echo ps:安装程序正在后台运行，安装成功之后会自动返回插件选择菜单
nohup git clone --depth=1 https://gitee.com/xwy231321/yunzai-c-v-plugin.git ./plugins/yunzai-c-v-plugin/
fi
if [[ ${plugin} = 21 ]];then
echo ==================================
echo 正在安装抽卡插件，稍安勿躁～
echo ==================================
echo
echo ps:安装程序正在后台运行，安装成功之后会自动返回插件选择菜单
nohup git clone --depth=1 https://gitee.com/Nwflower/flower-plugin.git ./plugins/flower-plugin/
fi
if [[ ${plugin} = 22 ]];then
echo ==================================
echo 正在安装自动化插件，稍安勿躁～
echo ==================================
echo
echo ps:安装程序正在后台运行，安装成功之后会自动返回插件选择菜单
nohup git clone --depth=1 https://gitee.com/Nwflower/auto-plugin.git ./plugins/auto-plugin/
fi
if [[ ${plugin} = 23 ]];then
echo ==================================
echo 正在安装娱乐插件，稍安勿躁～
echo ==================================
echo
echo ps:安装程序正在后台运行，安装成功之后会自动返回插件选择菜单(此插件来自github，无魔法情况下可能安装较慢
nohup git clone --depth=1 https://github.com/Cold-666/recreation-plugin.git ./plugins/recreation-plugin/
fi
if [[ ${plugin} = 24 ]];then
echo ==================================
echo 正在安装碎月插件，稍安勿躁～
echo ==================================
echo
echo ps:安装程序正在后台运行，安装成功之后会自动返回插件选择菜单
nohup git clone --depth=1 https://gitee.com/Acceleratorsky/suiyue.git ./plugins/suiyue/
fi
if [[ ${plugin} = 25 ]];then
echo ==================================
echo 正在安装窗口插件，稍安勿躁～
echo ==================================
echo
echo ps:安装程序正在后台运行，安装成功之后会自动返回插件选择菜单
nohup git clone https://github.com/gxy12345/windoge-plugin.git ./plugins/windoge-plugin/
echo 正在安装依赖……
nohup pnpm install --filter=windoge-plugin
fi
if [[ ${plugin} = 26 ]];then
echo ==================================
echo 正在安装原神图鉴插件，稍安勿躁～
echo ==================================
echo
echo ps:安装程序正在后台运行，安装成功之后会自动返回插件选择菜单
nohup git clone --depth=1 https://gitee.com/Nwflower/atlas ./plugins/Atlas/
fi
if [[ ${plugin} = 27 ]];then
echo ==================================
echo 正在安装止水插件，稍安勿躁～
echo ==================================
echo
echo ps:安装程序正在后台运行，安装成功之后会自动返回插件选择菜单
nohup git clone --depth=1 https://gitee.com/fjcq/zhishui-plugin.git ./plugins/zhishui-plugin
fi
done