red="\033[31m"
green="\033[32m"
yellow="\033[33m"
blue="\033[34m"
purple="\033[35m"
cyan="\033[36m"
white="\033[37m"
background="\033[0m"
echo -e ${yellow} - ${cyan}此脚本已停止维护${background}
echo -e ${yellow} - ${cyan}请到 ${green}https://gtiee.com/baihu433/Yunzai-Bot-Shell${cyan}获取新脚本${background}
echo -e ${yellow} - ${cyan}如有疑问 请添加QQ群聊${green}879718035 ${cyan}获取帮助${background}
exit
function main(){
function ghproxy_agency(){
function dialog_whiptail_page(){
if (${dialog_whiptail} \
--title "白狐-Bot-Plugin" \
--yes-button "启用" \
--no-button "关闭" \
--yesno "${Name}位于github 是否启用ghproxy镜像站？\n中国大陆用户建议启用" \
10 60)
then
    ghproxy="https://ghproxy.com/"
else
    ghproxy=" "
fi
} #dialog_whiptail_page
function echo_page(){
echo -en ${green}${Name}该项目库位于github 是否启用ghproxy镜像站 ${cyan}[Y/n] ${background}
read -p "" num
        case $num in
     Y|y)
       ghproxy="https://ghproxy.com/"
       ;;
     n|N)
       ghproxy=" "
       ;;
     *)
       ghproxy="https://ghproxy.com/"
       ;;
  esac
} #echo_page
choose_page
} #ghproxy_agency

function install_git_plugin(){
function dialog_whiptail_page(){
if [ -d plugins/${Plugin} ]
  then
    #clear
    if (${dialog_whiptail} --title "白狐i-Bot-Plugin" \
       --yesno "        您已安装${Name}，是否删除" \
       10 48);then
         echo -e ${green}正在删除${Name}${background}
         rm -rf plugins/${Plugin}
         rm -rf plugins/${Plugin} &>/dev/null
       if [ -d plugins/${Plugin} ]
         then
           echo;echo -en ${red}删除失败 回车返回${background};read
         else
           echo;echo -en ${green}删除完成 回车返回${background};read
       fi
    fi
  else
    #clear
    if (${dialog_whiptail} \
    --title "白狐-Bot-Plugin" \
    --yes-button "安装" \
    --no-button "返回" \
    --yesno "确认要安装这个插件吗？\n插件名: ${Name} \n插件URL: ${Git}" \
    10 60)
    then
    #clear
    echo
    echo "=================================="
    echo 正在安装${Name}，稍安勿躁～
    echo "=================================="
    echo
    git clone --depth=1 ${Git} ./plugins/${Plugin}
      if [ -d plugins/${Plugin} ]
        then
          echo -e "\033[36m正在处理依赖\033[0m"
          cd plugins/${Plugin}
          echo "Y" | pnpm install --registry=https://registry.npmmirror.com
          echo "Y" | pnpm install --registry=https://registry.npmmirror.com
          #pnpm install -P
          cd ../../ 
          echo;echo -en ${green}安装完成 回车返回${background};read
      else
          echo;echo -en ${red}安装失败 回车返回${background};read
      fi
    fi
fi
} #dialog_whiptail_page
function echo_page(){
if [ -d plugins/${Plugin} ]
  then
    echo -e ${green}${Name}已经安装 是否删除 ${cyan}[N/y]${background}
        read -p "" num
     case $num in
       N)
         echo -en ${cyan}取消 回车返回${background};read
         ;;
       y)
         rm -rf plugins/${Plugin}
         rm -rf plugins/${Plugin} &>/dev/null
         if [ -d plugins/${Plugin} ]
           then
             echo;echo -en ${red}删除失败 回车返回${background};read
           else
             echo;echo -en ${cyan} 删除完成 回车返回${background};read
         fi
         ;;
       *)
         echo -en ${cyan}取消 回车返回${background};read
         ;;
     esac
  else
    #clear
    echo -e ${green}插件名: ${yellow}${Name} '\n'${green}插件URL: ${yellow}${Git}'\n'${background}
    echo
    echo -en ${cyan}回车继续${background};read
    echo "=================================="
    echo 正在安装${Name}，稍安勿躁～
    echo "=================================="
    git clone --depth=1 ${Git} ./plugins/${Plugin}
    if [ -d plugins/${Plugin} ]
    then
      echo -e ${cyan}正在处理依赖${background}
      cd plugins/${Plugin}
      echo "Y" | pnpm install --registry=https://registry.npmmirror.com
      echo "Y" | pnpm install --registry=https://registry.npmmirror.com
      #pnpm install -P
      cd ../../ 
      echo;echo -en ${green}安装完成 回车返回${background};read
    else
      echo;echo -en ${red}安装失败 回车返回${background};read
    fi
fi
} #echo_page
choose_page
} #install_git_plugin

