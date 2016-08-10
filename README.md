# PQLabs Multitouch Adobe AIR
To run:
```
xhost +
docker run --rm -t \
  --name="pqlabs" \
  --privileged \
  -v /dev/bus/usb:/dev/bus/usb \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  nucleardreamer/pqmt-air-docker
```
To configure:
```
docker exec pqlabs run config
```
