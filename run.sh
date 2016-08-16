#!/bin/bash
set -e

CONFIG_HOST="/opt/pqlabs/platform/mtsvrset.xml"
DATA_PATH="/data/oak/pqlabs"
CONFIG_DATA="${DATA_PATH}/mtsvrset.xml"

if [ "$1" = 'config' ]; then
  exec pqmt-config
else
  if [ -d "$DATA_PATH" ]; then
    if [ -f "$CONFIG_DATA" ]; then
      chmod -R g+w,o+w $CONFIG_DATA
    else
      cp $CONFIG_HOST $CONFIG_DATA
    fi
    rm $CONFIG_HOST
    ln -s $CONFIG_DATA $CONFIG_HOST
    chmod g+w,o+w $CONFIG_HOST
  fi
  /opt/pqlabs/platform/pqmtpdaemon >> /opt/pqlabs/platform/nohup.out 2>&1
  exec tail -f /opt/pqlabs/platform/nohup.out
fi
