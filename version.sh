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
�Å`dversion.sh �Yms����_q�5V�)	�ԋ+3I�u��$u�3˵A"�� E���3r��H��FQ*Kv�Z��X&�ʱ%����>�/t� ��ʄ3"xw������-t�."�\��$���C�еХ$��ӂ ;A��$I�vfB0���3�q*�NI������u�QO'D�N0F ���񴒕���`R�&���h`��̱a�af-�r�V�X-�?��_�����B��Ϲ���9���lnE_���U�x0!�-��݇u�Qi.�&*�����,��bkҝ'����ۀ�~	���7����^�k�����^����>��8�����#�Ǉ�cC#�����F� ��C�ok�|��҃�C>�=GM�W�Cr6�L���(�D���c�It�c�K+�����@��D��+jB��d>)��A��S���I��r�	�k�u�d:dO{��,�K��"�C>F�%���o|�� �Q��6��r�cL�O��Ѻr,�t��r��Z�Wa�h��
L*�ޏ�`o!j�I(I���xBM(ٌ�e#YY�v�A�9*Ȫ���C�9&DD^��C�!{}�둵�;?��"O�qk��������NQ�gl�p�[�hU_9��/ll�y�V�7���N�͊���.���v����ک�Q�w����a��6G���'��S��SS,J5�e���������$����L떋ݜV��_�8��y��ӡ�aIm��ݵR[) D��F�������T`�OJ�Qt���>%ĕ���\:�/��B]4O���9�`���`����M˰d�ɦ�6�?G����(�h ����C�n�常k�����_��&s�<�2O�q�񨿗����Q����>wO;^Ƌ[Ze��Y�G`�m\��jy������U�:�(Gy�;x�5!+��߽�����,�z��UԪ���|��P�_7��x�M+Y��H��4�����Μ���XYn9��x�*d���h6-!�(����8ǥ��@\T�H �$9B�Y�zpI�#[��BHg�7�9���H��_"���d˱N�.p<�J+�f,i;(q�#���YT=��.XrFx1����A�s���HO>��5 iH2��Ԩ�7�;���qj?.��ǁ��`y0uf��jGǻ��C��v+&����ٍI2�Ir�Ѫ=l���+��L�D�^5��߰;U�_���6ZZ��o�h�X�w����%��b\�\��4�w�OY𢔜J��,���$˩[�݋�SL�f����Q��-T:1*����������S(���U=�Z4K'xo���mOѽ��)i���F_Y�w*={<�����������n�g_紐|���݉G��bOaF봊��K+b�K�FGhoܭ1|�m{��ML��W���0�ϟT���F��BHB�텊�2��<�4��
SY1��nþ�x�n�]T��G٦�oB#a��h� �d <ƫ<GC���߻x��ӓ�к{�P�z�������5�k�U��so�A���r2<�o�{9���~c��u���oe��o"Ъ��lC��>�xV��O&ޥyt��o� ����Q�oT�_Y����a��M�8�n�J�ok�A��ݭ��=��՗I��|�N�,�~lU�����h���SS��FY_����+�n��7[��G|�Hk���	y��D�
�����ۉUj����)'d,��Ȭ�`T�����q����ŋ��*C3����6���m�N�آ^X�[}�+󯠳�W�/�_@�(1�{C������P ��[o��u�r涽��QC�a���[i�U�˭}��U���?�b�p/�a�n�s/��AE\^��?K3p��`���kf�זp��F.n�#� ���f������4G���ږ���gdG��t��ʾ���Kk�r�~������ Gº�  