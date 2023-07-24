
#! /bin/bash
 
#本脚本用于部署Yunzai-Bot v3
#于2022.11.20
 
 
if [ $EUID -ne 0 ]; then
    echo "请先输入sudo su root 切换成root权限"
    exit
fi
 
echo "开始安装和更新相关环境依赖"
apt update              #列出可更新的软件清单
apt-get install -y sudo #安装sudo权限  -y表示执行过程中全部是yes
apt-get install -y curl #安装curl,curl是用于请求web服务器的工具
 
#安装nodejs
echo "开始安装nodejs"
#/dev/null相当于一个黑洞，任何输出信息都会直接丢失，此处表示将标准输出(1) 以及标准错误输出(2)都重定向到null中去，即不输出
#若type有输出，则exit code 为0
if ! type node >/dev/null 2>&1; then
    curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash - #curl的-s表示不输出错误和进度信息，-L表示让http请求跟随服务器的重定向
    sudo apt-get install -y nodejs
else
    echo "nodejs已安装"
fi
echo "安装nodejs完成"
 
#若没有npm则安装npm
if ! type npm >/dev/null 2>&1; then
    apt install npm -y
    echo 'npm安装成功'
else
    echo 'npm已安装'
fi
 
#安装并运行redis
echo "开始安装redis"
apt-get install redis -y
#启动redis服务,save中的默认参数配置
redis-server --save 900 1 --save 300 10 --daemonize yes
echo "redis安装完成"
 
#安装chromium浏览器
echo "开始安装chromium浏览器"
apt install chromium-browser -y
echo "安装chromium完成"
 
#安装中文字体
echo "开始安装中文字体"
apt install -y --force-yes --no-install-recommends fonts-wqy-microhei
echo "安装中文字体完成"
 
#安装git
echo "开始安装git"
apt install git -y
git config --global http.sslVerify false #去除https的ssl验证，方便拉取项目
echo "安装git完成"
 
#克隆云崽本体
echo "开始克隆Yunzai-Bot"
if [ ! -d "Yunzai-Bot/" ]; then #如果不存在Yunzai-Bot文件夹,-d表示是否存在文件夹
    git clone --depth=1 -b main https://github.com/Le-niao/Yunzai-Bot.git
    if [ ! -d "Yunzai-Bot/" ]; then
        echo "克隆失败"
        exit 0
    else
        echo "克隆完成"
    fi
else
    echo "Yunzai-Bot已安装"
fi
 
cd Yunzai-Bot/
echo "开始安装模块"
if [ ! -d "node-mudules/" ]; then
    if ! type pnpm >/dev/null; then
        npm install pnpm -g
    fi;
    if ! type cnpm >/dev/null; then
        npm install cnpm -g --registry=https://registry.npmmirror.com
    fi;
    pnpm install -P
    echo "安装模块完成"
else
    echo "模块已安装"
fi
 
echo "开始安装依赖"
sudo apt install -y gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget libgbm-dev
echo "安装依赖完成"
echo "云崽本体安装完成"
 
#安装其他主要插件包
 
echo -n "你想装哪个版本的py-plugin(新版v3请输入v3，旧版py请输入main，不想请crtl + c退出):"
 
read ans
if [ ${ans} == v3 ]; then
    echo "开始安装v3分支py-plugin";
    echo "安装v3云崽依赖"
    pnpm install iconv-lite @grpc/grpc-js @grpc/proto-loader -w
    if ! type python >/dev/null 2>&1; then
        echo "正在为您安装python3.10"
        curl -sL https://gitee.com/piedianz/testshell/raw/dev/ubuntu_install_python3.10_apt.sh | sudo -E bash -
    fi;
    PY_VERSION=`python -V 2>&1|awk '{print $2}'|awk -F '.' '{print $2}'`  #第一个用空格分割，取第二部分版本号3.10.8，第二个以'.'分割，取第二个数字10
    if [[ ${PY_VERSION} -lt 10 ]]; then
        echo -n "检测到您的py版本小于3.10，是否安装python3.10(yes/no):"
        read ans1
        if [ ${ans1} == yes ]; then
            echo "正在为您安装python3.10"
            curl -sL https://gitee.com/piedianz/testshell/raw/dev/ubuntu_install_python3.10_apt.sh | sudo -E bash -
        else
            echo "请保证你的python版本大于等于3.9"
        fi;
    fi;
    if [ ! -d plugins/py-plugin/ ]; then
        echo "克隆项目中"
        git clone https://github.com/realhuhu/py-plugin.git ./plugins/py-plugin
    fi;
    cd plugins/py-plugin
    if ! type poetry >/dev/null 2>&1; then
        echo "开始安装poetry"
        #python install
        pip install poetry
        if [ $? == 0 ]; then
            echo "poetry安装完成"
        else
            echo "poetry安装失败，请自行百度安装方法"
            exit 1;
        fi;
    fi;
    echo "开始安装相关依赖"
    poetry install;
    if [ $? == 0 ]; then
        echo "依赖安装成功";
    else
        echo "依赖安装失败，更换方法2"
        poetry run pip install -r requirements.txt --trusted-host mirrors.aliyun.com
        if [ $? == 0 ]; then
            echo "依赖安装成功";
        else
            echo "依赖安装失败"
            exit 1;
        fi;
    fi;
    echo "v3分支py-plugin安装完成，有关插件安装请查看https://gitee.com/realhuhu/py-plugin/tree/v3/"
    cd ../../
