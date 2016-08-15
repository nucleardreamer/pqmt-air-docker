#!/bin/bash

start_dir=$(dirname "$0")

driver_dir="/opt/oak/pqlabs/driver"

kernel_ver=$(uname -r)
kernel_machine=$(uname -m)
module_name="usb_pqlabs"

kernel_build_usb_path=/lib/modules/${kernel_ver}/build/drivers/usb/
kernel_usb_path=/lib/modules/${kernel_ver}/kernel/drivers/usb/

driver_folder="src"

target_dir="/opt/pqlabs/driver"
linux_release=$(cat /etc/*-release)

cd $driver_dir

if [ "$(lsmod | grep $module_name)" != "" ] ; then
	rmmod $module_name
fi

target_kernel_path=${kernel_build_usb_path}
if [ ! -e ${kernel_build_usb_path} ]; then
    target_kernel_path=${kernel_usb_path}
fi

cp -rf ${driver_folder} ${target_kernel_path}
cd ${target_kernel_path}/${driver_folder}/

make
cp -f usb_pqlabs.ko /lib/modules/${kernel_ver}/kernel/drivers/usb/
depmod -a
sh -c "echo usb_pqlabs >> /etc/modules"
if [ -d /etc/sysconfig/modules ]; then
	sh -c "echo -e '#!/bin/sh\n exec /sbin/modprobe usb_pqlabs' > /etc/sysconfig/modules/usb_pqlabs.modules"
	chmod +x /etc/sysconfig/modules/usb_pqlabs.modules
fi
insmod /lib/modules/${kernel_ver}/kernel/drivers/usb/usb_pqlabs.ko

cd $driver_dir

if [ ! -d $target_dir ]; then
	rm -rf $target_dir
	mkdir -p $target_dir
fi
cp uninstall.sh $target_dir
chmod +x ${target_dir}/uninstall.sh

cd $start_dir
