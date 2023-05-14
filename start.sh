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
�Å`dstart.sh �V]o�D}fŭ��6E�d�!BD��C<��J�(قƞٵ1c'�R�&m�l� �@[R)4��4����4f�1����k��&�E≇��޹��s��=�ӧ�V�xFD�wP�q)G1g�t|dbnW,�w/����̀V=�أ�#\ �m���!\��Ȧ~�5j�h�=R� ~L����w4��q"�WZNR'�J:��p�a�U�a�\�D!�H'�X��G�u)�3kK�k�~���zI���:�9�h�4�{����ߊ��%������/V�����%�{�z��t�ywwo��f�w?Y[��v_l��m���QA� kp����`���ѬrN	�����ͳ���9Y��R��7G�S����/7��������00n�-�Ć���/=��,nS���hS5�~p��;�}�hd!F�1�(7\��*����n��]qw������d��x�(���hk��]JC��`�T�0ġ�@9����P�6�$��h��,h�[9ߦ��`�4�l<����n툧?����βX]+ϒ�[�)�4�C�G�m(v��<���X�*�v�i0Yv,S��e{��;�grR� 22Ud�Ү6���OA�. �}J!�Z�N�����ғiPӯg��/��Ws���d}Zy���MK�f��@�AYs
��{#�� ̼�3��(�Ba�M��G�k���O<��#�nȏ��V���2�/�sjk@�^�`��s7����Y�r���v��Rl|Y�c%�E9�*���/���g��s=$�\�xèfF�z)	m[V�!_L��9����P��eԥ� 9"���� ��6kŊ�+߭�g�Oys'8��\��Q�i�B,�r�#��p�(J�L���X�����Wb�:v����\V��Ȍ���@12C���3e��k�+JZ6���R����Ϯ�~��je���N���[U
  