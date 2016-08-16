# PQLabs Multitouch Adobe AIR
In order to use a PQLabs frame with this docker images, you need to install the kernal drivers for their `hidraw` device.
To install and run:
```
# assumes you want to share the x socket, a variation of x:local is more secureassumes you want to share the x socket, a variation of x:local is more secure
xhost +

# this will compile the USB drivers against your current headers. You need to have a linux-headers package installed in order for this to work (most debian variants should come with GCC as well)
cd driver && sudo ./install.sh

# start the server. This shares all of /dev, but all that is actually needed is the two /dev/input devices and I can only assume the /dev/hidrawX device. If you want to explore more, go ahead and run 'udevadm monitor' to see what paths udev mounts your frame device to.
docker-compose up
```
## calibration
In the `config` directory, there is an xml file that the PQLabs software uses for configuration. The file is the stock config, so `TUIO (3333)`, `TUIO flash (3000)` and `Mouse` are enabled by default.

If you want to start with a known configuration, you will need to overwrite the `config/mtsvrset.xml` file, which will get persisted in a data volume. From there, any time the data volume gets blown away it will use the configuration file that was build from your image.

The entrypoint is not set, `run` is a symlink to `run.js` in the root directory

To run calibration or the configuration tool:
```
docker exec pqlabs run config
```
To run a shell, simply do:
```
docker exec pqlabs /bin/bash
```
