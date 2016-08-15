#!/bin/bash

kernel_ver=$(uname -r)
module_name="usb_pqlabs"

if [ "$(lsmod | grep $module_name)" != "" ] ; then
	rmmod $module_name
fi
if [ -e /lib/modules/${kernel_ver}/kernel/drivers/usb/${module_name}.ko ]; then
	rm -f /lib/modules/${kernel_ver}/kernel/drivers/usb/${module_name}.ko
fi
