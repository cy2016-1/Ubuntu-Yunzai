#!/bin/env bash
function delete_js(){
if [ -e js.log ];then
rm js.log
fi
clear
a=0
echo
echo "#######################"
for file in $(ls plugins/example)
do
a=$(($a+1))
echo -e ${green}${a}". "${cyan}${file}${background}
done
echo
echo -e ${green}0.${cyan}返回${background}
echo "#######################"
a=0
echo -en ${cyan}请输入您要删除的插件序号${background};read Number
if [ "${Number}" = 0 ];then
mian
else
if [[ "${Number}" =~ ^[0-9]+$ ]]; then
  ls plugins/example > js.log
  content=`sed -n "${Number}p" js.log`
  if [ "plugins/example/${content}" = "plugins/example/" ]
    then
      echo;echo -en ${red}输入错误${background}
      exit
  fi
  rm -rf plugins/example/${content}
  rm -rf plugins/example/${content} &>/dev/null
  if [ -e plugins/example/${content} ]
    then
      echo;echo -en ${red}删除失败 回车返回${background};read
    else
      echo;echo -en ${green}删除完成 回车返回${background};read
  fi
else
  echo;echo -en ${red}输入错误 回车返回${background};read
fi # if [[ "${Number}" =~ ^[0-9]+$ ]]; then
fi # if [ "${Number}" = 0 ];then
if [ -e js.log ];then
rm js.log
fi
} #delete_js
#########################################################
function delete_git(){
if [ -e js.log ];then
rm js.log
fi
clear
a=0
echo
echo "#######################"
for file in $(ls -I example -I bin -I other -I system plugins)
do
a=$(($a+1))
echo -e ${green}${a}". "${cyan}${file}${background}
done
echo
echo -e ${green}0.${cyan}返回${background}
echo "#######################"
a=0
echo -en ${cyan}请输入您要删除的插件序号${background};read Number
if [ "${Number}" = 0 ];then
mian
else
if [[ "${Number}" =~ ^[0-9]+$ ]]; then
  ls -I example -I bin -I other -I system plugins > git.log
  content=`sed -n "${Number}p" git.log`
  if [ "plugins/${content}" == "plugins/" ] && [ "plugins/${content}" == "plugins/genshin" ]
    then
      echo;echo -en ${red}输入错误${background}
      exit
  fi
  rm -rf plugins/${content}
  rm -rf plugins/${content} &>/dev/null
  if [ -d plugins/${content} ]
    then
      echo;echo -en ${red}删除失败 回车返回${background};read
    else
      echo;echo -en ${green}删除完成 回车返回${background};read
  fi
else
  echo;echo -en ${red}输入错误 回车返回${background};read
fi # if [[ "${Number}" =~ ^[0-9]+$ ]]; then
fi # if [ "${Number}" = 0 ];then
if [ -e js.log ];then
rm js.log
fi
} #delete_git
#########################################################
function js_plugin(){
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
          echo;echo -e "\033[31m输入错误\033[0m"
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
        cp ${sdpath}/${content} plugins/example/
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
#########################################################
function git_pull_plugins(){
clear
echo
echo -e ${yellow}正在更新${background}
cd ${path}
function git_pull(){
 if ! git pull;then
   echo
     echo -en ${red} 更新失败 ${cyan} 是否${retry}强制更新${yellow} [Y/n]${background};read yn
     case $yn in
       Y|y)
         git fetch --all
         git reset --hard origin/master
         git_pull
         retry="重新尝试"
         ;;
       n|N)
         echo
         echo -e ${blue}跳过${background}
         sleep 0.8s
         ;;
      esac
 fi
} #git_pull
for file in $(ls -I example -I bin -I other -I system -I genshin plugins)
do
  if [ -d plugins/${file} ];then
   echo
   echo -e ${yellow}正在更新${file}${background}
   cd plugins/${file}
   function git_pull(){
   if ! git pull;then
   echo
   echo -en ${red}${file} 更新失败 ${cyan} 是否${retry}强制更新${yellow} [Y/n]${background};read yn
   case $yn in
   Y|y)
     git fetch --all
     git reset --hard origin/master
     git_pull
     retry="重新尝试"
     git_pull
     ;;
   n|N)
     echo
     echo -e ${blue}跳过${background}
     sleep 0.5s
     ;;
   esac
    fi
    } #git_pull
    git_pull
    cd ../../
  fi
