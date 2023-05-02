#!/bin/bash
cd ~
git clone --depth=1 https://ghproxy.com/https://github.com/icqqjs/icqq
cd icqq
rm -rf .git
git init
git add .
git commit -m "同步成功"
git remote add origin https://gitee.com/baihu433/icqq.git
git push --set-upstream origin master
echo "定时任务执行成功"
cd ~
exit 0
#0 */12 * * * /bin/bash ~/icqq.sh > /dev/null 2>&1 