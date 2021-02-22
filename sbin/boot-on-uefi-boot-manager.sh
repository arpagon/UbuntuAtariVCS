#!/bin/bash
# boot on UEFI Boot Manager
sudo /usr/sbin/grub-reboot "UEFI Firmware Settings"
/usr/bin/systemctl reboot -i