done
echo
echo -en ${blue}执行完成${green} 回车返回${background};read
}
#########################################################
function py_server(){
function server_host(){
  sed -i "s/host: 127.0.0.1/host: 159.75.113.47/g" plugins/py-plugin/config.yaml
  pyport=(grep port plugins/py-plugin/config.yaml)
  sed -i "s/${pyport}/port: 50053/g" plugins/py-plugin/config.yaml
  echo;echo -en ${cyan}已切换为远程服务器 ${green}回车返回${background};read
} #server_host
function local_host(){
  sed -i "s/host: 159.75.113.47/host: 127.0.0.1/g" plugins/py-plugin/config.yaml
  sed -i "s/port: 50053/port: 50052/g" plugins/py-plugin/config.yaml
  echo;echo -en ${cyan}已切换为本地服务器 ${yellow}请安装/更新依赖 ${green}回车继续${background};read
  echo
  cd plugins/py-plugin
  pip_mirrors
  cd ../../
  echo;echo -en ${cyan}执行完成 ${green}回车返回${background};read
} #local_host
if [ -d "plugins/py-plugin" ]
then
  if [ -e "plugins/py-plugin/config.yaml" ]
    then
      if grep -q "host: 159.75.113.47" plugins/py-plugin/config.yaml
        then
          local_host
        else
          server_host
      fi
    else
      if grep -q "host: 159.75.113.47" plugins/py-plugin/config_default.yaml
        then
          cp plugins/py-plugin/config_default.yaml plugins/py-plugin/config.yaml
          local_host
        else
          cp plugins/py-plugin/config_default.yaml plugins/py-plugin/config.yaml
          server_host
      fi
  fi
else
    echo -en ${red}未安装py插件 ${green}回车返回${background};read
fi
} #py_server
#########################################################
function plugin_set(){
function dialog_whiptail_page(){
clear
number=$(${dialog_whiptail} \
--title "白狐" \
--menu "白狐的QQ群:705226976" \
20 40 10 \
"1" "设置锅巴端口" \
"2" "设置py端口" \
"0" "退出" \
3>&1 1>&2 2>&3)
feedback=$?
if [ ! ${feedback} = 0 ];then
exit
fi
clear
}  #dialog_whiptail_page
function echo_page(){
clear
echo
echo
echo -e ${white}"#####"${green}白狐${white}"#####"${background}
echo -e ${green}1.  ${cyan}设置锅巴端口${background}
echo -e ${green}2.  ${cyan}设置锅巴域名${background}
echo -e ${green}3.  ${cyan}设置py端口${background}
echo
echo -e ${green}0.  ${cyan}退出${background}
echo "#########################"
echo -e ${green}QQ群:${cyan}狐狸窝:705226976${background}
echo "#########################"
echo
echo -en ${green}请输入您的选项: ${background};read number
}  #echo_page
choose_page
case $number in
  1)
    cd ${path}
    if [ -d plugins/Guoba-Plugin ];then
      if [ -e plugins/Guoba-Plugin/config/application.yaml ]; then
          echo -e ${cyan}请输入您更改之后的端口${background};read number
          port=`grep port plugins/Guoba-Plugin/config/application.yaml`
          sed -i "s/${port}/  port: ${number}/g" plugins/Guoba-Plugin/config/application.yaml
          echo -en ${blue}执行完成${green} 回车返回${background};read  
        else
          mkdir -p plugins/Guoba-Plugin/config/
          cp -f plugins/Guoba-Plugin/defSet/application.yaml plugins/Guoba-Plugin/config/application.yaml
          echo -e ${cyan}请输入您更改之后的端口${background};read number
          port=`grep port plugins/Guoba-Plugin/config/application.yaml`
          sed -i "s/${port}/  port: ${number}/g" plugins/Guoba-Plugin/config/application.yaml
          echo -en ${blue}执行完成${green} 回车返回${background};read
      fi
      else 
        echo -e ${red}错误 请确认锅巴已安装${background}
    fi
    cd ${path}
    ;;
  2)
    cd ${path}
    if [ -d plugins/Guoba-Plugin ];then
      if [ -e plugins/Guoba-Plugin/config/application.yaml ]; then
          echo -e ${cyan}请输入您更改之后的域名${background};read url
          host=`grep host plugins/Guoba-Plugin/config/application.yaml`
          sed -i "s/${host}/  host: ${url}/g" plugins/Guoba-Plugin/config/application.yaml
          echo -en ${blue}执行完成${green} 回车返回${background};read
        else
          mkdir -p plugins/Guoba-Plugin/config/
          cp -f plugins/Guoba-Plugin/defSet/application.yaml plugins/Guoba-Plugin/config/application.yaml
          echo -e ${cyan}请输入您更改之后的端口${background};read url
          host=`grep host plugins/Guoba-Plugin/config/application.yaml`
          sed -i "s/${host}/  host: ${url}/g" plugins/Guoba-Plugin/config/application.yaml
          echo -en ${blue}执行完成${green} 回车返回${background};read
      fi
      else 
        echo -e ${red}错误 请确认锅巴已安装${background}
    fi
    cd ${path}
    ;;
  3)
    cd ${path}
    py_server
    cd ${path}
    ;;
  0)
    exit
    ;;