function install_git_plugin_checklist(){
function dialog_whiptail_page(){
if [ -d plugins/${Plugin} ]
  then
    #clear
    if (${dialog_whiptail} --title "白狐i-Bot-Plugin" \
       --yesno "        您已安装${Name}，是否删除" \
       10 48);then
         echo
         echo -e ${green}正在删除${Name}${background}
         rm -rf plugins/${Plugin}
         rm -rf plugins/${Plugin} &>/dev/null
       if [ -d plugins/${Plugin} ]
         then
           echo;echo -en ${red}删除失败${background}
           echo
         else
           echo;echo -en ${green}删除完成${background}
           echo
       fi
    fi
  else
    #clear
    if (${dialog_whiptail} \
    --title "白狐-Bot-Plugin" \
    --yes-button "安装" \
    --no-button "返回" \
    --yesno "确认要安装这个插件吗？\n插件名: ${Name} \n插件URL: ${Git}" \
    10 60)
    then
    #clear
    echo
    echo "=================================="
    echo 正在安装${Name}，稍安勿躁～
    echo "=================================="
    echo
    git clone --depth=1 ${Git} ./plugins/${Plugin}
      if [ -d plugins/${Plugin} ]
        then
          echo -e "\033[36m正在处理依赖\033[0m"
          cd plugins/${Plugin}
          echo "Y" | pnpm install --registry=https://registry.npmmirror.com
          echo "Y" | pnpm install --registry=https://registry.npmmirror.com
          #pnpm install -P
          cd ../../ 
          echo;echo -en ${green}安装完成${background}
          echo
      else
          echo;echo -en ${red}安装被取消${background}
          echo
      fi
    fi
fi
} #dialog_whiptail_page
function echo_page(){
if [ -d plugins/${Plugin} ]
  then
    echo -e ${green}${Name}已经安装 是否删除 ${cyan}[N/y]${background}
        read -p "" num
     case $num in
       N)
         echo -en ${cyan}取消${background}
         echo
         ;;
       y)
         rm -rf plugins/${Plugin}
         rm -rf plugins/${Plugin} &>/dev/null
         if [ -d plugins/${Plugin} ]
           then
             echo;echo -en ${red}删除失败${background}
             echo
           else
             echo;echo -en ${cyan}删除完成${background}
             echo
         fi
         ;;
       *)
         echo -en ${cyan}取消${background}
         echo
         ;;
     esac
  else
    #clear
    #echo -e ${green}插件名: ${yellow}${Name} '\n'${green}插件URL: ${yellow}${Git}'\n'${background}
    echo
    echo -e ${green}插件名: ${yellow}${Name}${background}
    echo -e ${green}插件URL: ${yellow}${Git}${background}
    echo
    echo "=================================="
    echo 正在安装${Name}，稍安勿躁～
    echo "=================================="
    git clone --depth=1 ${Git} ./plugins/${Plugin}
    if [ -d plugins/${Plugin} ]
    then
      echo
      echo -e ${cyan}正在处理依赖${background}
      cd plugins/${Plugin}
      echo "Y" | pnpm install --registry=https://registry.npmmirror.com
      echo "Y" | pnpm install --registry=https://registry.npmmirror.com
      #pnpm install -P
      cd ../../ 
      echo;echo -en ${green}安装完成${background}
      echo
    else
      echo;echo -en ${red}安装失败${background}
      echo
    fi
fi
} #echo_page
choose_page
} #install_git_plugin

function pip_mirrors(){
function py_install(){
if [ "$(poetry run pip -V)" = "22.3".* ];then
    poetry run pip install --upgrade pip -i ${mirror}
fi
URL1=$(grep "index-url" requirements.txt)
URL2="--index-url ${mirror}"
sed -i "s|${URL1}|${URL2}|g" requirements.txt
if ! poetry run pip install -r requirements.txt
then
echo -en ${red}依赖安装失败 '\n'${blue}回车重新安装${background};read
pip_mirrors
fi
if ! poetry install
then
echo -en ${red}依赖安装失败 '\n'${blue}回车重新安装${background};read
pip_mirrors
fi
if ! poetry install
then
echo -en ${red}依赖安装失败 '\n'${blue}回车重新安装${background};read
pip_mirrors
fi
echo -en ${green}依赖安装成功 回车返回${background};read
}
echo 
echo
echo -e ${white}"#####"${green}白狐-py-plugin${white}"#####"${background}
echo -e ${blue}请输入要选择的pip镜像源${background}
echo "#########################"
echo -e ${green}1.  ${cyan}北外源${background}
echo -e ${green}2.  ${cyan}清华源${background}
echo -e ${green}3.  ${cyan}阿里源${background}
echo -e ${green}4.  ${cyan}豆瓣源${background}
echo -e ${green}5.  ${cyan}中科大${background}
echo -e ${green}6.  ${cyan}华为源${background}
echo -e ${green}7.  ${cyan}腾讯源${background}
echo
echo -e ${green}8.  ${cyan}官方源${background}
echo "#########################"
echo -e ${green}QQ群:${cyan}狐狸窝:705226976${background}
echo "#########################"
echo
echo -en ${green}请输入您的选项: ${background};read number
case ${number} in
  1)
    mirror=https://pypi.tuna.tsinghua.edu.cn/simple
    py_install
  ;;
  2)
    mirror=https://mirrors.bfsu.edu.cn/pypi/web/simple
    py_install
  ;;
  3)
    mirror=http://mirrors.aliyun.com/pypi/simple/
    py_install
  ;;
  4)
    mirror=http://pypi.douban.com/simple/
    py_install
  ;;
  5)
    mirror=https://pypi.mirrors.ustc.edu.cn/simple/
    py_install
  ;;
  6)
    mirror=https://repo.huaweicloud.com/repository/pypi/simple
    py_install
  ;;
  7)
    mirror=https://mirrors.cloud.tencent.com/pypi/simple/
    py_install
  ;;
  8)
    mirror=https://pypi.org/simple
    py_install
  ;;
  *)
    echo;echo -en ${red}输入错误 ${cyan}默认使用清华源${background}
    mirror=https://mirrors.bfsu.edu.cn/pypi/web/simple
    py_install
  ;;
