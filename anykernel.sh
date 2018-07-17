# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=Avengers Theme Manager by @nathanchance
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=OnePlus6
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=1;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;

## AnyKernel install
split_boot;

# begin ramdisk changes

# Enable Avengers Theme on the command line
ui_print " "; ui_print "Enabling Avengers Theme..."
patch_cmdline "avengers_theme" "avengers_theme"

# end ramdisk changes

flash_boot;

## end install

