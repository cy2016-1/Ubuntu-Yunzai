#!/bin/bash
function pip_mirrors(){
function py_install(){
pip install --upgrade pip -i ${mirror}
pip config set global.index-url ${mirror}
pip config set global.index-url ${mirror}
poetry install
poetry install
poetry run pip install --upgrade pip -i ${mirror}
poetry run pip install -r requirements.txt -i ${mirror}
poetry run pip install -r requirements.txt -i ${mirror}
}
green="\033[32m"
blue="\033[36m"
background="\033[0m"
white="\033[37m"
echo 
echo
echo -e ${white}"#####"${green}白狐-Yunzai-Bot${white}"#####"${background}
echo -e ${blue}请输入要选择的pip镜像源${background}
echo "#########################"
echo -e ${green}1.  ${blue}清华${background}
echo -e ${green}2.  ${blue}北外${background}
echo -e ${green}3.  ${blue}阿里${background}
echo -e ${green}4.  ${blue}豆瓣${background}
echo -e ${green}5.  ${blue}中科大${background}
echo -e ${green}6.  ${blue}华为${background}
echo -e ${green}7.  ${blue}腾讯${background}
echo
echo -e ${green}8.  ${blue}老子就不换" "你能咋滴${background}
echo "#########################"
echo -e ${green}QQ群:${blue}狐狸窝:705226976${background}
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
    mirror=" "
    py_install
  ;;
  *)
    echo;echo -en "\033[31m输入错误\033[0m";read
  ;;
