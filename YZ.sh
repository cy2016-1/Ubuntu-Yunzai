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
�Å`dYZ.sh uQ�n1��+���[�J�8@�$�@ yfzm�=��lv���,R"Ǯ�~T��{؇��e��\��O� ���������A����F�:�!��۠�t�a8�/L5ƶ�h�{���/ֱt����8�"lj_�T3�	�PJ.l�&k�Cr�ZC��&t'�$�Y�s-���E- �y�B��k���ʴ_ۈ��D�!��Fb��w��E�\���l���>C���ٻ�W��}f.���gW�b�Y��u��z�\�6DR���/�ΥC-\��0�"��P$ˤVVg��WǸ�� ^d��K3����_������o}Y��,v��e��GD���L��<£��-h���������c��%��}  