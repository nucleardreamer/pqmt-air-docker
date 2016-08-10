#!/bin/bash
set -e
if [ "$1" = 'config' ]; then
  exec pqmt-config
else
  /opt/pqlabs/platform/pqmtpdaemon >> /opt/pqlabs/platform/nohup.out 2>&1
  exec tail -f /opt/pqlabs/platform/nohup.out
fi