elif [ ${ans} == main ]; then
    echo "开始安装main分支py-plugin";
    if [ ! -d plugins/py-plugin/ ]; then
        echo "安装py依赖中"
        pnpm install @grpc/grpc-js @grpc/proto-loader -w
        echo "克隆py项目中"
        git clone -b main https://github.com/realhuhu/py-plugin.git ./plugins/py-plugin
        if [ ! -d plugins/py-plugin/ ]; then
            echo "py安装失败"
            exit
        fi
        echo "py安装成功,因部署本地py问题较多,此处建议使用远程使用py的功能"
        echo "有关远程可去https://gitee.com/realhuhu/py-plugin的main分支查看"
    fi;
else
    echo "未恰当选择，继续安装其他插件";
fi;
 
 
echo "开始安装Guoba-Plugin"
if [ ! -d plugins/Guoba-Plugin/ ]; then
    git clone --depth=1 https://gitee.com/guoba-yunzai/guoba-plugin.git ./plugins/Guoba-Plugin/
    pnpm install --filter=guoba-plugin
    if [ ! -d plugins/Guoba-Plugin/ ]; then
        echo "锅巴安装失败"
        exit
    fi
    echo "锅巴安装成功"
fi
 
echo "开始安装miao-plugin"
if [ ! -d plugins/miao-plugin/ ]; then
    git clone https://gitee.com/yoimiya-kokomi/miao-plugin.git ./plugins/miao-plugin/
    pnpm add image-size -w
    if [ ! -d plugins/miao-plugin/ ]; then
        echo "喵喵安装失败"
        exit
    fi
    echo "喵喵安装成功"
fi
 
echo "开始安装xiaoyao-cvs-plugin"
if [ ! -d plugins/xiaoyao-cvs-plugin/ ]; then
    git clone https://gitee.com/Ctrlcvs/xiaoyao-cvs-plugin.git ./plugins/xiaoyao-cvs-plugin/
    if [ ! -d plugins/xiaoyao-cvs-plugin/ ]; then
        echo "图鉴安装失败"
        exit
    fi
    echo "图鉴安装成功"
fi
 
echo "开始安装earth-k-plugin"
if [ ! -d plugins/earth-k-plugin/ ]; then
    git clone https://gitee.com/SmallK111407/earth-k-plugin.git ./plugins/earth-k-plugin/
    echo '安装土块画图相关依赖'
    cnpm install node-machine-id
    if [ ! -d plugins/earth-k-plugin/ ]; then
        echo "土块安装失败"
        exit
    fi
    echo "土块安装成功"
fi
 
echo "开始安装flower-plugin"
if [ ! -d plugins/flower-plugin/ ]; then
    git clone --depth=1 https://github.com/Nwflower/flower-plugin.git ./plugins/flower-plugin/
    if [ ! -d plugins/flower-plugin/ ]; then
        echo "花佬插件安装失败"
        exit
    fi
    echo "花佬插件安装成功"
fi
 
echo "开始安装yenai-plugin"
if [ ! -d plugins/yenai-plugin/ ]; then
    git clone https://gitee.com/yeyang52/yenai-plugin.git ./plugins/yenai-plugin
    if [ ! -d plugins/yenai-plugin/ ]; then
        echo "椰奶安装失败"
        exit
    fi
    echo "椰奶安装成功"
fi
 
echo "开始安装suiyue"
if [ ! -d plugins/suiyue/ ]; then
    git clone https://gitee.com/Acceleratorsky/suiyue.git ./plugins/suiyue/
    if [ ! -d plugins/suiyue/ ]; then
        echo "碎月安装失败"
        exit
    fi
    echo "碎月安装成功"
fi
 
echo "开始安装xitian-plugin"
if [ ! -d plugins/xitian-plugin/ ]; then
    git clone https://gitee.com/XiTianGame/xitian-plugin.git ./plugins/xitian-plugin/
    if [ ! -d plugins/xitian-plugin/ ]; then
        echo "戏天插件管理器安装失败"
        exit
    fi
    echo "戏天插件管理器安装成功"
fi
 
#由于apt安装的ffmpeg版本过低，可能不支持amr的转换
#有关ffmpeg的下载和编译，此处采用手动编译安装的方式
 
echo '开始安装ffmpeg'
if ! type ffmpeg >/dev/null 2>&1; then
    #下载ffmpeg并解压，目录设置为自己所在目录
    echo '开始下载ffmpeg'
    wget http://www.ffmpeg.org/releases/ffmpeg-5.1.tar.gz
 
    tar -zxvf ffmpeg-5.1.tar.gz
    echo '下载解压完成'
 
    #打开和编译
    cd ffmpeg-5.1/
 
    echo '安装yasm（有yasm的话就不用管）'
    apt install yasm pkg-config libopencore-amrnb-dev libopencore-amrwb-dev
    echo '安装yasm完成'
 
    #编译
    echo '此过程可能比较漫长,请耐心等候'
 
    ./configure --enable-gpl --enable-version3 --enable-nonfree --disable-ffplay --disable-ffprobe --enable-libopencore-amrnb --enable-libopencore-amrwb
 
    make
 
    make install
 
    echo '手动编译完成，恭喜!'
 
    #指示如何配置环境路径
    dir=$(pwd)
    echo "请将 ${dir}/ffmpeg 添加到登录过的云崽的config/config/bot.yaml的ffmpeg_path中,建议通过锅巴登录进行添加"
    echo '可根据需要改变环境变量'
else
    echo 'ffmpeg已安装'
fi
 
echo '本脚本已安装云崽本体及主要插件包,按自己需要删减'
echo "脚本结束，恭喜你部署完成！"