esac
}




function dialog_whiptail_page_menu(){
number=$(${dialog_whiptail} \
--title "白狐-QQ群:705226976" \
--menu "选择一个您喜欢的插件吧!" \
25 60 18 \
"1" "miao-plugin                    喵喵插件" \
"2" "xiaoyao-cvs-plugin             逍遥图鉴" \
"3" "Guoba-Plugin                   锅巴插件" \
"4" "zhi-plugin                     白纸插件" \
"5" "xitian-plugin                  戏天插件" \
"6" "Akasha-Terminal-plugin         虚空插件" \
"7" "xiuxian-emulator-plugin        绝云间修仙插件" \
"8" "Yenai-Plugin                   椰奶插件" \
"9" "xiaofei-plugin                 小飞插件" \
"10" "earth-k-plugin                 土块插件" \
"11" "py-plugin                      py插件" \
"12" "xianxin-plugin                 闲心插件" \
"13" "lin-plugin                     麟插件" \
"14" "l-plugin                       L插件" \
"15" "qianyu-plugin                  千羽插件" \
"16" "ql-plugin                      清凉图插件" \
"17" "flower-plugin                  抽卡插件" \
"18" "auto-plugin                    自动化插件" \
"19" "recreation-plugin              娱乐插件" \
"20" "suiyue-plugin                  碎月插件" \
"21" "windoge-plugin                 风歌插件" \
"22" "Atlas                          原神图鉴" \
"23" "zhishui-plugin                 止水插件" \
"24" "TRSS-Plugin                    trss插件" \
"25" "Jinmaocuicuisha                脆脆鲨插件" \
"26" "useless-plugin                 无用插件" \
"27" "liulian-plugin                 榴莲插件" \
"28" "xiaoye-plugin                  小叶插件" \
"29" "rconsole-plugin                R插件" \
"30" "expand-plugin                  扩展插件" \
"31" "XiaoXuePlugin                  小雪插件" \
"32" "Icepray                        冰祈插件" \
"33" "Tlon-Sky                       光遇插件" \
"34" "hs-qiqi-plugin                 枫叶插件" \
"35" "call_of_seven_saints           七圣召唤插件" \
"36" "QQGuild-Plugin                 QQ频道插件" \
"37" "xiaoyue-plugin                 小月插件" \
"38" "FanSky_Qs                      繁星插件" \
"39" "phi-plugin                     phigros辅助插件" \
"40" "ap-plugin                      ap绘图插件" \
"41" "sanyi-plugin                   三一插件" \
"42" "chatgpt-plugin                 聊天插件" \
"43" "y-tian-plugin                  阴天插件" \
"44" "xianyu-plugin                  咸鱼插件" \
"45" "StarRail-plugin                星穹铁道插件" \
"46" "panel-plugin                   面板图插件" \
"47" "hanhan-plugin                  憨憨插件" \
"48" "avocado-plugin                 鳄梨插件" \
"49" "cunyx-plugin                   寸幼萱插件" \
"50" "TianRu-plugin                  天如插件" \
"51" "ws-plugin                      ws连接插件" \
"52" "WeLM-plugin                    AI对话插件" \
"53" "Yunzai-Kuro-Plugin             库洛插件" \
"54" "mj-plugin                      AI绘图插件" \
"55" "qinghe-plugin                  卿何插件" \
"56" "BlueArchive-plugin             碧蓝档案插件" \
"57" "impart-pro-plugin              牛牛大作战" \
"58" "Gi-plugin                      群互动插件" \
3>&1 1>&2 2>&3)
feedback=$?
if ! [ $feedback = 0 ]
then
exit
fi
#clear
_checklist=""
}

