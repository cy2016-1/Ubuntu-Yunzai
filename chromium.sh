#!/bin/bash
apt update -y
case $(arch) in
  aarch64|arm64)
    chromium=arm64
    ;;
  amd64|x86_64)
    chromium=amd64
    ;;
  armhf)
    chromium=armhf
    ;;
  *)
    echo -e "\033[31m暂不支持您的设备\033[0m"
    exit
    ;;
esac
apt install -y xdg-utils libnss3 libnspr4 libgbm1 libasound2
#下载chromium.deb
wget -O chromium-browser.deb -c https://gitee.com/baihu433/chromium/releases/download/chromium_${chromium}/chromium-browser_${chromium}.deb
#下载chromium-codecs-ffmpeg-extra.deb
wget -O chromium-codecs-ffmpeg-extra.deb -c https://gitee.com/baihu433/chromium/releases/download/chromium_${chromium}/chromium-codecs-ffmpeg-extra_${chromium}.deb
#下载chromium-browser-l10n.deb
wget -O chromium-browser-l10n.deb -c https://gitee.com/baihu433/chromium/releases/download/chromium_${chromium}/chromium-browser-l10n_all.deb
dpkg -i chromium-codecs-ffmpeg-extra.deb
dpkg -i chromium-browser.deb
dpkg -i chromium-browser-l10n.deb
rm chromium-browser-l10n.deb chromium-codecs-ffmpeg-extra.deb chromium-browser.deb
if ! [ -x "$(command -v chromium-browser)" ];then
echo -e "\033[31mchromium-browser安装失败\033[0m"
exit
fi