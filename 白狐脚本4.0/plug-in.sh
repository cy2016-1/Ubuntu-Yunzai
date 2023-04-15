#!/bin/bash
function pip_mirrors(){
function py_install(){
if ! poetry run pip install -r requirements.txt -i ${mirror}
then
echo -en ${red}依赖安装失败 '\n'${blue}回车重新安装${background};read
pip_mirrors
fi
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
echo -e ${green}8.  ${blue}官方源${background}
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
    mirror=https://pypi.org/simple
    py_install
  ;;
  *)
    echo;echo -en "\033[31m输入错误\033[0m";read
  ;;
esac
}
function py-plugin_server(){
function server_host(){
  sed -i "s/host: 127.0.0.1/host: 159.75.113.47/g" ${path}/plugins/py-plugin/config.yaml
  pyport=(grep port ${path}/plugins/py-plugin/config.yaml)
  sed -i "s/${pyport}/port: 50053/g" ${path}/plugins/py-plugin/config.yaml
  echo;echo -en ${blue}已切换为远程服务器 回车返回${background};read
}
function local_host(){
  sed -i "s/host: 159.75.113.47/host: 127.0.0.1/g" ${path}/plugins/py-plugin/config.yaml
  sed -i "s/port: 50053/port: 50052/g" ${path}/plugins/py-plugin/config.yaml
  echo;echo -en ${blue}已切换为本地服务器 ${yellow}请安装/更新依赖 ${green}回车继续${background};read
  echo
  cd ${path}/plugins/py-plugin
  pip_mirrors
  cd ../../
  echo;echo -en ${blue}执行完成 ${green}回车返回${background};read
}
if [ -d "plugins/py-plugin" ]
then
  if [ -e "${path}/plugins/py-plugin/config.yaml" ]
    then
      if grep -q "host: 159.75.113.47" ${path}/plugins/py-plugin/config.yaml
        then
          local_host
        else
          server_host
      fi
    else
      if grep -q "host: 159.75.113.47" ${path}/plugins/py-plugin/config_default.yaml
        then
          cp ${path}/plugins/py-plugin/config_default.yaml ${path}/plugins/py-plugin/config.yaml
          local_host
        else
          cp ${path}/plugins/py-plugin/config_default.yaml ${path}/plugins/py-plugin/config.yaml
          server_host
      fi
  fi
else
    echo -en "\033[33m 未安装py插件 回车返回 \033[0m";read
fi
}
function menu(){
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
      for file in $(ls -I example -I bin -I other -I system -I genshin plugins)
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
      py-plugin_server
     ;;
    8)
      if [ -e "plugins/Guoba-Plugin/config/application.yaml" ]
        then
          echo -en "\033[32m 请输入更改之后的端口号\033[0m"; read -p "" gbport
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





}














green="\033[32m"
blue="\033[36m"
white="\033[37m"
red="\033[37m"
yellow="\033[37m"
background="\033[0m"
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
if grep -q -E -i "debian" /etc/issue; then
    debian
    Linux
elif grep -q -E -i "ubuntu" /etc/issue; then
    ubuntu
    Linux
else
    Other_Linux
fi