function dialog_whiptail_page_checklist(){
number=$(${dialog_whiptail} \
--title "白狐-QQ群:705226976" \
--checklist "选择您喜欢的插件吧! [空格表示选择 回车表示确定]" \
25 60 18 \
"1" "miao-plugin                    喵喵插件" OFF \
"2" "xiaoyao-cvs-plugin             逍遥图鉴" OFF \
"3" "Guoba-Plugin                   锅巴插件" OFF \
"4" "zhi-plugin                     白纸插件" OFF \
"5" "xitian-plugin                  戏天插件" OFF \
"6" "Akasha-Terminal-plugin         虚空插件" OFF \
"7" "xiuxian-emulator-plugin        绝云间修仙插件" OFF \
"8" "Yenai-Plugin                   椰奶插件" OFF \
"9" "xiaofei-plugin                 小飞插件" OFF \
"10" "earth-k-plugin                 土块插件" OFF \
"11" "py-plugin                      py插件" OFF \
"12" "xianxin-plugin                 闲心插件" OFF \
"13" "lin-plugin                     麟插件" OFF \
"14" "l-plugin                       L插件" OFF \
"15" "qianyu-plugin                  千羽插件" OFF \
"16" "ql-plugin                      清凉图插件" OFF \
"17" "flower-plugin                  抽卡插件" OFF \
"18" "auto-plugin                    自动化插件" OFF \
"19" "recreation-plugin              娱乐插件" OFF \
"20" "suiyue-plugin                  碎月插件" OFF \
"21" "windoge-plugin                 风歌插件" OFF \
"22" "Atlas                          原神图鉴" OFF \
"23" "zhishui-plugin                 止水插件" OFF \
"24" "TRSS-Plugin                    trss插件" OFF \
"25" "Jinmaocuicuisha                脆脆鲨插件" OFF \
"26" "useless-plugin                 无用插件" OFF \
"27" "liulian-plugin                 榴莲插件" OFF \
"28" "xiaoye-plugin                  小叶插件" OFF \
"29" "rconsole-plugin                R插件" OFF \
"30" "expand-plugin                  扩展插件" OFF \
"31" "XiaoXuePlugin                  小雪插件" OFF \
"32" "Icepray                        冰祈插件" OFF \
"33" "Tlon-Sky                       光遇插件" OFF \
"34" "hs-qiqi-plugin                 枫叶插件" OFF \
"35" "call_of_seven_saints           七圣召唤插件" OFF \
"36" "QQGuild-Plugin                 QQ频道插件" OFF \
"37" "xiaoyue-plugin                 小月插件" OFF \
"38" "FanSky_Qs                      繁星插件" OFF \
"39" "phi-plugin                     phigros辅助插件" OFF \
"40" "ap-plugin                      ap绘图插件" OFF \
"41" "sanyi-plugin                   三一插件" OFF \
"42" "chatgpt-plugin                 聊天插件" OFF \
"43" "y-tian-plugin                  阴天插件" OFF \
"44" "xianyu-plugin                  咸鱼插件" OFF \
"45" "StarRail-plugin                星穹铁道插件" OFF \
"46" "panel-plugin                   面板图插件" OFF \
"47" "hanhan-plugin                  憨憨插件" OFF \
"48" "avocado-plugin                 鳄梨插件" OFF \
"49" "cunyx-plugin                   寸幼萱插件" OFF \
"50" "TianRu-plugin                  天如插件" OFF \
"51" "ws-plugin                      ws连接插件" OFF \
"52" "WeLM-plugin                    AI对话插件" OFF \
"53" "Yunzai-Kuro-Plugin             库洛插件" OFF \
"54" "mj-plugin                      AI绘图插件" OFF \
"55" "qinghe-plugin                  卿何插件" OFF \
"56" "BlueArchive-plugin             碧蓝档案插件" OFF \
"57" "impart-pro-plugin              牛牛大作战" OFF \
"58" "Gi-plugin                      群互动插件" OFF \
feedback=$?
if ! [ $feedback = 0 ]
then
exit
fi
3>&1 1>&2 2>&3)
clear
_checklist="_checklist"
}

