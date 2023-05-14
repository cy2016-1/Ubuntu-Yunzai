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
�Å`dinstall.sh �T�KA��xY�$�f6��R��{�=-8I&ف�ٰ3�6ॠ��J� x�V)�m��/�M�3:;c�T�Vo�;�f�����73�E5�Q?35����G�����(����p�(C���Epry�q@
T��<�\ux</}�3���p��ry�\
���ѯ�O���Y0^�dH�J�2M�#�M@D�57"�`A�W���B`C�6�U�pV��p�YޗS�&��00�1:PW+�� =��I��oǛ��;��['{O'�l��֐��7�-A�X�tI���1��K9���6%�sCF���V|ږ��B��0;ߐ^�~���������௮�Q6\-�S�!c���n{B���mq!]B�:y}������Q��H�5LQ�WP��$�W������	hбx!g��A؀��z�;NP�tWz>�0]�i�m�C3ӵ��U���F�N�r����)
V�i�W��Ą��5��{P�6�O&�ⶰj�^?��;���T���g9��U��@�T2�:z3m�8�:8~=8�z��@�ja���c�o��|�O���p�r��qN݅�9+V�XAP�F�겕�H�۴�������/ߔan݄�ٔ<���1�"L�[�ފ��k���ᄆ{  