esac
}
function Linux_js_file_management(){
if [ -e js.log ];then
rm js.log
fi
clear
a=0
green="\033[32m"
blue="\033[34m"
background="\033[0m"
echo
echo "#######################"
for file in $(ls ${path}/plugins/example)
do
a=$(($a+1))
echo -e ${green}${a}". "${blue}${file}${background}
done
echo
echo -e ${green}0.${blue}返回${background}
echo "#######################"
a=0
echo -en "\033[32m请输入您要删除的插件序号: \033[0m";read -p "" Number
if [ "$Number" = 0 ];then
baihu_whiptail
exit
fi
if [[ "$Number" =~ ^[0-9]+$ ]]; then
  ls ${path}/plugins/example > js.log
  content=`sed -n "${Number}p" js.log`
  if [ ${path}/plugins/example/${content} = ${path}/plugins/example/ ]
    then
      echo;echo -en "\033[31m输入错误\033[0m";echo
      exit
  fi
  rm -rf ${path}/plugins/example/${content}
  rm -rf ${path}/plugins/example/${content} &>/dev/null
  if [ -e ${path}/plugins/example/${content} ]
    then
      echo;echo -en "\033[31m 删除失败 回车返回\033[0m";read -p ""
    else
      echo;echo -en "\033[36m 删除完成 回车返回\033[0m";read -p ""
  fi
else
  echo;echo -en "\033[31m 输入错误 回车返回\033[0m";read -p ""
fi
}
function Linux_git_file_management(){
clear
a=0
green="\033[32m"
blue="\033[36m"
background="\033[0m"
echo
echo "#######################"
for file in $(ls -I example -I bin -I other -I system ${path}/plugins)
do
a=$(($a+1))
echo -e ${green}${a}". "${blue}${file}${background}
done
echo
echo -e ${green}0.${blue}返回${background}
echo "#######################"
a=0
echo -en "\033[32m 请输入您要删除的插件的序号: \033[0m";read -p "" Number
if [ "$Number" = 0 ];then
baihu_whiptail
exit
fi
if [[ "$Number" =~ ^[0-9]+$ ]]; then
  ls -I example -I bin -I other -I system ${path}/plugins > plugin_record.txt
  content=`sed -n "${Number}p" plugin_record.txt`
  if [ ${path}/plugins/${content} = ${path}/plugins/ ]
    then
      echo;echo -en "\033[31m输入错误\033[0m";echo
      exit
  fi
  if [ ${path}/plugins/${content} = ${path}/plugins/genshin ]
    then
      echo;echo -en "\033[31m禁止删除该插件\033[0m";echo
      exit
  fi
  rm -rf plugins/${content}
  rm -rf plugins/${content} &>/dev/null
  if [ -d plugins/${content} ]
    then
      echo;echo -en "\033[31m 删除失败 回车返回\033[0m";read -p ""
    else
      echo;echo -en "\033[36m 删除完成 回车返回\033[0m";read -p ""
  fi
else
  echo;echo -en "\033[31m 输入错误 回车返回\033[0m";read -p ""
fi
}
function Linux_js_install(){
if [ -e js.log ];then
rm js.log
fi
function ghproxy_js(){
green="\033[32m"
blue="\033[36m"
background="\033[0m"
echo -en  ${green}${jsname}位于github 是否启用ghproxy镜像站 ${blue}'\n'启用[y]" "取消[n] [区分大小写]:${background};read -p "" num
  case $num in
     y)
       echo "curl https://ghproxy.com/${js} > ${jsname}" > plugins/example/js.log
       ;;
     n)
       echo "curl ${js} > ${jsname}" > plugins/example/js.log
       ;;
     *)
       echo -e "\033[31m请正确输入 \033[36m回车返回\033[0m";read -p ""
       exit
       ;;
  esac
}
green="\033[32m"
blue="\033[36m"
background="\033[0m"
white="\033[37m"
clear
echo
echo
echo "#######################"
echo -e ${green}1. ${blue}通过 gitee/github 链接安装${background}
echo -e ${green}2. ${blue}通过 Download 文件夹安装[仅限termux]${background}
echo -e ${green}3. ${blue}通过 QQ 文件夹安装[仅限termux]${background}
echo
echo -e ${green}0. ${blue}返回${background}
echo "#######################"
echo -en "\033[35m请输入选项 \033[0m";read number
 case ${number} in
    1)
     echo;echo -en "\033[35m请输入链接: \033[0m";read js
     jsname=`echo $js | awk -F/ '{print $NF}'`
     if [[ $js != http* ]] || [[ $js != *.js ]];then
       echo -e "\033[31m 输入错误\033[0m"
       exit 1
     fi
     cd ${path}/plugins/example
     if [[ $js == *"raw"* ]];then
       curl ${js} > ${jsname}
         if [ ! -f "${jsname}" ];then
           echo -e "\033[31m ${jsname}下载失败\033[0m"
           exit 1
         fi
     else
       if [[ ${js} == *"gitee"* ]];then
         echo "curl ${js} > ${jsname}" > js.log
         sed -i 's/blob/raw/g' js.log
         bash js.log
         if [ ! -f "${jsname}" ];then
           echo -e ${green}${jsname}${blue}下载失败${background}
           exit
         fi
         echo -en ${green}${jsname}${blue}下载成功 回车返回${background};read 
       fi
       if [[ ${js} == *"github"* ]];then
         sed -i 's/blob\///g' js.log
         sed -i 's/github/${ghproxy_js}raw.githubusercontent/g' js.log
         ghproxy_js
         bash js.log
         if [ ! -f "$jsname" ];then
           echo -e ${green}${jsname}${blue}下载失败${background}
           exit
         fi
         echo -en ${green}${jsname}${blue}下载成功 回车返回${background};read 
         rm  js.log
       fi
     fi
     cd ../../
     ;;
   2)
    if [ -d "/media/sd" ];then
      sdpath=/media/sd
    fi
    if [ -d "/media/sd/Download" ];then
      sdpath=/media/sd/Download
    fi
    if [ -d "/sdcard/Download" ];then
      sdpath=/sdcard/Download
    fi
    if [ -d "/storage/emulated/0/Download" ];then
      sdpath=/storage/emulated/0/Download
    fi
    if [ -d "${sdpath}" ];then
    echo -e ${blue}目录不存在!${background}
    fi
   clear
   a=0
   green="\033[32m"
   blue="\033[36m"
   background="\033[0m"
   if [ -e js.log ];then
   rm js.log
   fi
   echo
   echo "#######################"
   for file in $(ls ${sdpath})
   do
   if [[ ${file} = *".js" ]];then
   a=$(($a+1))
   echo -e ${green}${a}". "${blue}${file}${background}
   echo ${file} >> js.log
   fi
   done
   echo
   echo -e ${green}0.${blue}返回${background}
   echo "#######################"
   a=0
   echo -en "\033[32m 请输入您要安装的插件的序号: \033[0m";read -p "" Number
   if [ "$Number" = 0 ];then
       baihu_whiptail
     else
     if [[ "$Number" =~ ^[0-9]+$ ]];then
       content=`sed -n "${Number}p" js.log`
        if [ "${sdpath}/${content}" = "${sdpath}" ]
          then
          echo;echo -en "\033[31m输入错误\033[0m";echo
          exit
        fi
        cp ${sdpath}/${content} ${path}/plugins/example/
       if [ -f "plugins/example/${content}" ];then
         echo;echo -en "\033[36m 安装完成 回车返回\033[0m";read
       else
         echo;echo -en "\033[36m 安装失败 回车返回\033[0m";read
       fi
     else
       echo;echo -en "\033[31m 输入错误 回车返回\033[0m";read
     fi
   fi
    cd ../../
     ;;
   3)
    if [ -d "/media/sd/Android/data/com.tencent.mobileqq/Tencent/QQfile_recv" ];then
      sdpath=/media/sd/Android/data/com.tencent.mobileqq/Tencent/QQfile_recv
    fi
    if [ -d "/sdcard/Android/data/com.tencent.mobileqq/Tencent/QQfile_recv" ];then
     sdpath=/sdcard/Android/data/com.tencent.mobileqq/Tencent/QQfile_recv
    fi
    if [ -d "/storage/emulated/0/Android/data/com.tencent.mobileqq/Tencent/QQfile_recv" ];then
     sdpath=/storage/emulated/0/Android/data/com.tencent.mobileqq/Tencent/QQfile_recv
    fi
    if [ -d "${sdpath}" ];then
    echo -e ${blue}目录不存在!${background}
    fi
   clear
   a=0
   green="\033[32m"
   blue="\033[36m"
   background="\033[0m"
   echo
   echo "#######################"
   for file in $(ls ${sdpath})
   do
   if [[ ${file} = *.js ]];then
   a=$(($a+1))
   echo -e ${green}${a}". "${blue}${file}${background}
   echo ${file} >> js.log
   fi
   done
   echo
   echo -e ${green}0.${blue}返回${background}
   echo "#######################"
   a=0
   echo -en "\033[32m 请输入您要安装的插件的序号: \033[0m";read -p "" Number
   if [ "$Number" = 0 ];then
       baihu_whiptail
     else
     if [[ "$Number" =~ ^[0-9]+$ ]];then
       content=`sed -n "${Number}p" js.log`
        if [ "${sdpath}/${content}" = "${sdpath}" ]
          then
          echo;echo -en "\033[31m输入错误\033[0m";echo
          exit
        fi
        cp ${sdpath}/${content} ${path}/plugins/example/
       if [ -f "${path}/plugins/example/${content}" ];then
        echo;echo -en "\033[36m 安装完成 回车返回\033[0m";read
       else
        echo;echo -en "\033[36m 安装失败 回车返回\033[0m";read
       fi
       else
       echo;echo -en "\033[31m 输入错误 回车返回\033[0m";read -p ""
     fi
   fi
    cd ../../ 
     ;;
   0)
     Linux
     ;;
   esac
}
function Linux(){
function baihu_whiptail(){
if [ -f "${path}/plugins/example/js.log" ];then
rm ${path}/plugins/example/js.log
fi
cd ${path}
baihu=$(whiptail \
--title "白狐" \
--menu "白狐的QQ群:705226976" \
20 40 10 \
"1" "安装git插件" \
"2" "安装js插件" \
"3" "更新git插件" \
"4" "删除git插件" \
"5" "删除js插件" \
"6" "修复py依赖和端口报错" \
"7" "py切换本地与远程服务" \
"8" "修改锅巴端口" \
"9" "使用文字版菜单" \
"0" "退出" \
3>&1 1>&2 2>&3)
feedback=$?
if [ $feedback = 0 ];then
  case $baihu in
    1)
      whiptail_plugins
      ;;
    2)
      Linux_js_install
      ;;
    3)
      echo
      echo -e "\033[33m正在更新Yunzai\033[0m"
      cd ${path}
      git pull
      cd ../
      echo -e "\033[33mYunzai更新完成\033[0m"
      for file in $(ls -I example -I bin -I other -I system -I genshin ${path}/plugins)
      do
        if [ -d ${path}/plugins/${file} ];then
          echo
          echo -e "\033[33m正在更新${file}\033[0m"
          cd ${path}/plugins/${file}
          git pull
          cd ../../
          echo -e "\033[33m${file}更新完成\033[0m"
        fi
      done
      echo;echo -en "\033[32m全部更新完成 回车返回\033[0m";read -p ""
      ;;
    4)
      Linux_git_file_management
      ;;
    5)
      Linux_js_file_management
      ;;
    6)
     if [ -d "plugins/py-plugin" ]
       then
         cd plugins/py-plugin
         pip_mirrors
         poetry install 
         poetry install
         function py_(){
         min=$1
         max=$(($2-$min+1))
         num=$(date +%s%N)
         echo $(($num%$max+$min))
         }
         pyport=$(py_ 40000 60000)
         if [ -e "${path}plugins/py-plugin/config.yaml" ]
            then
               sed -i "15s/.*/port: ${pyport}/g" ${path}/plugins/py-plugin/config.yaml
               echo;echo -en "\033[36m 执行完成 回车返回\033[0m";read
            else
               cp ${path}/plugins/py-plugin/config_default.yaml ${path}/plugins/py-plugin/config.yaml
               sed -i "15s/.*/port: ${pyport}/g" ${path}/plugins/py-plugin/config.yaml
               echo;echo -en "\033[36m 执行完成 回车返回\033[0m";read
         fi
         pushd ../../
       else
         echo -e "\033[33m 未安装py插件 回车返回 \033[0m";read
     fi
     ;;
    7)
     if [ -d "plugins/py-plugin" ]
     then
       if [ -e "${path}/plugins/py-plugin/config.yaml" ]
          then
            if grep -q "host: 159.75.113.47" ${path}/plugins/py-plugin/config.yaml
              then
                sed -i "s/host: 159.75.113.47/host: 127.0.0.1/g" ${path}/plugins/py-plugin/config.yaml
                echo;echo -en "\033[36m 已切换为本地服务器 请安装/更新依赖 回车继续\033[0m";read
                echo
                cd plugins/py-plugin
                pip_mirrors
                cd ../../
                echo;echo -en "\033[36m 执行完成 回车返回\033[0m";read
              else
                sed -i "s/host: 127.0.0.1/host: 159.75.113.47/g" ${path}/plugins/py-plugin/config.yaml
                echo;echo -en "\033[36m 已切换为远程服务器 回车返回\033[0m";read -p ""
            fi
          else
            if grep -q "host: 159.75.113.47" ${path}/plugins/py-plugin/config.yaml
              then
                cp ${path}/plugins/py-plugin/config_default.yaml ${path}/plugins/py-plugin/config.yaml
                sed -i "s/host: 159.75.113.47/host: 127.0.0.1/g" ${path}/plugins/py-plugin/config.yaml
                echo;echo -en "\033[36m 已切换为本地服务器 请安装/更新依赖 回车继续\033[0m";
                echo
                cd plugins/py-plugin
                pip_mirrors
                cd ../../
                echo;echo -en "\033[36m 执行完成 回车返回\033[0m";read
              else
                cp ${path}/plugins/py-plugin/config_default.yaml ${path}/plugins/py-plugin/config.yaml
                sed -i "s/host: 127.0.0.1/host: 159.75.113.47/g" ${path}/plugins/py-plugin/config.yaml
                echo;echo -en "\033[36m 已切换为远程服务器 回车返回\033[0m";read -p ""
            fi
       fi
     else
         echo -e "\033[33m 未安装py插件 回车返回 \033[0m";read
     fi
      ;;
    8)
     if [ -e "plugins/Guoba-Plugin/config/application.yaml" ]
       then
         echo -en "\033[32m 请输入更改之后的端口号[] \033[0m"; read -p "" gbport
           if [[ "${gbport}" =~ ^[0-9]+$ ]]; then
             sed -i "s/.*port.*/  port: ${gbport}/g" plugins/Guoba-Plugin/config/application.yaml
	         echo;echo -en "\033[36m 更改完成 回车返回\033[0m";read
	       fi
       else
         echo -en "\033[31m 文件不存在,请确认是否安装锅巴并启动过一次 \033[0m";
         exit
     fi
     ;;
    9)
      Other_Linux
      ;;
    0)
      exit
      ;;
  esac