function echo_page(){
#clear
echo
echo
echo -e ${white}"#######"${green}白狐-Plug-In${white}"#######"${background}
echo -e ${green_red}1.  ${cyan}miao-plugin"               "喵喵插件${background}
echo -e ${green_red}2.  ${cyan}xiaoyao-cvs-plugin"        "逍遥图鉴${background}
echo -e ${green_red}3.  ${cyan}Guoba-Plugin"              "锅巴插件${background}
echo -e ${green_red}4.  ${cyan}zhi-plugin"                "白纸插件${background}
echo -e ${green_red}5.  ${cyan}xitian-plugin"             "戏天插件${background}
echo -e ${green_red}6.  ${cyan}Akasha-Terminal-plugin"    "虚空插件${background}
echo -e ${green_red}7.  ${cyan}xiuxian-emulator-plugin"   "绝云间修仙插件${background}
echo -e ${green_red}8.  ${cyan}Yenai-Plugin"              "椰奶插件${background}
echo -e ${green_red}9.  ${cyan}xiaofei-plugin"            "小飞插件${background}
echo -e ${green_red}10. ${cyan}earth-k-plugin"           "土块插件${background}
echo -e ${green_red}11. ${cyan}py-plugin"                "py插件${background}
echo -e ${green_red}12. ${cyan}xianxin-plugin"           "闲心插件${background}
echo -e ${green_red}13. ${cyan}lin-plugin"               "麟插件${background}
echo -e ${green_red}14. ${cyan}l-plugin"                 "L插件${background}
echo -e ${green_red}15. ${cyan}qianyu-plugin"            "千羽插件${background}
echo -e ${green_red}16. ${cyan}ql-plugin"                "清凉图插件${background}
echo -e ${green_red}17. ${cyan}flower-plugin"            "抽卡插件${background}
echo -e ${green_red}18. ${cyan}auto-plugin"              "自动化插件${background}
echo -e ${green_red}19. ${cyan}recreation-plugin"        "娱乐插件${background}
echo -e ${green_red}20. ${cyan}suiyue-plugin"            "碎月插件${background}
echo -e ${green_red}21. ${cyan}windoge-plugin"           "风歌插件${background}
echo -e ${green_red}22. ${cyan}Atlas"                    "原神图鉴${background}
echo -e ${green_red}23. ${cyan}zhishui-plugin"           "止水插件${background}
echo -e ${green_red}24. ${cyan}TRSS-Plugin"              "trss插件${background}
echo -e ${green_red}25. ${cyan}Jinmaocuicuisha"          "脆脆鲨插件${background}
echo -e ${green_red}26. ${cyan}useless-plugin"           "无用插件${background}
echo -e ${green_red}27. ${cyan}liulian-plugin"           "榴莲插件${background}
echo -e ${green_red}28. ${cyan}xiaoye-plugin"            "小叶插件${background}
echo -e ${green_red}29. ${cyan}rconsole-plugin"          "R插件${background}
echo -e ${green_red}30. ${cyan}expand-plugin"            "扩展插件${background}
echo -e ${green_red}31. ${cyan}XiaoXuePlugin"            "小雪插件${background}
echo -e ${green_red}32. ${cyan}Icepray"                  "冰祈插件${background}
echo -e ${green_red}33. ${cyan}Tlon-Sky"                 "光遇插件${background}
echo -e ${green_red}34. ${cyan}hs-qiqi-plugin"           "枫叶插件${background}
echo -e ${green_red}35. ${cyan}call_of_seven_saints"     "七圣召唤插件${background}
echo -e ${green_red}36. ${cyan}QQGuild-Plugin"           "QQ频道插件${background}
echo -e ${green_red}37. ${cyan}xiaoyue-plugin"           "小月插件${background}
echo -e ${green_red}38. ${cyan}FanSky_Qs"                "fans插件${background}
echo -e ${green_red}39. ${cyan}phi-plugin"               "phigros辅助插件${background}
echo -e ${green_red}40. ${cyan}ap-plugin"                "AI绘图插件${background}
echo -e ${green_red}41. ${cyan}sanyi-plugin"             "三一插件${background}
echo -e ${green_red}42. ${cyan}chatgpt-plugin"           "聊天插件${background}
echo -e ${green_red}43. ${cyan}y-tian-plugin"            "阴天插件${background}
echo -e ${green_red}44. ${cyan}xianyu-plugin"            "咸鱼插件${background}
echo -e ${green_red}45. ${cyan}StarRail-plugin"          "星穹铁道插件${background}
echo -e ${green_red}46. ${cyan}panel-plugin"             "面板图插件${background}
echo -e ${green_red}47. ${cyan}hanhan-plugin"            "憨憨插件${background}
echo -e ${green_red}48. ${cyan}avocado-plugin"           "鳄梨插件${background}
echo -e ${green_red}49. ${cyan}cunyx-plugin"             "寸幼萱插件${background}
echo -e ${green_red}50. ${cyan}TianRu-plugin"            "天如插件${background}
echo -e ${green_red}51. ${cyan}ws-plugin"                "ws连接插件${background}
echo -e ${green_red}52. ${cyan}WeLM-plugin"              "AI对话插件${background}
echo -e ${green_red}53. ${cyan}Yunzai-Kuro-Plugin"       "库洛插件${background}
echo -e ${green_red}54. ${cyan}mj-plugin"                "AI绘图插件${background}
echo -e ${green_red}55. ${cyan}qinghe-plugin"            "卿何插件${background}
echo -e ${green_red}56. ${cyan}BlueArchive-plugin"       "碧蓝档案插件${background}
echo -e ${green_red}57. ${cyan}impart-pro-plugin"        "牛牛大作战${background}
echo -e ${green_red}58. ${cyan}Gi-plugin"                "群互动插件${background}
echo
echo -e ${green_red}0. ${cyan}退出${background}
echo "#####################################"
#echo -e ${yellow}tip:序号为${red}白色${yellow}表示未安装'\n'序号为${green}绿色${green}表示已安装 ${background}
echo
echo -en ${green}请输入您需要安装插件的序号,可以多选,用[空格]分开:${background};read -p " " number
_checklist="_checklist"
} #echo_page

