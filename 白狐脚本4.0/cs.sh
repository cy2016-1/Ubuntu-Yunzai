a=0
green="\033[32m"
blue="\033[36m"
background="\033[0m"
echo
echo "#######################"
plugin(){
a=0
for file in $(ls -I example -I bin -I other -I system plugins)
do
a=$(($a+1))
echo \"${a}\" \"${file}\" \\ >> log
done
}
echo 'baihu=$(whiptail \
--title "白狐" \
--menu "白狐的QQ群:705226976" \
20 40 10 \
temporary
"0" "退出" \
3>&1 1>&2 2>&3) ' > baihu
sed -i s/temporary/$(cat log)/g baihu
echo 
baihu_whiptail=$(cat log)
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




baihu=$(whiptail \
--title "白狐" \
--menu "白狐的QQ群:705226976" \
20 40 10 \
temporary
"0" "退出" \
3>&1 1>&2 2>&3)