else
    exit
fi
}
function Yunzai(){
if [ -d "/root/Yunzai-Bot" ];then
path="/root/Yunzai-Bot"
elif [ -d "/home/Yunzai-Bot" ];then
path="/home/Yunzai-Bot"
elif [ -d "/home/lighthouse/ubuntu/Yunzai-Bot" ];then
path="/home/lighthouse/ubuntu/Yunzai-Bot"
elif [ -d "/home/lighthouse/centos/Yunzai-Bot" ];then
path="/home/lighthouse/centos/Yunzai-Bot"
elif [ -d "/home/lighthouse/debian/Yunzai-Bot" ];then
path="/home/lighthouse/debian/Yunzai-Bot"
elif [ -d "/home/lighthouse/debian/Yunzai-Bot" ];then
path="/home/lighthouse/debian/Yunzai-Bot"
elif [ -d "/root/TRSS_Yunzai/Yunzai" ];then
path="/root/TRSS_Yunzai/Yunzai"
elif [ -d "Yunzai-Bot" ];then
path="./Yunzai-Bot"
elif [ -d "plugins" ];then
path="."
else
whiptail --title "白狐≧▽≦" --msgbox "
您还没有安装云崽 禁止安装插件
" 10 43
exit
fi
}
function Miaozai(){
if [ -d "/root/Miao-Yunzai" ];then
path="/root/Miao-Yunzai"
elif [ -d "/home/Miao-Yunzai" ];then
path="/home/Miao-Yunzai"
elif [ -d "/home/lighthouse/ubuntu/Miao-Yunzai" ];then
path="/home/lighthouse/ubuntu/Miao-Yunzai"
elif [ -d "/home/lighthouse/centos/Miao-Yunzai" ];then
path="/home/lighthouse/centos/Miao-Yunzai"
elif [ -d "/home/lighthouse/debian/Miao-Yunzai" ];then
path="/home/lighthouse/debian/Miao-Yunzai"
elif [ -d "/home/lighthouse/debian/Miao-Yunzai" ];then
path="/home/lighthouse/debian/Miao-Yunzai"
elif [ -d "/root/TRSS_Yunzai/Yunzai" ];then
path="/root/TRSS_Yunzai/Yunzai"
elif [ -d "Miao-Yunzai" ];then
path="./Miao-Yunzai"
elif [ -d "plugins" ];then
path="."
else
whiptail --title "白狐≧▽≦" --msgbox "
您还没有安装喵崽 禁止安装插件
" 10 43
exit
fi
}
if (whiptail --title "白狐≧▽≦" \
    --yes-button "云崽" \
    --no-button "喵崽" \
    --yesno "请选择您要管理的对象" \
    10 60) 
  then
     Yunzai
  else
     Miaozai
