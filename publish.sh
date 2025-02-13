#!/bin/bash

set -e
set -o pipefail

trap "echo ERROR; read a" ERR

if [ "$(hostname)" != "omen-desktop" ]; then echo "WRONG MACHINE"; exit -1; fi

cd "$(dirname "$0")"

rm -rf public
zola build

FROM="./public/"

cp content/.htaccess "$FROM/"

DEST="clcom@vhost.cherokeelessons.com:./www.CherokeeLessons.com/public_html/"
rsync --progress -a --delete-after -z --verbose --human-readable "$FROM" "$DEST"
