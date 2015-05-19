#!/bin/sh
curl https://www.kernel.org/pub/linux/utils/util-linux/v2.24/util-linux-2.24.tar.gz | tar -zxf-
cd util-linux-2.24
./configure --without-ncurses
make nsenter
sudo cp nsenter /usr/local/bin
cd ..
git config --global http.proxy http://10.110.15.60:8080
git config --global https.proxy https://10.110.15.60:8080
git clone https://github.com/jpetazzo/pipework.git