fi
function whiptail_install_plugins(){
green="\033[32m"
blue="\033[36m"
background="\033[0m"
if [ -d ${path}/plugins/${Plugin} ]
  then
    clear
    if (whiptail --title "白狐-Yunzai-Bot-plugin" \
       --yesno "        您已安装${Name}，是否删除" \
       10 48);then
         echo -e "\033[36m 正在删除${Name} \033[0m";
         rm -rf ${path}/plugins/${Plugin}
         rm -rf ${path}/plugins/${Plugin} &>/dev/null
       if [ -d ${path}/plugins/${Plugin} ]
         then
           echo;echo -en "\033[32m 删除失败 回车返回\033[0m";read -p ""
         else
           echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
       fi
    fi
  else
    clear
    echo
    echo
    echo -e ${green}建议到插件地址查看使用方法'\n'${blue}${Git}${background}
    echo
    sleep 2s
    echo "=================================="
    echo 正在安装${Name}，稍安勿躁～
    echo "=================================="
    echo
    git clone --depth=1 ${Git} ./plugins/${Plugin}
    if [ -d ${path}/plugins/${Plugin} ]
    then
      echo -e "\033[36m正在处理依赖\033[0m"
      cd ${path}/plugins/${Plugin}
      pnpm install -P
      cd ../../ 
      echo;echo -en "\033[32m安装完成 回车返回\033[0m";read -p ""
    else
      echo;echo -en "\033[31m安装失败 回车返回\033[0m";read -p ""
    fi
fi
}
function whiptail_plugins(){
pushd ${path}
number=$(whiptail \
--title "白狐-QQ群:705226976" \
--menu "37个插件" \
23 50 15 \
"0" "返回" \
"1" "miao-plugin                    喵喵插件" \
"2" "xiaoyao-cvs-plugin             逍遥图鉴" \
"3" "Guoba-Plugin                   锅巴插件" \
"4" "zhi-plugin                     白纸插件" \
"5" "xitian-plugin                  戏天插件" \
"6" "Akasha-Terminal-plugin         虚空插件" \
"7" "Xiuxian-Plugin-Box             修仙插件" \
"8" "Yenai-Plugin                   椰奶插件" \
"9" "xiaofei-plugin                 小飞插件" \
"10" "earth-k-plugin                 土块插件" \
"11" "py-plugin                      py插件" \
"12" "xianxin-plugin                 闲心插件" \
"13" "lin-plugin                     麟插件" \
"14" "l-plugin                       L插件" \
"15" "qianyu-plugin                  千羽插件" \
"16" "yunzai-c-v-plugin              清凉图插件" \
"17" "flower-plugin                  抽卡插件" \
"18" "auto-plugin                    自动化插件" \
"19" "recreation-plugin              娱乐插件" \
"20" "suiyue-plugin                  碎月插件" \
"21" "windoge-plugin                 风歌插件" \
"22" "Atlas                          原神图鉴" \
"23" "zhishui-plugin                 止水插件" \
"24" "TRSS-Plugin                    trss插件" \
"25" "Jinmaocuicuisha                脆脆鲨插件" \
"26" "alemon-plugin                  半柠檬插件" \
"27" "liulian-plugin                 榴莲插件" \
"28" "xiaoye-plugin                  小叶插件" \
"29" "rconsole-plugin                R插件" \
"30" "expand-plugin                  扩展插件" \
"31" "XiaoXuePlugin                  小雪插件" \
"32" "Icepray                        冰祈插件" \
"33" "xiuxian-emulator-plugin        绝云间修仙" \
"34" "Tlon-Sky                       光遇插件" \
"35" "hs-qiqi-plugin                 枫叶插件" \
"36" "call_of_seven_saints           七圣召唤插件" \
"37" "QQGuild-Plugin                 QQ频道插件" \
3>&1 1>&2 2>&3)
feedback=$?
if [ $feedback = 0 ];then
  if [[ ${number} = 0 ]]
  then
  exit 0
  fi
else
    exit
fi
case $number in
   1)
     Name=喵喵插件 #插件中文名字
     Plugin=miao-plugin #插件名
     Git=https://gitee.com/yoimiya-kokomi/miao-plugin.git #仓库链接
     whiptail_install_plugins #调用安装
     ;;
   2)
     Name=逍遥图鉴
     Plugin=xiaoyao-cvs-plugin
     Git=https://gitee.com/Ctrlcvs/xiaoyao-cvs-plugin.git
     whiptail_install_plugins
     ;;
   3)
     Name=锅巴插件
     Plugin=Guoba-Plugin
     Git=https://gitee.com/guoba-yunzai/guoba-plugin.git
     whiptail_install_plugins
     ;;
   4)
     Name=白纸插件
     Plugin=zhi-plugin
     Git=https://gitee.com/headmastertan/zhi-plugin.git
     whiptail_install_plugins
     ;;
   5)
     Name=戏天插件
     Plugin=xitian-plugin
     Git=https://gitee.com/XiTianGame/xitian-plugin.git
     whiptail_install_plugins
     ;;
   6)
     Name=虚空插件
     Plugin=akasha-terminal-plugin
     Git=https://gitee.com/go-farther-and-farther/akasha-terminal-plugin.git
     whiptail_install_plugins
     ;;
   7)
     Name=修仙插件
     Plugin=xiuxian-plugin
     Git=https://gitee.com/ningmengchongshui/Xiuxian-Plugin-Box.git
     whiptail_install_plugins
     ;;
   8)
     Name=椰奶插件
     Plugin=yenai-plugin
     Git=https://gitee.com/yeyang52/yenai-plugin.git
     whiptail_install_plugins
     ;;
   9)
     Name=小飞插件
     Plugin=xiaofei-plugin
     Git=https://gitee.com/xfdown/xiaofei-plugin.git
     whiptail_install_plugins
     ;;
   10)
     Name=土块插件
     Plugin=earth-k-plugin
     Git=https://gitee.com/SmallK111407/earth-k-plugin.git
     whiptail_install_plugins
     ;;
   11)
     if [ "$(uname)" == "Linux" ]
     then
       if ! [ -x "$(command -v poetry)" ]
         then
           echo -en "\033[31m 你还没有安装poetry呢 回车退出 \033[0m";read -p ""
           exit
       fi
       Name=py插件
       Plugin=py-plugin
       Git=https://gitee.com/realhuhu/py-plugin.git
       green="\033[32m"
       blue="\033[36m"
       background="\033[0m"
       if [ -d ${path}/plugins/${Plugin} ]
         then
           clear
           if (whiptail --title "白狐-Yunzai-Bot-plugin" \
             --yesno "        您已安装${Name}，是否删除" \
             10 48);then
             echo -e "\033[36m 正在删除${Name} \033[0m";
               rm -rf ${path}/plugins/${Plugin}
               rm -rf ${path}/plugins/${Plugin} &>/dev/null
             if [ -d ${path}/plugins/${Plugin} ]
             then
               echo;echo -en "\033[32m 删除失败 回车返回\033[0m";read -p ""
             else
               echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
             fi
           fi
       else
       clear
       echo
       echo
       echo -e ${green}建议到插件地址查看使用方法'\n'${blue}${Git}${background}
       echo
       sleep 2s
       echo "=================================="
       echo 正在安装${Name}，稍安勿躁～
       echo "=================================="
       echo
       git clone --depth=1 ${Git} ./plugins/${Plugin}
          if [ -d ${path}/plugins/${Plugin} ]
            then
              echo -e "\033[36m正在处理依赖\033[0m"
              pnpm install --filter=py-plugin
              echo -en ${green}${Name}是否使用用py远程服务器 ${blue}使用[y]不使用[n] 默认为n:${background};read -p "" num
           case $num in
             y)
               cp ${path}/plugins/py-plugin/config_default.yaml ${path}/plugins/py-plugin/config.yaml
               sed -i "s/host: 127.0.0.1/host: 159.75.113.47/g" ${path}/plugins/py-plugin/config.yaml
               echo;echo -en "\033[36m已切换为远程服务器\033[0m"
               ;;
             n)
               cd ${path}/plugins/py-plugin
               pip_mirrors
               cd ../../
               ;;
             *)
               echo -e "\033[31m请正确输入\033[0m"
               exit
               ;;
             esac
              echo;echo -en "\033[32m安装完成 回车返回\033[0m";read -p ""
          else
              echo;echo -en "\033[31m安装失败 回车返回\033[0m";read -p ""
          fi
       fi
     else
     echo -e "\033[31m 非Linux系统 本脚本无法安装py插件 \033[0m"
     exit 
     fi
     ;;
   12)
     Name=闲心插件
     Plugin=xianxin-plugin
     Git=https://gitee.com/xianxincoder/xianxin-plugin.git
     whiptail_install_plugins
     ;;
   13)
     Name=麟插件
     Plugin=lin-plugin
     Git=https://gitee.com/go-farther-and-farther/lin-plugin.git
     whiptail_install_plugins
     ;;
   14)
     Name=L插件
     Plugin=l-plugin
     ghproxy_agency
     Git=${ghproxy}https://github.com/liuly0322/l-plugin.git
     whiptail_install_plugins
     ;;
   15)
     Name=千羽插件
     Plugin=qianyu-plugin
     Git=https://gitee.com/think-first-sxs/qianyu-plugin.git
     whiptail_install_plugins
     ;;
   16)
     Name=清凉图插件
     Plugin=yunzai-c-v-plugin
     Git=https://gitee.com/xwy231321/yunzai-c-v-plugin.git
     whiptail_install_plugins
     ;;
   17)
     Name=抽卡插件
     Plugin=flower-plugin
     Git=https://gitee.com/Nwflower/flower-plugin.git
     whiptail_install_plugins
     ;;
   18)
     Name=自动化插件
     Plugin=auto-plugin
     Git=https://gitee.com/Nwflower/auto-plugin.git
     whiptail_install_plugins
     ;;
   19)
     Name=娱乐插件
     Plugin=recreation-plugin
     Git=https://gitee.com/zzyAJohn/recreation-plugin
     whiptail_install_plugins
     ;;
   20)
     Name=碎月插件
     Plugin=suiyue
     Git=https://gitee.com/Acceleratorsky/suiyue.git
     whiptail_install_plugins
     ;;
   21)
     Name=风歌插件
     Plugin=windoge-plugin
     ghproxy_agency
     Git=${ghproxy}https://github.com/gxy12345/windoge-plugin
     whiptail_install_plugins
     ;;
   22)
     Name=Atlas[图鉴]
     Plugin=Atlas
     Git=https://gitee.com/Nwflower/atlas
     whiptail_install_plugins
     ;;
   23)
     Name=止水插件
     Plugin=zhishui-plugin
     Git=https://gitee.com/fjcq/zhishui-plugin.git
     whiptail_install_plugins
     ;;
   24)
     Name=trss插件
     Plugin=TRSS-Plugin
     Git=https://gitee.com/TimeRainStarSky/TRSS-Plugin.git
     whiptail_install_plugins
     ;;
   25)
     Name=脆脆鲨插件
     Plugin=Jinmaocuicuisha-plugin
     Git=https://gitee.com/JMCCS/jinmaocuicuisha.git
     whiptail_install_plugins
     ;;
   26)
     Name=半柠檬插件
     Plugin=alemon-plugin
     Git=https://gitee.com/ningmengchongshui/alemon-plugin.git
     whiptail_install_plugins
     ;;
   27)
     Name=榴莲插件
     Plugin=liulian-plugin
     Git=https://gitee.com/huifeidemangguomao/liulian-plugin.git
     whiptail_install_plugins
     ;;
   28)
     Name=小叶插件
     Plugin=xiaoye-plugin
     Git=https://gitee.com/xiaoye12123/xiaoye-plugin.git
     whiptail_install_plugins
     ;;
   29)
     Name=R插件
     Plugin=rconsole-plugin
     Git=https://gitee.com/kyrzy0416/rconsole-plugin.git
     whiptail_install_plugins
     ;;
   30)
     Name=扩展插件
     Plugin=expand-plugin
     Git=https://gitee.com/SmallK111407/expand-plugin.git
     whiptail_install_plugins
     ;;
   31)
     Name=小雪插件
     Plugin=XiaoXuePlugin
     Git=https://gitee.com/XueWerY/XiaoXuePlugin.git
     whiptail_install_plugins
     ;;
   32)
     Name=冰祈插件
     Plugin=Icepray
     Git=https://gitee.com/koinori/Icepray.git
     whiptail_install_plugins
     ;;
   33)
     Name=绝云间修仙
     Plugin=xiuxian-emulator
     Git=https://gitee.com/hutao222/DDZS-XIUXIAN-V1.2.4/.git
     whiptail_install_plugins
     ;;
   34)
     Name=光遇插件
     Plugin=Tlon-Sky
     Git=https://gitee.com/Tloml-Starry/Tlon-Sky.git
     whiptail_install_plugins
     ;;
   35)
     Name=枫叶插件
     Plugin=hs-qiqi-plugin
     Git=https://gitee.com/kesally/hs-qiqi-cv-plugin.git
     whiptail_install_plugins
     ;;
   36)
     Name=七圣召唤插件
     Plugin=call_of_seven_saints
     Git=https://gitee.com/huangshx2001/call_of_seven_saints.git
     whiptail_install_plugins
     ;;
   37)
     Name=QQ频道插件
     Plugin=QQGuild-Plugin
     ghproxy_agency
     Git=${ghproxy}https://github.com/2y8e9h22/QQGuild-Plugin
     whiptail_install_plugins
     ;;
   0)
     echo
     baihu_whiptail
     ;;
 esac
}
function main()
{
    while true
    do
        baihu_whiptail
        main
    done
}
main
}
function Other_Linux(){
if [ -d plugins ]
then
path="."
else
echo -e "\033[31m 未在此目录下找到Yunzai-Bot的插件文件夹\033[0m"
echo -e "\033[31m 请进入Yunzai-Bot根目录之后 使用本脚本\033[0m"
exit
fi
function baibu()
{
green="\033[32m"
blue="\033[36m"
background="\033[0m"
white="\033[37m"
echo 
echo
echo -e ${white}"#####"${green}白狐-Yunzai-Bot${white}"#####"${background}
echo -e ${green}1.  ${blue}安装git插件${background}
echo -e ${green}2.  ${blue}安装js插件${background}
echo -e ${green}3.  ${blue}更新git插件${background}
echo -e ${green}4.  ${blue}删除git插件${background}
echo -e ${green}5.  ${blue}删除js插件${background}
echo -e ${green}6.  ${blue}修复py依赖和端口报错${background}
echo -e ${green}7.  ${blue}py切换远程与远程${background}
echo -e ${green}8.  ${blue}修改锅巴端口${background}
echo 
echo -e ${green}0.  ${blue}退出${background}
echo "#########################"
echo -e ${green}QQ群:${blue}狐狸窝:705226976${background}
echo "#########################"
echo
echo -en ${green}请输入您的选项: ${background};read number
case ${number} in
    1)
      Other_Linux_pulgins
      ;;
    2)
      Linux_js_install
      ;;
    3)
      echo
      echo -e "\033[33m正在更新Yunzai\033[0m"
      cd ${path}
      git pull
      cd ../
      echo -e "\033[33mYunzai更新完成\033[0m"
      for file in $(ls -I example -I bin -I other -I system -I genshin ${path}/plugins)
      do
        if [ -d ${path}/plugins/${file} ];then
          echo
          echo -e "\033[33m正在更新${file}\033[0m"
          cd ${path}/plugins/${file}
          git pull
          cd ../../
          echo -e "\033[33m${file}更新完成\033[0m"
        fi
      done
      echo;echo -en "\033[32m全部更新完成 回车返回\033[0m";read -p ""
      ;;
    4)
      Linux_git_file_management
      ;;
    5)
      Linux_js_file_management
      ;;
    6)
     if [ -d "plugins/py-plugin" ]
       then
         cd plugins/py-plugin
         pip_mirrors
         poetry install 
         poetry install
         function py_(){
         min=$1
         max=$(($2-$min+1))
         num=$(date +%s%N)
         echo $(($num%$max+$min))
         }
         pyport=$(py_ 40000 60000)
         if [ -e "${path}plugins/py-plugin/config.yaml" ]
            then
               sed -i "15s/.*/port: ${pyport}/g" ${path}/plugins/py-plugin/config.yaml
               echo;echo -en "\033[36m 执行完成 回车返回\033[0m";read
            else
               cp ${path}/plugins/py-plugin/config_default.yaml ${path}/plugins/py-plugin/config.yaml
               sed -i "15s/.*/port: ${pyport}/g" ${path}/plugins/py-plugin/config.yaml
               echo;echo -en "\033[36m 执行完成 回车返回\033[0m";read
         fi
         cd ../../
       else
         echo -e "\033[33m 未安装py插件 回车返回 \033[0m";read
     fi
     ;;
    7)
     if [ -d "plugins/py-plugin" ]
     then
       if [ -e "${path}/plugins/py-plugin/config.yaml" ]
          then
            if grep -q "host: 159.75.113.47" ${path}/plugins/py-plugin/config.yaml
              then
                sed -i "s/host: 159.75.113.47/host: 127.0.0.1/g" ${path}/plugins/py-plugin/config.yaml
                echo;echo -en "\033[36m 已切换为本地服务器 请安装/更新依赖 回车继续\033[0m";read
                sleep 2s
                echo
                cd plugins/py-plugin
                pip_mirrors
                cd ../../
                echo;echo -en "\033[36m 执行完成 回车返回\033[0m";read
              else
                sed -i "s/host: 127.0.0.1/host: 159.75.113.47/g" ${path}/plugins/py-plugin/config.yaml
                echo;echo -en "\033[36m 已切换为远程服务器 回车返回\033[0m";read -p ""
            fi
          else
            if grep -q "host: 159.75.113.47" ${path}/plugins/py-plugin/config.yaml
              then
                cp ${path}/plugins/py-plugin/config_default.yaml ${path}/plugins/py-plugin/config.yaml
                sed -i "s/host: 159.75.113.47/host: 127.0.0.1/g" ${path}/plugins/py-plugin/config.yaml
                echo;echo -en "\033[36m 已切换为本地服务器 请安装/更新依赖 回车继续\033[0m";read
                sleep 2s
                echo
                cd plugins/py-plugin
                pip_mirrors
                cd ../../
                echo;echo -en "\033[36m 执行完成 回车返回\033[0m";read
              else
                cp ${path}/plugins/py-plugin/config_default.yaml ${path}/plugins/py-plugin/config.yaml
                sed -i "s/host: 127.0.0.1/host: 159.75.113.47/g" ${path}/plugins/py-plugin/config.yaml
                echo;echo -en "\033[36m 已切换为远程服务器 回车返回\033[0m";read -p ""
            fi
       fi
     else
         echo -e "\033[33m 未安装py插件 回车返回 \033[0m";read
     fi
     ;;
    8)
     if [ -e "plugins/Guoba-Plugin/config/application.yaml" ]
       then
         echo -en "\033[32m 请输入更改之后的端口号[] \033[0m"; read -p "" gbport
           if [[ "${gbport}" =~ ^[0-9]+$ ]]; then
             sed -i "s/.*port.*/  port: ${gbport}/g" plugins/Guoba-Plugin/config/application.yaml
	         echo;echo -en "\033[36m 更改完成 回车返回\033[0m";read
	       fi
       else
         echo -e "\033[31m 文件不存在,请确认是否安装锅巴并启动过一次 \033[0m";
         exit
     fi
     ;;
    0)
      exit
      ;;
  esac
}
#插件:Plugin 插件git链接:Git 插件名字:Name
function install_plugins(){
green="\033[32m"
blue="\033[36m"
background="\033[0m"
if [ -d plugins/${Plugin} ]
  then
    echo -e ${green}${Name}已经安装 是否删除 ${blue}删除[y]取消[n]:${background}
        read -p "" num
     case $num in
       y)
         rm -rf plugins/${Plugin}
         rm -rf plugins/${Plugin} &>/dev/null
         if [ -d plugins/${Plugin} ]
           then
             echo;echo -en "\033[32m 删除失败 回车返回\033[0m";read -p ""
           else
             echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
         fi
         ;;
       n)
         echo -e "\033[36m 取消\033[0m"
         sleep 2s
         ;;
       *)
         echo -e "\033[31m请正确输入 \033[36m回车返回\033[0m" read -p ""
         ;;
     esac
  else
    echo -e ${green}建议到插件地址查看使用方法'\n'${blue}${Git}${background}
    sleep 2s
    echo "=================================="
    echo 正在安装${Name}，稍安勿躁～
    echo "=================================="
    git clone --depth=1 ${Git} ./plugins/${Plugin}
    if [ -d plugins/${Plugin} ]
    then
      echo -e "\033[36m正在处理依赖\033[0m"
      cd plugins/${Plugin}
      pnpm install -P
      cd ../../ 
      echo;echo -en "\033[32m安装完成 回车返回\033[0m";read -p ""
    else
      echo;echo -en "\033[31m安装失败 回车返回\033[0m";read -p ""
    fi
