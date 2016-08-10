#!/bin/bash -e

platform_dir="/pqmt/driverkit/platform"
target_dir="/opt/pqlabs/platform"
platform_air_app_id="com.pqlabs.MultiTouchPlatform"

cd $platform_dir

mkdir -p $target_dir

mkdir -p ${target_dir}/Report
mkdir -p ${target_dir}/lib
cp -f lib/* ${target_dir}/lib

cp -f pqmtplatform "/usr/local/bin"
chmod +x "/usr/local/bin/pqmtplatform"

cp -f MultiTouchPlatform.air MultiTouchPlatformHelper pqmtpdaemon uninstall.sh *.pqx *.xml *.so output.log daemon.log version $target_dir

cd $target_dir
chmod +x MultiTouchPlatformHelper pqmtpdaemon uninstall.sh

cd ${target_dir}/lib
chmod +x link_util
./link_util -m
cd ..

cp /pqmt/config/* ./

chmod g+w,o+w mtsvrset.xml service.xml parsercfg.pqx output.log daemon.log

Xvfb :0 -screen 0 1024x768x16 > /dev/null 2>&1 &

DISPLAY=:0 /usr/local/bin/air-install -silent -eulaAccepted ${target_dir}/MultiTouchPlatform.air

ln -s /opt/MultiTouchPlatform/bin/MultiTouchPlatform /usr/local/bin/pqmt-config

cd $platform_dir
