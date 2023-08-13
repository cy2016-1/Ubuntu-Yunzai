sed -i 's/ports.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list
apt update -y
apt install eatmydata -y
eatmydata apt install -y whiptail
eatmydata apt install -y fonts-wqy* language-pack-zh* locales-all redis redis-server git curl wget tar gzip xz-utils
echo 'export LANG="zh_CN.UTF-8"' >> /etc/profile
export LANG="zh_CN.UTF-8"