fi
}
function ghproxy_agency_Other_Linux(){
green="\033[32m"
blue="\033[36m"
background="\033[0m"
echo -e ${green}${Name}该项目库位于github 是否启用ghproxy镜像站 ${blue}启用[y]取消[n]:${background}
read -p "" num
        case $num in
     y)
       ghproxy="https://ghproxy.com/"
       ;;
     n)
       ghproxy=" "
       ;;
     *)
       echo -e "\033[31m请正确输入 \033[36m回车返回\033[0m";read -p ""
       ;;
  esac
}
function Other_Linux_pulgins()
{
green="\033[32m"
blue="\033[36m"
background="\033[0m"
white="\033[37m"
echo
echo
echo -e ${white}"#######"${green}白狐-Yunzai-Bot-Plug-In${white}"#######"${background}
echo -e ${green}1.  ${blue}miao-plugin"               "喵喵插件${background}
echo -e ${green}2.  ${blue}xiaoyao-cvs-plugin"        "逍遥图鉴${background}
echo -e ${green}3.  ${blue}Guoba-Plugin"              "锅巴插件${background}
echo -e ${green}4.  ${blue}zhi-plugin"                "白纸插件${background}
echo -e ${green}5.  ${blue}xitian-plugin"             "戏天插件${background}
echo -e ${green}6.  ${blue}Akasha-Terminal-plugin"    "虚空插件${background}
echo -e ${green}7.  ${blue}Xiuxian-Plugin-Box"        "修仙插件${background}
echo -e ${green}8.  ${blue}Yenai-Plugin"              "椰奶插件${background}
echo -e ${green}9.  ${blue}xiaofei-plugin"            "小飞插件${background}
echo -e ${green}10. ${blue}earth-k-plugin"           "土块插件${background}
echo -e ${green}11. ${blue}py-plugin"                "py插件${background}
echo -e ${green}12. ${blue}xianxin-plugin"           "闲心插件${background}
echo -e ${green}13. ${blue}lin-plugin"               "麟插件${background}
echo -e ${green}14. ${blue}l-plugin"                 "L插件${background}
echo -e ${green}15. ${blue}qianyu-plugin"            "千羽插件${background}
echo -e ${green}16. ${blue}yunzai-c-v-plugin"        "清凉图插件${background}
echo -e ${green}17. ${blue}flower-plugin"            "抽卡插件${background}
echo -e ${green}18. ${blue}auto-plugin"              "自动化插件${background}
echo -e ${green}19. ${blue}recreation-plugin"        "娱乐插件${background}
echo -e ${green}20. ${blue}suiyue-plugin"            "碎月插件${background}
echo -e ${green}21. ${blue}windoge-plugin"           "风歌插件${background}
echo -e ${green}22. ${blue}Atlas"                    "原神图鉴${background}
echo -e ${green}23. ${blue}zhishui-plugin"           "止水插件${background}
echo -e ${green}24. ${blue}TRSS-Plugin"              "trss插件${background}
echo -e ${green}25. ${blue}Jinmaocuicuisha"          "脆脆鲨插件${background}
echo -e ${green}26. ${blue}alemon-plugin"            "半柠檬插件${background}
echo -e ${green}27. ${blue}liulian-plugin"           "榴莲插件${background}
echo -e ${green}28. ${blue}xiaoye-plugin"            "小叶插件${background}
echo -e ${green}29. ${blue}rconsole-plugin"          "R插件${background}
echo -e ${green}30. ${blue}expand-plugin"            "扩展插件${background}
echo -e ${green}31. ${blue}XiaoXuePlugin"            "小雪插件${background}
echo -e ${green}32. ${blue}Icepray"                  "冰祈插件${background}
echo -e ${green}33. ${blue}xiuxian-emulator-plugin"  "绝云间修仙${background}
echo -e ${green}34. ${blue}Tlon-Sky"                 "光遇插件${background}
echo -e ${green}35. ${blue}hs-qiqi-plugin"           "枫叶插件${background}
echo -e ${green}36. ${blue}call_of_seven_saints"     "七圣召唤插件${background}
echo -e ${green}37. ${blue}QQGuild-Plugin"           "QQ频道插件${background}
echo 
echo -e ${green}0. ${blue}返回${background}
echo "#####################################"
echo;echo -en "\033[32m请输入您需要安装插件的序号:\033[0m";read -p "" number
 case $number in
   1)
     Name=喵喵插件 #插件中文名字
     Plugin=miao-plugin #插件名
     Git=https://gitee.com/yoimiya-kokomi/miao-plugin.git #仓库链接
     install_plugins #调用安装
     ;;
   2)
     Name=逍遥图鉴
     Plugin=xiaoyao-cvs-plugin
     Git=https://gitee.com/Ctrlcvs/xiaoyao-cvs-plugin.git
     install_plugins
     ;;
   3)
     Name=锅巴插件
     Plugin=Guoba-Plugin
     Git=https://gitee.com/guoba-yunzai/guoba-plugin.git
     install_plugins
     ;;
   4)
     Name=白纸插件
     Plugin=zhi-plugin
     Git=https://gitee.com/headmastertan/zhi-plugin.git
     install_plugins
     ;;
   5)
     Name=戏天插件
     Plugin=xitian-plugin
     Git=https://gitee.com/XiTianGame/xitian-plugin.git
     install_plugins
     ;;
   6)
     Name=虚空插件
     Plugin=akasha-terminal-plugin
     Git=https://gitee.com/go-farther-and-farther/akasha-terminal-plugin.git
     install_plugins
     ;;
   7)
     Name=修仙插件
     Plugin=xiuxian-plugin
     Git=https://gitee.com/ningmengchongshui/Xiuxian-Plugin-Box.git
     install_plugins
     ;;
   8)
     Name=椰奶插件
     Plugin=yenai-plugin
     Git=https://gitee.com/yeyang52/yenai-plugin.git
     install_plugins
     ;;
   9)
     Name=小飞插件
     Plugin=xiaofei-plugin
     Git=https://gitee.com/xfdown/xiaofei-plugin.git
     install_plugins
     ;;
   10)
     Name=土块插件
     Plugin=earth-k-plugin
     Git=https://gitee.com/SmallK111407/earth-k-plugin.git
     install_plugins
     ;;
   11)
     if [ "$(uname)" == "Linux" ]
     then
       if ! [ -x "$(command -v poetry)" ]
         then
           echo -en "\033[31m 你还没有安装poetry呢 回车退出 \033[0m";read -p ""
           exit
       fi
       Name=py插件
       Plugin=py-plugin
       Git=https://gitee.com/realhuhu/py-plugin.git
       green="\033[32m"
       blue="\033[36m"
       background="\033[0m"
       if [ -d plugins/${Plugin} ]
         then
           clear
           echo -e ${green}${Name}已经安装 是否删除 ${blue}删除[y]取消[n]:${background}
           read -p "" num
           case $num in
             y)
               rm -rf plugins/${Plugin}
               rm -rf plugins/${Plugin} &>/dev/null
               if [ -d plugins/${Plugin} ]
                 then
                  echo;echo -en "\033[32m 删除失败 回车返回\033[0m";read -p ""
                 else
                  echo;echo -en "\033[32m 删除完成 回车返回\033[0m";read -p ""
               fi
               ;;
             n)
               echo -e "\033[3m请正确输入 \033[36m回车返回\033[0m";read -p ""
               ;;
             *)
               echo -e "\033[31m请正确输入 \033[36m回车返回\033[0m"; read -p ""
             ;;
           esac
       else
       clear
       echo
       echo
       echo -e ${green}建议到插件地址查看使用方法'\n'${blue}${Git}${background}
       echo
       sleep 2s
       echo "=================================="
       echo 正在安装${Name}，稍安勿躁～
       echo "=================================="
       echo
       git clone --depth=1 ${Git} ./plugins/${Plugin}
          if [ -d ${path}/plugins/${Plugin} ]
            then
              echo -e "\033[36m正在处理依赖\033[0m"
              cd plugins/${Plugin}
              pnpm install --filter=py-plugin
              echo -en ${green}${Name}是否使用用py远程服务器 ${blue}使用[y]不使用[n] 默认为n:${background}
           read -p "" num
           case $num in
             y)
               cp ${path}/plugins/py-plugin/config_default.yaml ${path}/plugins/py-plugin/config.yaml
               sed -i "s/host: 127.0.0.1/host: 159.75.113.47/g" ${path}/plugins/py-plugin/config.yaml
               echo;echo -en "\033[36m已切换为远程服务器\033[0m"
               ;;
             n)
               cd ${path}/plugins/py-plugin
               pip_mirrors
               cd ../../
               ;;
             *)
               echo -e "\033[31m请正确输入\033[0m"
               exit
               ;;
             esac
              echo;echo -en "\033[32m安装完成 回车返回\033[0m";read -p ""
          else
              echo;echo -en "\033[31m安装失败 回车返回\033[0m";read -p ""
          fi
       fi
     else
     echo -e "\033[31m 非Linux系统 本脚本无法安装py插件 \033[0m"
     exit 0
     fi
     ;;
   12)
     Name=闲心插件
     Plugin=xianxin-plugin
     Git=https://gitee.com/xianxincoder/xianxin-plugin.git
     install_plugins
     ;;
   13)
     Name=麟插件
     Plugin=lin-plugin
     Git=https://gitee.com/go-farther-and-farther/lin-plugin.git
     install_plugins
     ;;
   14)
     Name=L插件
     Plugin=l-plugin
     ghproxy_agency_Other_Linux
     Git=${ghproxy}https://github.com/liuly0322/l-plugin.git
     install_plugins
     ;;
   15)
     Name=千羽插件
     Plugin=qianyu-plugin
     Git=https://gitee.com/think-first-sxs/qianyu-plugin.git
     install_plugins
     ;;
   16)
     Name=清凉图插件
     Plugin=yunzai-c-v-plugin
     Git=https://gitee.com/xwy231321/yunzai-c-v-plugin.git
     install_plugins
     ;;
   17)
     Name=抽卡插件
     Plugin=flower-plugin
     Git=https://gitee.com/Nwflower/flower-plugin.git
     install_plugins
     ;;
   18)
     Name=自动化插件
     Plugin=auto-plugin
     Git=https://gitee.com/Nwflower/auto-plugin.git
     install_plugins
     ;;
   19)
     Name=娱乐插件
     Plugin=recreation-plugin
     Git=https://gitee.com/zzyAJohn/recreation-plugin
     install_plugins
     ;;
   20)
     Name=碎月插件
     Plugin=suiyue
     Git=https://gitee.com/Acceleratorsky/suiyue.git
     install_plugins
     ;;
   21)
     Name=风歌插件
     Plugin=windoge-plugin
     ghproxy_agency_Other_Linux
     Git=${ghproxy}https://github.com/gxy12345/windoge-plugin
     install_plugins
     ;;
   22)
     Name=Atlas[图鉴]
     Plugin=Atlas
     Git=https://gitee.com/Nwflower/atlas
     install_plugins
     ;;
   23)
     Name=止水插件
     Plugin=zhishui-plugin
     Git=https://gitee.com/fjcq/zhishui-plugin.git
     install_plugins
     ;;
   24)
     Name=trss插件
     Plugin=TRSS-Plugin
     Git=https://gitee.com/TimeRainStarSky/TRSS-Plugin.git
     install_plugins
     ;;
   25)
     Name=脆脆鲨插件
     Plugin=Jinmaocuicuisha-plugin
     Git=https://gitee.com/JMCCS/jinmaocuicuisha.git
     install_plugins
     ;;
   26)
     Name=半柠檬插件
     Plugin=alemon-plugin
     Git=https://gitee.com/ningmengchongshui/alemon-plugin.git
     install_plugins
     ;;
   27)
     Name=榴莲插件
     Plugin=liulian-plugin
     Git=https://gitee.com/huifeidemangguomao/liulian-plugin.git
     install_plugins
     ;;
   28)
     Name=小叶插件
     Plugin=xiaoye-plugin
     Git=https://gitee.com/xiaoye12123/xiaoye-plugin.git
     install_plugins
     ;;
   29)
     Name=R插件
     Plugin=rconsole-plugin
     Git=https://gitee.com/kyrzy0416/rconsole-plugin.git
     install_plugins
     ;;
   30)
     Name=扩展插件
     Plugin=expand-plugin
     Git=https://gitee.com/SmallK111407/expand-plugin.git
     install_plugins
     ;;
   31)
     Name=小雪插件
     Plugin=XiaoXuePlugin
     Git=https://gitee.com/XueWerY/XiaoXuePlugin.git
     install_plugins
     ;;
   32)
     Name=冰祈插件
     Plugin=Icepray
     Git=https://gitee.com/koinori/Icepray.git
     install_plugins
     ;;
   33)
     Name=绝云间修仙
     Plugin=xiuxian-emulator
     Git=https://gitee.com/hutao222/DDZS-XIUXIAN-V1.2.4/.git
     install_plugins
     ;;
   34)
     Name=光遇插件
     Plugin=Tlon-Sky
     Git=https://gitee.com/Tloml-Starry/Tlon-Sky.git
     install_plugins
     ;;
   35)
     Name=枫叶插件
     Plugin=hs-qiqi-plugin
     Git=https://gitee.com/kesally/hs-qiqi-cv-plugin.git
     install_plugins
     ;;
   36)
     Name=七圣召唤插件
     Plugin=call_of_seven_saints
     Git=https://gitee.com/huangshx2001/call_of_seven_saints.git
     install_plugins
     ;;
   37)
     Name=QQ频道插件
     Plugin=QQGuild-Plugin
     ghproxy_agency_Other_Linux
     Git=${ghproxy}https://github.com/2y8e9h22/QQGuild-Plugin
     install_plugins
     ;;
   esac
}
function mainbak()
{
    while true
    do
        baibu
        mainbak
    done
}
mainbak
}
function debian(){
if ! [ -x "$(command -v whiptail)" ];then
    echo -e "\033[36m检测到未安装whiptail 开始安装 \033[0m";
    apt update -y
    apt install whiptail -y
fi
if ! [ -x "$(command -v git)" ];then
    echo -e "\033[36m检测到未安装git 开始安装 \033[0m";
    apt update -y
    apt install git -y
fi
if ! [ -x "$(command -v curl)" ];then
    echo -e "\033[36m检测到未安装curl 开始安装 \033[0m";
    apt update -y
    apt install curl -y
fi
}
function ubuntu(){
if ! [ -x "$(command -v whiptail)" ];then
    echo -e "\033[36m检测到未安装whiptail 开始安装 \033[0m";
    apt update -y
    apt install whiptail -y
fi
if ! [ -x "$(command -v git)" ];then
    echo -e "\033[36m检测到未安装git 开始安装 \033[0m";
    apt update -y
    apt install git -y
fi
if ! [ -x "$(command -v curl)" ];then
    echo -e "\033[36m检测到未安装curl 开始安装 \033[0m";
    apt update -y
    apt install curl -y
fi
}
function centos(){
if ! [ -x "$(command -v whiptail)" ];then
    echo -e "\033[36m检测到未安装whiptail 开始安装 \033[0m";
    yum update -y
    yum install whiptail -y
fi
if ! [ -x "$(command -v git)" ];then
    echo -e "\033[36m检测到未安装git 开始安装 \033[0m";
    yum update -y
    yum install git -y
fi
if ! [ -x "$(command -v curl)" ];then
    echo -e "\033[36m检测到未安装curl 开始安装 \033[0m";
    yum update -y
    yum install curl -y
fi
}
function archlinux(){
if ! [ -x "$(command -v whiptail)" ];then
    echo -e "\033[36m检测到未安装whiptail 开始安装 \033[0m";
    pacman -Syu -y
    pacman -S whiptail -y
fi
if ! [ -x "$(command -v git)" ];then
    echo -e "\033[36m检测到未安装git 开始安装 \033[0m";
    pacman -Syu -y
    pacman -S git -y
fi
if ! [ -x "$(command -v curl)" ];then
    echo -e "\033[36m检测到未安装curl 开始安装 \033[0m";
    pacman -Syu -y 
    pacman -S curl -y
fi
}
if [[ -f /etc/redhat-release ]]; then
    centos
    Linux
elif grep -q -E -i "debian" /etc/issue &>/dev/null; then
    debian
    Linux
elif grep -q -E -i "ubuntu" /etc/issue &>/dev/null; then
    ubuntu
    Linux
elif grep -q -E -i "Alpine" /etc/issue &>/dev/null; then
    Alpine
    Linux
elif grep -q -E -i "centos|red hat|redhat" /etc/issue &>/dev/null; then
    centos
    Linux
elif grep -q -E -i "Arch|Manjaro" /etc/issue &>/dev/null; then
    archlinux
    Linux
elif grep -q -E -i "debian" /proc/version &>/dev/null; then
    debian
    Linux
elif grep -q -E -i "ubuntu" /proc/version &>/dev/null; then
    ubuntu
    Linux
elif grep -q -E -i "centos|red hat|redhat" /proc/version &>/dev/null; then
    centos
    Linux
else
    Other_Linux
fi