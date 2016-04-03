#!/bin/bash

set -e

cat Dockerfile.pre | docker build -t proxychains-pre --force-rm -

docker run --rm -v="$PWD:/host" proxychains-pre tar cfvz /host/proxychains.tar.gz /usr/local/lib/libproxychains4.so /usr/local/bin/proxychains4

docker build -t proxychains --force-rm .

rm -f proxychains.tar.gz

docker save -o proxychains.tar proxychains

pigz proxychains.tar
