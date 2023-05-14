#!/bin/sh
skip=49

tab='	'
nl='
'
IFS=" $tab$nl"

umask=`umask`
umask 77

gztmpdir=
trap 'res=$?
  test -n "$gztmpdir" && rm -fr "$gztmpdir"
  (exit $res); exit $res
' 0 1 2 3 5 10 13 15

case $TMPDIR in
  / | /*/) ;;
  /*) TMPDIR=$TMPDIR/;;
  *) TMPDIR=/tmp/;;
esac
if type mktemp >/dev/null 2>&1; then
  gztmpdir=`mktemp -d "${TMPDIR}gztmpXXXXXXXXX"`
else
  gztmpdir=${TMPDIR}gztmp$$; mkdir $gztmpdir
fi || { (exit 127); exit 127; }

gztmp=$gztmpdir/$0
case $0 in
-* | */*'
') mkdir -p "$gztmp" && rm -r "$gztmp";;
*/*) gztmp=$gztmpdir/`basename "$0"`;;
esac || { (exit 127); exit 127; }

case `printf 'X\n' | tail -n +1 2>/dev/null` in
X) tail_n=-n;;
*) tail_n=;;
esac
if tail $tail_n +$skip <"$0" | gzip -cd > "$gztmp"; then
  umask $umask
  chmod 700 "$gztmp"
  (sleep 5; rm -fr "$gztmpdir") 2>/dev/null &
  "$gztmp" ${1+"$@"}; res=$?
else
  printf >&2 '%s\n' "Cannot decompress $0"
  (exit 127); res=127
fi; exit $res
�Å`dubuntu.sh �Vmo�F����9)�����Q�J�PP���k�={}�����vr!I��BU��VUiy�RZ��H���("�����S�Bwmߝ�#HE�[������3��3��W5���/�8����UӲ1SFՊ��j�e�^pș݁� 闁�aנ�2d�� �kؕz�^#@޾s76��ۛ�~l<��X�,sq��AN2��Ih�����A���ZP	\?�#�rf6̧@�e�ք�՚^#���r�P8W(8�8���p��ƽ�;��I½0ð����G���({��*6��rfhW9Wv� �|�c%Uu,J	eJ�d���@�]59�x��'Q3�/����>�996r���U��*�|����)������J׉�W�7֯m�z�y��������֡2c��+)�Ws�MV���l����'�%�pF��p�&ǵ�d
g+��r\Ȣ�Em�b��@�u��[����X_��yz9��[���������+n�x�}�q$�6��������n~���uc����~��+����a0a�z�r}��^�|���<�Qg�8��d��� ��y��$����]ס�#W�%N��1r�5r��6	5����r��\�T̩�\Ɛ���f�ol�&P5�T�T,��1x���_S���.D�Ra�N��I��U�X�;����K�w�l��ev�x��o��~m���������p����Wz{�Aw��fH�zx�ڄ7mLH=ΤaQ �t���N:>],5��.�1pQr]�m��y6��� ��c�\r_�j;�ss��y!�E/�SO���0Π���|p��s�<8t��ǥ]��	�m�yB,��r&�/y��0
�w��a��j����<��&G��&�W����S��$)He'-��ኧ�xܙ�<3��$�TVs���#jt���څ��z��� �c'��h�*'�O�"=���VW/��l��-�_U�~�֋�N���ʙY�v�kt�ݷ�7�3�����4�Y�
�Zn$��rf(��<�TNn�\��p�fC��IRL u�)��De��A��f��*�#~d�w�!�����DA��i�34Q`���R����p9�sC<f}�~(�q�r� :��l��"ߚ����脏&�(�k�� �m-�߯d�.涐i<#���:v,Z��Ϸ�-� �Ya���N\3Q�	�д��\���n[���z��ꃓgFO���{od�Nb&��J�9Q�e��/�K�"��'�E:x�D����Wi_Bƫ�rP�$�O'��S�Vī�ݿ*w��z�P�sŌ�S�<���0���rE%�� wVN�e�U���+ȭ&mR�k�x��z��ڍWj�����ښlU>ApeY��X(�g�����=�,��i�A�{U#MəJL����F�S���>T!�d� 2s)Ȉ>�6��)�:@d��.:��{5[$O�T���	�\�z  