plugin_number=$(echo ${number} | sed "s/\"//g")
for plugin in ${plugin_number}
do
  case ${plugin} in
   1)
     Name=喵喵插件
     Plugin=miao-plugin
     Git=https://gitee.com/yoimiya-kokomi/miao-plugin.git 
     plugin_number=$(echo ${plugin_number} | sed "s/1//g")
     install_git_plugin${_checklist}
     ;;
   2)
     Name=逍遥图鉴
     Plugin=xiaoyao-cvs-plugin
     Git=https://gitee.com/Ctrlcvs/xiaoyao-cvs-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/2//g")
     install_git_plugin${_checklist}
     ;;
   3)
     Name=锅巴插件
     Plugin=Guoba-Plugin
     Git=https://gitee.com/guoba-yunzai/guoba-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/3//g")
     install_git_plugin${_checklist}
     ;;
   4)
     Name=白纸插件
     Plugin=zhi-plugin
     Git=https://gitee.com/headmastertan/zhi-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/4//g")
     install_git_plugin${_checklist}
     ;;
   5)
     Name=戏天插件
     Plugin=xitian-plugin
     Git=https://gitee.com/XiTianGame/xitian-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/5//g")
     install_git_plugin${_checklist}
     ;;
   6)
     Name=虚空插件
     Plugin=akasha-terminal-plugin
     Git=https://gitee.com/go-farther-and-farther/akasha-terminal-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/6//g")
     install_git_plugin${_checklist}
     ;;
   7)
     Name=绝云间修仙
     Plugin=xiuxian-emulator-plugin
     Git=https://gitee.com/xialuo03/xiuxian-emulator-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/7//g")
     install_git_plugin${_checklist}
     ;;
   8)
     Name=椰奶插件
     Plugin=yenai-plugin
     Git=https://gitee.com/yeyang52/yenai-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/8//g")
     install_git_plugin${_checklist}
     ;;
   9)
     Name=小飞插件
     Plugin=xiaofei-plugin
     Git=https://gitee.com/xfdown/xiaofei-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/9//g")
     install_git_plugin${_checklist}
     ;;
   10)
     Name=土块插件
     Plugin=earth-k-plugin
     Git=https://gitee.com/SmallK111407/earth-k-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/10//g")
     install_git_plugin${_checklist}
     ;;
   11)
     if [ ! -x "$(command -v pip)" ];then
       echo -en ${cyan}检测到未安装pip 回车返回${background};read
       exit
     fi 
     if [ ! -x "$(command -v poetry)" ];then
       echo -en ${cyan}检测到未安装poetry 回车返回${background};read
     fi
     Name=py插件
     Plugin=py-plugin
     Git=https://gitee.com/realhuhu/py-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/11//g")
     install_git_plugin${_checklist}
   if [ -d plugins/py-plugin ]
   then
     function dialog_whiptail_page(){
     if (${dialog_whiptail} \
     --title "白狐-Bot-Plugin" \
     --yes-button "本地" \
     --no-button "远程" \
     --yesno "请选择py运算的服务器" \
     10 60)
     then
       cd plugins/py-plugin
       pip_mirrors
       cd ../../
     else
       py_server
     fi  
     }
     function echo_page(){
     echo -en ${green}是否启用py远程服务器 ${cyan}[N/y] ${background}
     read -p "" num
        case $num in
     y|Y)
       py_server
       ;;
     N|n)
       cd plugins/py-plugin
       pip_mirrors
       cd ../../
       ;;
     *)
       echo ${red}输入错误${background}
       ;;
     esac
     }
     choose_page
     else
     exit
     fi
     ;;   
   12)
     Name=闲心插件
     Plugin=xianxin-plugin
     Git=https://gitee.com/xianxincoder/xianxin-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/12//g")
     install_git_plugin${_checklist}
     ;;
   13)
     Name=麟插件
     Plugin=lin-plugin
     Git=https://gitee.com/go-farther-and-farther/lin-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/13//g")
     install_git_plugin${_checklist}
     ;;
   14)
     Name=L插件
     Plugin=l-plugin
     ghproxy_agency
     Git=${ghproxy}https://github.com/liuly0322/l-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/14//g")
     install_git_plugin${_checklist}
     ;;
   15)
     Name=千羽插件
     Plugin=reset-qianyu-plugin
     Git=https://gitee.com/think-first-sxs/reset-qianyu-plugin
     plugin_number=$(echo ${plugin_number} | sed "s/15//g")
     install_git_plugin${_checklist}
     ;;
   16)
     Name=清凉图插件
     Plugin=ql-plugin
     Git=https://gitee.com/xwy231321/ql-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/16//g")
     install_git_plugin${_checklist}
     ;;
   17)
     Name=抽卡插件
     Plugin=flower-plugin
     Git=https://gitee.com/Nwflower/flower-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/17//g")
     install_git_plugin${_checklist}
     ;;
   18)
     Name=自动化插件
     Plugin=auto-plugin
     Git=https://gitee.com/Nwflower/auto-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/18//g")
     install_git_plugin${_checklist}
     ;;
   19)
     Name=娱乐插件
     Plugin=recreation-plugin
     Git=https://gitee.com/zzyAJohn/recreation-plugin
     plugin_number=$(echo ${plugin_number} | sed "s/19//g")
     install_git_plugin${_checklist}
     ;;
   20)
     Name=碎月插件
     Plugin=suiyue
     Git=https://gitee.com/Acceleratorsky/suiyue.git
     plugin_number=$(echo ${plugin_number} | sed "s/20//g")
     install_git_plugin${_checklist}
     ;;
   21)
     Name=风歌插件
     Plugin=windoge-plugin
     ghproxy_agency
     Git=${ghproxy}https://github.com/gxy12345/windoge-plugin
     plugin_number=$(echo ${plugin_number} | sed "s/21//g")
     install_git_plugin${_checklist}
     ;;
   22)
     Name=Atlas[图鉴]
     Plugin=Atlas
     Git=https://gitee.com/Nwflower/atlas
     plugin_number=$(echo ${plugin_number} | sed "s/22//g")
     install_git_plugin${_checklist}
     ;;
   23)
     Name=止水插件
     Plugin=zhishui-plugin
     Git=https://gitee.com/fjcq/zhishui-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/23//g")
     install_git_plugin${_checklist}
     ;;
   24)
     Name=trss插件
     Plugin=TRSS-Plugin
     Git=https://gitee.com/TimeRainStarSky/TRSS-Plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/24//g")
     install_git_plugin${_checklist}
     ;;
   25)
     Name=脆脆鲨插件
     Plugin=Jinmaocuicuisha-plugin
     Git=https://gitee.com/JMCCS/jinmaocuicuisha.git
     plugin_number=$(echo ${plugin_number} | sed "s/25//g")
     install_git_plugin${_checklist}
     ;;
   26)
     Name=无用插件
     Plugin=useless-plugin
     Git=https://gitee.com/SmallK111407/useless-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/26//g")
     install_git_plugin${_checklist}
     ;;
   27)
     Name=榴莲插件
     Plugin=liulian-plugin
     Git=https://gitee.com/huifeidemangguomao/liulian-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/27//g")
     install_git_plugin${_checklist}
     ;;
   28)
     Name=小叶插件
     Plugin=xiaoye-plugin
     Git=https://gitee.com/xiaoye12123/xiaoye-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/28//g")
     install_git_plugin${_checklist}
     ;;
   29)
     Name=R插件
     Plugin=rconsole-plugin
     Git=https://gitee.com/kyrzy0416/rconsole-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/29//g")
     install_git_plugin${_checklist}
     ;;
   30)
     Name=扩展插件
     Plugin=expand-plugin
     Git=https://gitee.com/SmallK111407/expand-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/30//g")
     install_git_plugin${_checklist}
     ;;
   31)
     Name=小雪插件
     Plugin=XiaoXuePlugin
     Git=https://gitee.com/XueWerY/XiaoXuePlugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/31//g")
     install_git_plugin${_checklist}
     ;;
   32)
     Name=冰祈插件
     Plugin=Icepray
     Git=https://gitee.com/koinori/Icepray.git
     plugin_number=$(echo ${plugin_number} | sed "s/32//g")
     install_git_plugin${_checklist}
     ;;
   33)
     Name=光遇插件
     Plugin=Tlon-Sky
     Git=https://gitee.com/Tloml-Starry/Tlon-Sky.git
     plugin_number=$(echo ${plugin_number} | sed "s/33//g")
     install_git_plugin${_checklist}
     ;;
   34)
     Name=枫叶插件
     Plugin=hs-qiqi-plugin
     Git=https://gitee.com/kesally/hs-qiqi-cv-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/34//g")
     install_git_plugin${_checklist}
     ;;
   35)
     Name=七圣召唤插件
     Plugin=call_of_seven_saints
     Git=https://gitee.com/huangshx2001/call_of_seven_saints.git
     plugin_number=$(echo ${plugin_number} | sed "s/35//g")
     install_git_plugin${_checklist}
     ;;
   36)
     Name=QQ频道插件
     Plugin=QQGuild-Plugin
     ghproxy_agency
     Git=${ghproxy}https://github.com/2y8e9h22/QQGuild-Plugin
     plugin_number=$(echo ${plugin_number} | sed "s/36//g")
     install_git_plugin${_checklist}
     ;;
   37)
     Name=小月插件
     Plugin=xiaoyue-plugin
     Git=https://gitee.com/bule-Tech/xiaoyue-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/37//g")
     install_git_plugin${_checklist}
     ;;
   38)
     Name=fans插件
     Plugin=FanSky_Qs
     Git=https://gitee.com/FanSky_Qs/FanSky_Qs.git
     plugin_number=$(echo ${plugin_number} | sed "s/38//g")
     install_git_plugin${_checklist}
     ;;
   39)
     Name=phigros辅助插件
     Plugin=phi-plugin
     ghproxy_agency
     Git=${ghproxy}https://github.com/Catrong/phi-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/39//g")
     install_git_plugin${_checklist}
     ;;
   40)
     Name=ap绘图插件
     Plugin=ap-plugin
     Git=https://gitee.com/yhArcadia/ap-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/40//g")
     install_git_plugin${_checklist}
     ;;
   41)
     Name=三一插件
     Plugin=sanyi-plugin
     Git=https://gitee.com/ThreeYi/sanyi-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/41//g")
     install_git_plugin${_checklist}
     ;;
   42)
     Name=聊天插件
     Plugin=chatgpt-plugin
     ghproxy_agency
     Git=${ghproxy}https://github.com/ikechan8370/chatgpt-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/42//g")
     install_git_plugin${_checklist}
     ;;
   43)
     Name=阴天插件
     Plugin=y-tian-plugin
     Git=https://gitee.com/wan13877501248/y-tian-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/43//g")
     install_git_plugin${_checklist}
     ;;
   44)
     Name=咸鱼插件
     Plugin=xianyu-plugin
     Git=https://gitee.com/suancaixianyu/xianyu-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/44//g")
     install_git_plugin${_checklist}
     ;;
   45)
     Name=星穹铁道插件
     Plugin=StarRail-plugin
     Git=https://gitee.com/hewang1an/StarRail-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/45//g")
     install_git_plugin${_checklist}
     ;;
   46)
     Name=面板图插件
     Plugin=panel-plugin
     Git=https://gitee.com/yunzai-panel/panel-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/46//g")
     install_git_plugin${_checklist}
     ;;
   47)
     Name=憨憨插件
     Plugin=hanhan-plugin
     Git=https://gitee.com/han-hanz/hanhan-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/47//g")
     install_git_plugin${_checklist}
     ;;
   48)
     Name=鳄梨插件
     Plugin=avocado-plugin
     Git=https://gitee.com/sean_l/avocado-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/48//g")
     install_git_plugin${_checklist}
     ;;
   49)
     Name=寸幼萱插件
     Plugin=cunyx-plugin
     Git=https://gitee.com/cunyx/cunyx-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/49//g")
     install_git_plugin${_checklist}
     ;;
   50)
     Name=天如插件
     Plugin=tianru-plugin
     Git=https://gitee.com/HDTianRu/TianRu-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/50//g")
     install_git_plugin${_checklist}
     ;;
   51)
     Name=ws连接插件
     Plugin=ws-plugin
     Git=https://gitee.com/xiaoye12123/ws-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/51//g")
     install_git_plugin${_checklist}
     ;;
   52)
     Name=AI对话插件
     Plugin=WeLM-plugin
     Git=https://gitee.com/shuciqianye/yunzai-custom-dialogue-welm.git
     plugin_number=$(echo ${plugin_number} | sed "s/52//g")
     install_git_plugin${_checklist}
     ;;
   53)
     Name=库洛插件
     Plugin=Yunzai-Kuro-Plugin
     Git=https://gitee.com/TomyJan/Yunzai-Kuro-Plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/53//g")
     install_git_plugin${_checklist}
     ;;
   54)
     Name=AI绘图插件
     Plugin=mj-plugin
     Git=https://gitee.com/CikeyQi/mj-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/54//g")
     install_git_plugin${_checklist}
     ;;
   55)
     Name=卿何插件
     Plugin=qinghe-plugin
     Git=https://gitee.com/Tloml-Starry/qinghe-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/55//g")
     install_git_plugin${_checklist}
     ;;
   56)
     Name=碧蓝档案插件
     Plugin=BlueArchive-plugin
     Git=https://gitee.com/all-thoughts-are-broken/blue-archive.git
     plugin_number=$(echo ${plugin_number} | sed "s/56//g")
     install_git_plugin${_checklist}
     ;;
   57)
     Name=牛牛大作战
     Plugin=impart-pro-plugin
     Git=https://gitee.com/sumght/impart-pro-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/57//g")
     install_git_plugin${_checklist}
     ;;
   58)
     Name=群互动插件
     Plugin=Gi-plugin
     Git=https://gitee.com/qiannqq/gi-plugin.git
     plugin_number=$(echo ${plugin_number} | sed "s/58//g")
     install_git_plugin${_checklist}
     ;;
   0)
     echo
     exit
     ;;
  esac    
done

if [ -d "plugins" ];then
path="."
else
echo -e ${red}错误的路径${background}
exit
fi

function MCASC(){
case ${MCASC} in
Single)
dialog_whiptail_page_menu
;;
Multiple)
dialog_whiptail_page_checklist
;;
*)
echo -e ${red}错误的变量${background}
exit
;;
esac
}

function choose_page(){
case ${page} in
whiptail)
dialog_whiptail=whiptail
MCASC
;;
dialog)
dialog_whiptail=dialog
MCASC
;;
echo)
echo_page
;;
*)
echo -e ${red}错误的变量${background}
exit
;;
esac
}

function pnpm_install(){
if ! [ -x "$(command -v pnpm)" ];then
    echo -e ${cyan}检测到未安装pnpm 开始安装${background}
    npm install -g pnpm --registry=https://registry.npmmirror.com
fi
}
pnpm_install

choose_page

}
function mainbak()
{
   while true
   do
       main
       mainbak
   done
}
mainbak
