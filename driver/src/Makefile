obj-m := usb_pqlabs.o
PWD := $(shell pwd)
KERNELDIR ?= /lib/modules/$(shell uname -r)/build
default:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules
clean:
	rm -fr *.o *.mod.* *.ko Module.*  modules.order *.*~ *~
