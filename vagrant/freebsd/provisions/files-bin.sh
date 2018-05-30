#/usr/bin/env sh

set -e
STORAGE_DIR=/tmp/bin

test -d "${STORAGE_DIR}" || exit 0
chmod +x "${STORAGE_DIR}/"*
mv -v "${STORAGE_DIR}/"* /usr/local/bin/
rm -rf "${STORAGE_DIR}"
