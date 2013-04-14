#! /bin/bash

# finish package configuratins 
dpkg --configure -a

PARDUS_DAGITIM=`cat /opt/PARDUS/pardus_dagitim.txt`


##### Eger yukluyse GNOME ' da gsettings ayarlarini tekrarlamak gerekiyor

if [ -d /etc/gdm3 ]
then
     #### set -i "s/automount=false/automount=true/" /opt/PARDUS/pardus-gnome-settings/pardus.gschema.override
     #### set -i "s/automount-open=false/automount-open=true/" /opt/PARDUS/pardus-gnome-settings/pardus.gschema.override
     /opt/PARDUS/files/pardus_config_gnome.sh
fi


# Install sources.list
rm -f  /etc/apt/sources.list.d/*
cp -f /opt/PARDUS/files/sources.list /etc/apt/sources.list

# Auto login
if [ "$PARDUS_DAGITIM" == "Bireysel" ] 
then
    sh /opt/PARDUS/files/pardus_auto_login.sh
fi


###### Eger degilse GRUB ' i turkcelestirelim
if ! [ -e /boot/grub/locale/tr.mo ]
then
    cp -f /opt/PARDUS/files/tr.mo /boot/grub/locale/
fi


# Remove packages
update-rc.d live-installer remove
DEBS="mint-translations inxi pardus-installer live-boot live-boot-initramfs-tools live-config live-config-sysvinit live-tools rsyslog tasksel tasksel-data"
########## if [ "$PARDUS_DAGITIM" == "Sunucu" ]
########## then
    ########## DEBS=$DEBS" virtualbox-ose-guest-dkms"
########## else 
    ########## DEBS=$DEBS" virtualbox-guest-dkms virtualbox-guest-utils open-vm-dkms"
########## fi
apt-get -y purge $DEBS

# Remove /opt/PARDUS
rm -r -f /opt/PARDUS
rm -r -f /lib/live


# Smolt ' un saglikli calismasi icin 
# cat /proc/sys/kernel/random/uuid > /etc/hw-uuid 

