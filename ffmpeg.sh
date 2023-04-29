#!/bin/bash
case $(arch) in
  aarch64|arm64)
    structure=arm64
    ;;
  amd64|x86_64)
    structure=amd64
    ;;
  arm|armhf|armv8l)
    structure=armhf
    ;;
  armel)
    structure=armel
    ;;
  *)
    echo -e "\033[31m暂不支持您的设备\033[0m"
    exit
    ;;
esac
curl -o ffmpeg https://gitee.com/baihu433/ffmpeg/raw/master/ffmpeg-${structure}/ffmpeg
curl -o ffprobe https://gitee.com/baihu433/ffmpeg/raw/master/ffmpeg-${structure}/ffprobe
mv -f ffmpeg /usr/local/bin/ffmpeg
mv -f ffprobe /usr/local/bin/ffprobe
chmod +x /usr/local/bin/ffmpeg
chmod +x /usr/local/bin/ffprobe
if [ -e /usr/local/bin/ffmpeg ] && [ -e /usr/local/bin/ffprobe ]
then
ffmpeg
echo
echo -e "\033[36m安装完成\033[0m"
else
echo -e "\033[31m安装失败\033[0m"
fi