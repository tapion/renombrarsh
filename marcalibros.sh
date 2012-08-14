#!/bin/bash
ARCHIVOORIGEN=${1// /\\ }
NOMBRE=${2// /_}
CORREO=${3// /_}
RUTAUNO=$4
RUTADOS=$5
RUTABASE="../shop/media/downloadable/files/links/${RUTAUNO}/${RUTADOS}"
#echo "hoa ${RUTABASE}"
#RUTABASE="/var/www/html/california/california-edit"
ALEATORIO=$((RANDOM%16))
NUEVOARCHIVO="tmp_${ALEATORIO}_${ARCHIVOORIGEN}"
NUEVONOMBRE="${ARCHIVOORIGEN//.epub/}_${ALEATORIO}_${NOMBRE}"
NUEVONOMBREZIP="${ARCHIVOORIGEN//.epub/}_${ALEATORIO}_${NOMBRE}.zip"
NUEVONOMBREEPUB="${ARCHIVOORIGEN//.epub/}_${ALEATORIO}_${NOMBRE}.epub"
CARPETA="carpeta_${ALEATORIO}"
cd $RUTABASE
cp ${ARCHIVOORIGEN} ${NUEVOARCHIVO}
mkdir ${CARPETA}
unzip ${NUEVOARCHIVO} -d ${CARPETA}/ > tmp
rm -f ${NUEVOARCHIVO}
cd ${CARPETA}
ls *.htm | sort -R | head -5 | sed -e 's/ /\\ /g' | xargs sed -i "s/<\/body>/<div style=\"text-align: right;width: 100%;position: absolute;right: 8px\"><p style=\"margin: 2px 1px\">${NOMBRE}<\/p><p style=\"margin: 2px 1px\">${CORREO}<\/p><p style=\"margin: 2px 1px\"><a href=\"http:\/\/california-edit.com\" title=\"California Edit\" target=\"_new\">California edit<\/a><\/p><\/div><\/body>/g"
zip -v0X ${NUEVONOMBRE} mimetype > tmp
zip -vr ${NUEVONOMBRE} * -x ${NUEVONOMBREZIP} mimetype > tmp
mv ${NUEVONOMBREZIP} ${NUEVONOMBREEPUB}
mv ${NUEVONOMBREEPUB} ../
cd ../
rm -rf ${CARPETA}
echo "ok"
echo $NUEVONOMBREEPUB
