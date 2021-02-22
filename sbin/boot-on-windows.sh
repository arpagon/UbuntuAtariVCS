#!/bin/bash
# boot on Windows
sudo /usr/sbin/grub-reboot "Windows Boot Manager (on /dev/sdb2)"
/usr/bin/systemctl reboot -i
