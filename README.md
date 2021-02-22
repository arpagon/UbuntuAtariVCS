
Atari VCS
===

[TOC]

# UbuntuAtariVCS
Ubuntu Atari VCS tools

Logos Based on 
![wine](https://raw.githubusercontent.com/vinceliuice/vimix-icon-theme/7084a1ba24666d434fd032f980351c970036aac2/src/scalable/apps/wine.svg =40x)

https://github.com/vinceliuice/vimix-icon-theme/

## HW
![](https://minio.sapian.cloud/sapian-hackmd-public-bucket/uploads/upload_299c71eddfb3c843fcde95c7b12becda.png)


## Instal Ubuntu

#### Particion table

Is important the `/boot` mount pount owns a primary pertition (ext4) for use `grub-reboot` to boot on Atari VCS OS

``` bash
lsblk
```

![](https://minio.sapian.cloud/sapian-hackmd-public-bucket/uploads/upload_b3fc262b71b66bb57f4d03eb1fd1ed05.png)


## Affter install Ubuntu

### add Atari boot menu entry on Ubuntu Grub
#### Set custom entry
**/etc/grub.d/40_custom**

``` bash
#!/bin/sh
exec tail -n +3 $0
# This file provides an easy way to add custom menu entries.  Simply type the
# menu entries you want to add after this comment.  Be careful not to change
# the 'exec tail' line above.
menuentry 'Atari VCS' {
    search --fs-uuid --no-floppy --set=root 0722-6756
    chainloader (${root})/EFI/BOOT/BOOTX64.EFI
}
menuentry 'Atari VCS linux' {
    search --fs-uuid --no-floppy --set=root 0722-6756
    chainloader (${root})/EFI/Linux/linux.efi
}
```

#### Detect UUID for atari partition
where 0722-6756 is de UUID from disk 

``` bash
sudo cat /media/${USER}/rootfs/etc/fstab
```
example result
``` bash
UUID=0722-6756	/boot/efi	vfat	defaults	0	2
/dev/mapper/root	/	ext4	defaults,noatime,ro,errors=remount-ro	0	0
/dev/disk/by-partlabel/var	/var   ext4    defaults,rw     0       2
/dev/disk/by-partlabel/storage	/home	ext4	defaults,rw	0	2
```

or 
``` bash
blkid /dev/mmcblk0p2
```
example result
``` bash
/dev/mmcblk0p2: LABEL_FATBOOT="efi" LABEL="efi" UUID="0722-6756" TYPE="vfat" PARTLABEL="EFI-B" PARTUUID="d0755709-8dc6-419d-8abb-2d70ee388c5e"
```
#### Update Grub
``` bash
update-grub
reboot 
```

# Disable default UEFI devices
https://www.youtube.com/watch?t=579&v=wSKTYPXgWsU&feature=youtu.be

{%youtube https://www.youtube.com/watch?t=579&v=wSKTYPXgWsU&feature=youtu.be %}

https://www.youtube.com/watch?v=xU42H-A4FFQ
TimeCode 3:50 shows the screen


## Set default Grub Option

https://rastating.github.io/creating-a-reboot-into-windows-button-in-ubuntu/


In order for the grub-reboot command to work, several required configuration changes must be in place:

The default entry for grub must be set to saved. One possible location for this is the GRUB_DEFAULT= line in /etc/default/grub
Use grub-set-default to set your default entry to the one you normally use.
Update your grub config (e.g. update-grub).

This should take care of the initial set-up. In the future, just do grub-reboot <entry> for a one-time boot of <entry>.
  
## Create Group Atari 

``` bash
sudo addgroup atari
usermod -a -G atari arpagon
usermod -a -G atari mutantarpagon

echo '%atari ALL=(ALL) NOPASSWD: /usr/local/sbin/boot-on-windows.sh' > /etc/sudoers.d/00-atari
echo '%atari ALL=(ALL) NOPASSWD: /usr/local/sbin/boot-on-uefi-boot-manager.sh' >> /etc/sudoers.d/00-atari
echo '%atari ALL=(ALL) NOPASSWD: /usr/local/sbin/boot-on-atari.sh' >> /etc/sudoers.d/00-atari
```

# Desktop File


# TODO
https://github.com/1nfiniteloop/pam-http