esac
}
#########################################################
function main(){
function dialog_whiptail_page(){
clear
number=$(${dialog_whiptail} \
--title "白狐" \
--menu "白狐的QQ群:705226976" \
20 40 10 \
"1" "安装git插件" \
"2" "安装js插件" \
"3" "更新git插件" \
"4" "删除git插件" \
"5" "删除js插件" \
"6" "插件配置" \
"7" "切换bot" \
"0" "退出" \
3>&1 1>&2 2>&3)
feedback=$?
if [ ! ${feedback} = 0 ];then
exit
fi
clear
}  #dialog_whiptail_page
function echo_page(){
clear
echo
echo
echo -e ${white}"#####"${green}白狐${white}"#####"${background}
echo -e ${green}1.  ${cyan}安装git插件${background}
echo -e ${green}2.  ${cyan}安装js插件${background}
echo -e ${green}3.  ${cyan}更新git插件${background}
echo -e ${green}4.  ${cyan}删除git插件${background}
echo -e ${green}5.  ${cyan}删除js插件${background}
echo -e ${green}6.  ${cyan}插件配置${background}
echo
echo -e ${green}0.  ${cyan}退出${background}
echo "#########################"
echo -e ${green}QQ群:${cyan}狐狸窝:705226976${background}
echo "#########################"
echo
echo -en ${green}请输入您的选项: ${background};read number
}  #echo_page
choose_page
  case $number in
  1)
    cd ${path}
    git_plugin
    cd ${path}
    ;;
  2)
    cd ${path}
    js_plugin
    cd ${path}
    ;;
  3)
    cd ${path}
    git_pull_plugins
    cd ${path}
    ;;
  4)
    cd ${path}
    delete_git
    cd ${path}
    ;;
  5)
    cd ${path}
    delete_js
    cd ${path}
    ;;
  6)
    
    ;;
  7)
    robot_path
    ;;
  0)
    exit
    ;;
  esac
}  #main
#########################################################
function install_git_plugin(){
function dialog_whiptail_page(){
if [ -d plugins/${Plugin} ]
  then
    clear
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
    clear
    if (${dialog_whiptail} \
    --title "白狐-Bot-Plugin" \
    --yes-button "安装" \
    --no-button "返回" \
    --yesno "确认要安装这个插件吗？\n插件名: ${Name} \n插件URL: ${Git}" \
    10 60)
    then
    clear
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
          pnpm install -P
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
    clear
    echo -e ${green}建议到插件地址查看使用方法'\n'${blue}${Git}${background}
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
      pnpm install -P
      cd ../../ 
      echo;echo -en ${green}安装完成 回车返回${background};read
    else
      echo;echo -en ${red}安装失败 回车返回${background};read
    fi
fi
} #echo_page
choose_page
} #install_git_plugin
#########################################################
function pip_mirrors(){
function py_install(){
poetry run pip install --upgrade pip -i ${mirror}
if ! poetry run pip install -r requirements.txt -i ${mirror}
then
echo -en ${red}依赖安装失败 '\n'${blue}回车重新安装${background};read
pip_mirrors
fi
poetry install
}
echo 
echo
echo -e ${white}"#####"${green}白狐-py-plugin${white}"#####"${background}
echo -e ${blue}请输入要选择的pip镜像源${background}
echo "#########################"
echo -e ${green}1.  ${cyan}清华源${background}
echo -e ${green}2.  ${cyan}北外源${background}
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
    mirror=https://pypi.tuna.tsinghua.edu.cn/simple
    py_install
  ;;
esac
}
#########################################################
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
#########################################################
function git_plugin(){
function dialog_whiptail_page(){
clear
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
3>&1 1>&2 2>&3)
feedback=$?
if [ ! ${feedback} = 0 ];then
main
fi
clear
} #dialog_whiptail_page
function echo_page(){
clear
echo
echo
echo -e ${white}"#######"${green}白狐-Plug-In${white}"#######"${background}
echo -e ${green_red}1.  ${cyan}miao-plugin"               "喵喵插件${background}
echo -e ${green_red}2.  ${cyan}xiaoyao-cvs-plugin"        "逍遥图鉴${background}
echo -e ${green_red}3.  ${cyan}Guoba-Plugin"              "锅巴插件${background}
echo -e ${green_red}4.  ${cyan}zhi-plugin"                "白纸插件${background}
echo -e ${green_red}5.  ${cyan}xitian-plugin"             "戏天插件${background}
echo -e ${green_red}6.  ${cyan}Akasha-Terminal-plugin"    "虚空插件${background}
echo -e ${green_red}7.  ${cyan}Xiuxian-Plugin-Box"        "修仙插件${background}
echo -e ${green_red}8.  ${cyan}Yenai-Plugin"              "椰奶插件${background}
echo -e ${green_red}9.  ${cyan}xiaofei-plugin"            "小飞插件${background}
echo -e ${green_red}10. ${cyan}earth-k-plugin"           "土块插件${background}
echo -e ${green_red}11. ${cyan}py-plugin"                "py插件${background}
echo -e ${green_red}12. ${cyan}xianxin-plugin"           "闲心插件${background}
echo -e ${green_red}13. ${cyan}lin-plugin"               "麟插件${background}
echo -e ${green_red}14. ${cyan}l-plugin"                 "L插件${background}
echo -e ${green_red}15. ${cyan}qianyu-plugin"            "千羽插件${background}
echo -e ${green_red}16. ${cyan}yunzai-c-v-plugin"        "清凉图插件${background}
echo -e ${green_red}17. ${cyan}flower-plugin"            "抽卡插件${background}
echo -e ${green_red}18. ${cyan}auto-plugin"              "自动化插件${background}
echo -e ${green_red}19. ${cyan}recreation-plugin"        "娱乐插件${background}
echo -e ${green_red}20. ${cyan}suiyue-plugin"            "碎月插件${background}
echo -e ${green_red}21. ${cyan}windoge-plugin"           "风歌插件${background}
echo -e ${green_red}22. ${cyan}Atlas"                    "原神图鉴${background}
echo -e ${green_red}23. ${cyan}zhishui-plugin"           "止水插件${background}
echo -e ${green_red}24. ${cyan}TRSS-Plugin"              "trss插件${background}
echo -e ${green_red}25. ${cyan}Jinmaocuicuisha"          "脆脆鲨插件${background}
echo -e ${green_red}26. ${cyan}alemon-plugin"            "半柠檬插件${background}
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
echo 
echo -e ${green}0. ${cyan}返回${background}
echo "#####################################"
echo -e ${yellow}tip:序号为${red}红色${yellow}表示未安装'\n'序号为${green}绿色${green}表示已安装 ${background}
echo
echo -en ${cyan}请输入您需要安装插件的序号:${background};read -p " " number
} #echo_page
choose_page

