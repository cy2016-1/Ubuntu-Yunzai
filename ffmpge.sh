#!/bin/bash
case $(arch) in
  aarch64|arm64)
    ffmpeg=arm64
    ;;
  amd64|x86_64)
    ffmpeg=amd64
    ;;
  armhf)
    ffmpeg=armhf
    ;;
  i686)
    ffmpeg=i686
    ;;
  armel)
    ffmpeg=armel
    ;;
  *)
    echo -e "\033[31m暂不支持您的设备\033[0m"
    exit
    ;;
esac
curl -o ffmpeg-release-${ffmpeg}-static.tar.xz https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-${ffmpeg}-static.tar.xz
curl -o ffmpeg.tar.xz.md5 https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-${ffmpeg}-static.tar.xz.md5
md5sum -c ffmpeg.tar.xz.md5 
if [ $? -eq 0 ]
then
echo -e "\033[36m下载成功\033[0m"
else
echo -e "\033[31m下载失败033[0m"
exit
fi
xz -d ffmpeg-release-${ffmpeg}-static.tar.xz
mkdir ffmpeg
tar -xvf ffmpeg-release-${ffmpeg}-static.tar -C ffmpeg
path=$(ls ffmpeg)
rm -rf /usr/local/bin/ffmpeg /usr/local/bin/ffmpeg &>/dev/null
rm -rf /usr/local/bin/ffmpeg /usr/local/bin/ffmpeg &>/dev/null
mv ffmpeg/${path}/ffmpeg /usr/local/bin/ffmpeg
mv ffmpeg/${path}/ffprobe /usr/local/bin/ffprobe
chmod +x /usr/local/bin/ffmpeg
chmod +x /usr/local/bin/ffprobe
rm -rf ffmpeg ffmpeg.tar
if [ -e /usr/local/bin/ffmpeg ] && [ -e /usr/local/bin/ffprobe ]
then
ffmpeg
echo
echo -e "\033[36m安装完成\033[0m"
else
echo -e "\033[31m安装失败\033[0m"
fi