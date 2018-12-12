# ---------------------------
# Author: Cairo Ap. Campos
# Create: 11-12-2018
# Last modified: 11-12-2018
# ---------------------------

DRIVER_VERSION := "1.0"
DRIVER_AUTHOR  := "Cairo Ap. Campos"
DRIVER_DESC    := "Linux Arduino-Morse Driver"
DRIVER_LICENSE := "GPL"

obj-m	:= morse.o

KERNELDIR ?= /lib/modules/$(shell uname -r)/build
PWD       := $(shell pwd)

all:
	$(MAKE) -C $(KERNELDIR) M=$(PWD)

clean:
	rm -rf *.o *~ core .depend .*.cmd *.ko *.mod.c .tmp_versions modules.order Module.symvers