case ${number} in
   1)
     Name=喵喵插件 #插件中文名字
     Plugin=miao-plugin #插件名
     Git=https://gitee.com/yoimiya-kokomi/miao-plugin.git #仓库链接
     install_git_plugin #调用安装
     ;;
   2)
     Name=逍遥图鉴
     Plugin=xiaoyao-cvs-plugin
     Git=https://gitee.com/Ctrlcvs/xiaoyao-cvs-plugin.git
     install_git_plugin
     ;;
   3)
     Name=锅巴插件
     Plugin=Guoba-Plugin
     Git=https://gitee.com/guoba-yunzai/guoba-plugin.git
     install_git_plugin
     ;;
   4)
     Name=白纸插件
     Plugin=zhi-plugin
     Git=https://gitee.com/headmastertan/zhi-plugin.git
     install_git_plugin
     ;;
   5)
     Name=戏天插件
     Plugin=xitian-plugin
     Git=https://gitee.com/XiTianGame/xitian-plugin.git
     install_git_plugin
     ;;
   6)
     Name=虚空插件
     Plugin=akasha-terminal-plugin
     Git=https://gitee.com/go-farther-and-farther/akasha-terminal-plugin.git
     install_git_plugin
     ;;
   7)
     Name=修仙插件
     Plugin=xiuxian-plugin
     Git=https://gitee.com/three-point-of-water/xiuxian-plugin
     install_git_plugin
     ;;
   8)
     Name=椰奶插件
     Plugin=yenai-plugin
     Git=https://gitee.com/yeyang52/yenai-plugin.git
     install_git_plugin
     ;;
   9)
     Name=小飞插件
     Plugin=xiaofei-plugin
     Git=https://gitee.com/xfdown/xiaofei-plugin.git
     install_git_plugin
     ;;
   10)
     Name=土块插件
     Plugin=earth-k-plugin
     Git=https://gitee.com/SmallK111407/earth-k-plugin.git
     install_git_plugin
     ;;
   11)
     if ! [ -x "$(command -v pip)" ];then
       echo -e ${cyan}检测到未安装pip${background}
       exit
     fi 
     if ! [ -x "$(command -v poetry)" ];then
       echo -e ${cyan}检测到未安装poetry${background}
       exit
     fi
     Name=py插件
     Plugin=py-plugin
     Git=https://gitee.com/realhuhu/py-plugin.git
     install_git_plugin
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
       if ! [ -x "$(command -v pip)" ];then
       echo -e ${cyan}检测到未安装pip${background}
       exit
       fi 
       if ! [ -x "$(command -v poetry)" ];then
       echo -e ${cyan}检测到未安装poetry${background}
       exit
       fi
       cd plugins/py-plugin
       pip_mirrors
       cd ../../
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
     install_git_plugin
     ;;
   13)
     Name=麟插件
     Plugin=lin-plugin
     Git=https://gitee.com/go-farther-and-farther/lin-plugin.git
     install_git_plugin
     ;;
   14)
     Name=L插件
     Plugin=l-plugin
     ghproxy_agency
     Git=${ghproxy}https://github.com/liuly0322/l-plugin.git
     install_git_plugin
     ;;
   15)
     Name=千羽插件
     Plugin=qianyu-plugin
     Git=https://gitee.com/think-first-sxs/qianyu-plugin.git
     install_git_plugin
     ;;
   16)
     Name=清凉图插件
     Plugin=yunzai-c-v-plugin
     Git=https://gitee.com/xwy231321/yunzai-c-v-plugin.git
     install_git_plugin
     ;;
   17)
     Name=抽卡插件
     Plugin=flower-plugin
     Git=https://gitee.com/Nwflower/flower-plugin.git
     install_git_plugin
     ;;
   18)
     Name=自动化插件
     Plugin=auto-plugin
     Git=https://gitee.com/Nwflower/auto-plugin.git
     install_git_plugin
     ;;
   19)
     Name=娱乐插件
     Plugin=recreation-plugin
     Git=https://gitee.com/zzyAJohn/recreation-plugin
     install_git_plugin
     ;;
   20)
     Name=碎月插件
     Plugin=suiyue
     Git=https://gitee.com/Acceleratorsky/suiyue.git
     install_git_plugin
     ;;
   21)
     Name=风歌插件
     Plugin=windoge-plugin
     ghproxy_agency
     Git=${ghproxy}https://github.com/gxy12345/windoge-plugin
     install_git_plugin
     ;;
   22)
     Name=Atlas[图鉴]
     Plugin=Atlas
     Git=https://gitee.com/Nwflower/atlas
     install_git_plugin
     ;;
   23)
     Name=止水插件
     Plugin=zhishui-plugin
     Git=https://gitee.com/fjcq/zhishui-plugin.git
     install_git_plugin
     ;;
   24)
     Name=trss插件
     Plugin=TRSS-Plugin
     Git=https://gitee.com/TimeRainStarSky/TRSS-Plugin.git
     install_git_plugin
     ;;
   25)
     Name=脆脆鲨插件
     Plugin=Jinmaocuicuisha-plugin
     Git=https://gitee.com/JMCCS/jinmaocuicuisha.git
     install_git_plugin
     ;;
   26)
     echo -e ${red}半柠檬插件仓库暂时关闭 无法安装${background}
     exit
     Name=半柠檬插件
     Plugin=alemon-plugin
     Git=https://gitee.com/ningmengchongshui/alemon-plugin.git
     install_git_plugin
     ;;
   27)
     Name=榴莲插件
     Plugin=liulian-plugin
     Git=https://gitee.com/huifeidemangguomao/liulian-plugin.git
     install_git_plugin
     ;;
   28)
     Name=小叶插件
     Plugin=xiaoye-plugin
     Git=https://gitee.com/xiaoye12123/xiaoye-plugin.git
     install_git_plugin
     ;;
   29)
     Name=R插件
     Plugin=rconsole-plugin
     Git=https://gitee.com/kyrzy0416/rconsole-plugin.git
     install_git_plugin
     ;;
   30)
     Name=扩展插件
     Plugin=expand-plugin
     Git=https://gitee.com/SmallK111407/expand-plugin.git
     install_git_plugin
     ;;
   31)
     Name=小雪插件
     Plugin=XiaoXuePlugin
     Git=https://gitee.com/XueWerY/XiaoXuePlugin.git
     install_git_plugin
     ;;
   32)
     Name=冰祈插件
     Plugin=Icepray
     Git=https://gitee.com/koinori/Icepray.git
     install_git_plugin
     ;;
   33)
     Name=光遇插件
     Plugin=Tlon-Sky
     Git=https://gitee.com/Tloml-Starry/Tlon-Sky.git
     install_git_plugin
     ;;
   34)
     Name=枫叶插件
     Plugin=hs-qiqi-plugin
     Git=https://gitee.com/kesally/hs-qiqi-cv-plugin.git
     install_git_plugin
     ;;
   35)
     Name=七圣召唤插件
     Plugin=call_of_seven_saints
     Git=https://gitee.com/huangshx2001/call_of_seven_saints.git
     install_git_plugin
     ;;
   36)
     Name=QQ频道插件
     Plugin=QQGuild-Plugin
     ghproxy_agency
     Git=${ghproxy}https://github.com/2y8e9h22/QQGuild-Plugin
     install_git_plugin
     ;;
   37)
     Name=小月插件
     Plugin=xiaoyue-plugin
     Git=https://gitee.com/yunxiyuan/xiaoyue-plugin.git
     install_git_plugin
     ;;
   38)
     Name=fans插件
     Plugin=FanSky_Qs
     Git=https://gitee.com/FanSky_Qs/FanSky_Qs.git
     install_git_plugin
     ;;
   39)
     Name=phigros辅助插件
     Plugin=phi-plugin
     ghproxy_agency
     Git=${ghproxy}https://github.com/Catrong/phi-plugin.git
     install_git_plugin
     ;;
   40)
     Name=ap绘图插件
     Plugin=ap-plugin
     Git=https://gitee.com/yhArcadia/ap-plugin.git
     install_git_plugin
     ;;
   41)
     Name=三一插件
     Plugin=sanyi-plugin
     Git=https://gitee.com/ThreeYi/sanyi-plugin.git
     install_git_plugin
     ;;
   42)
     Nam=聊天插件
     Plugin=chatgpt-plugin
     ghproxy_agency
     Git=${ghproxy}https://github.com/ikechan8370/chatgpt-plugin.git
     install_git_plugin
     ;;
   43)
     Nam=阴天插件
     Plugin=y-tian-plugin
     Git=https://gitee.com/wan13877501248/y-tian-plugin.git
     install_git_plugin
     ;;
   45)
     Nam=星穹铁道插件
     Plugin=StarRail-plugin
     Git=https://gitee.com/hewang1an/StarRail-plugin.git
     install_git_plugin
     ;;
   
   0)
     echo
     baihu_whiptail
     ;;
 esac
} #git_plugin
#########################################################
function robot_path(){
function dialog_whiptail_page(){
number=$(${dialog_whiptail} \
--title "白狐 QQ群:705226976" \
--menu "请选择您要为哪一个bot管理插件" \
20 40 10 \
"1" "Yunzai-Bot" \
"2" "Miao-Yunzai" \
"3" "yunzai-bot-lite" \
"4" "TRSS-Yunzai" \
"0" "退出" \
3>&1 1>&2 2>&3)
}
function echo_page(){
echo
echo
echo -e ${white}"#####"${green}白狐-Yunzai-Bot${white}"#####"${background}
echo -e ${blue}请选择您要为哪一个bot管理插件${background}
echo "#########################"
echo -e ${green}1.  ${cyan}Yunzai-Bot${background}
echo -e ${green}2.  ${cyan}Miao-Yunzai${background}
echo -e ${green}3.  ${cyan}yunzai-bot-lite${background}
echo -e ${green}4.  ${cyan}TRSS-Yunzai${background}
echo -e ${green}0.  ${cyan}退出${background}
echo "#########################"
echo -e ${green}QQ群:${cyan}狐狸窝:705226976${background}
echo "#########################"
echo
echo -en ${green}请输入您的选项: ${background};read number
clear
}
choose_page
case ${number} in
1)
if [ -d /root/TRSS_AllBot ];then
  name=Yunzai
else
  name=Yunzai-Bot
fi
;;
2)
name=Miao-Yunzai
;;
3)
name=yunzai-bot-lite
;;
4)
name=TRSS-Yunzai
;;
0)
exit
;;
*)
echo
echo -e ${red}输入错误${background}
exit
;;
esac
if [ -d "/root/${name}" ];then
path="/root/${name}"
elif [ -d "/root/fox@bot/${name}" ];then
path="/root/fox@bot/${name}"
elif [ -d "/home/lighthouse/ubuntu/${name}" ];then
path="/home/lighthouse/ubuntu/${name}"
elif [ -d "/home/lighthouse/centos/${name}" ];then
path="/home/lighthouse/centos/${name}"
elif [ -d "/home/lighthouse/debian/${name}" ];then
path="/home/lighthouse/debian/${name}"
elif [ -d "/home/lighthouse/debian/${name}" ];then
path="/home/lighthouse/debian/${name}"
elif [ -d "/root/TRSS_AllBot/${name}" ];then
path="/root/TRSS_AllBot/${name}"
elif [ -d "/root/TRSS_AllBot/${name}" ];then
path="/root/TRSS_AllBot/${name}"
elif [ -d "plugins" ];then
path="."
else
function dialog_whiptail_page(){
${dialog_whiptail} --title "白狐≧▽≦" --msgbox "自动判断路径失败 请进入${name}目录后 使用本脚本" 10 43
exit
}
function echo_page(){
echo
echo -e ${red}未在此目录下找到${name}的插件文件夹${background}
echo -e ${red}请进入 ${name}目录 之后使用本脚本${background}
exit
}
choose_page
fi
cd ${path}
}
function choose_page(){
if [ ${page} = dialog_whiptail_page ];then
dialog_whiptail_page
elif [ ${page} = echo_page ];then
echo_page
fi
}
function apt_install(){
if ! [ -x "$(command -v whiptail)" ];then
    echo -e ${cyan}检测到未安装whiptail 开始安装${background}
    apt update -y
    apt install whiptail -y
fi
if ! [ -x "$(command -v git)" ];then
    echo -e ${cyan}检测到未安装git 开始安装${background}
    apt update -y
    apt install git -y
fi
if ! [ -x "$(command -v curl)" ];then
    echo -e ${cyan}检测到未安装curl 开始安装${background}
    apt update -y
    apt install curl -y
fi
}
function yum_install(){
if [ -x "$(command -v whiptail)" ];then
    dialog_whiptail=whiptail
elif [ -x "$(command -v dialog)" ];then
    dialog_whiptail=dialog
else
    echo -e ${red}检测到未安装dialog或者whiptail 开始安装dialog${background}
    yum update -y
    yum install dialog -y
fi
if ! [ -x "$(command -v git)" ];then
    echo -e ${cyan}检测到未安装git 开始安装${background}
    yum update -y
    yum install curl -y
fi
if ! [ -x "$(command -v curl)" ];then
    echo -e ${cyan}检测到未安装curl 开始安装${background}
    yum update -y
    yum install curl -y
fi
}
function pacman_install(){
if [ -x "$(command -v whiptail)" ];then
    dialog_whiptail=whiptail
elif [ -x "$(command -v dialog)" ];then
    dialog_whiptail=dialog
else
    echo -e ${red}检测到未安装dialog或者whiptail 开始安装dialog${background}
    pacman -Sy dialog --noconfirm
fi
if ! [ -x "$(command -v git)" ];then
    echo -e ${cyan}检测到未安装git 开始安装${background}
    pacman -Sy git --noconfirm
fi
if ! [ -x "$(command -v curl)" ];then
    echo -e ${cyan}检测到未安装curl 开始安装${background}
    pacman -Sy curl --noconfirm
fi
}
red="\033[31m"
green="\033[32m"
yellow="\033[33m"
blue="\033[34m"
purple="\033[35m"
cyan="\033[36m"
white="\033[37m"
background="\033[0m"
if grep -q -s -i -E "debian|ubuntu" /etc/issue;then > /dev/null
    apt_install
    page=dialog_whiptail_page
    dialog_whiptail=whiptail
    robot_path
    main
elif grep -q -s -i -E "centos|red hat|redhat|Kernel" /etc/issue;then > /dev/null
    yum_install
    page=dialog_whiptail_page
    robot_path
    main
elif grep -q -s -i -E "arch|manjaro" /etc/issue;then > /dev/null
    pacman_install
    page=dialog_whiptail_page
    robot_path
    main
else
    page=echo_page
    robot_path
    main
fi
function mainbak()
{
   while true
   do
       main
       mainbak
   done
}
mainbak