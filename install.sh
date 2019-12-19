#!/bin/bash

echo "-- 1/6 -- Vérification mises à jour"
sudo apt-get update && sudo apt-get upgrade -y

echo "-- 2/6 -- Installation serveur graphique"
sudo apt-get install xorg libgtk2.0-0 -y

echo "-- 3/6 -- Installation JRE"
wget -O temp.tar.gz https://download.bell-sw.com/java/13.0.1/bellsoft-jre13.0.1-linux-arm32-vfp-hflt.tar.gz
tar zxvf temp.tar.gz
rm temp.tar.gz

echo "-- 4/6 -- Mise en place .jar"
mkdir Desktop
mv installer/v1.jar Desktop
mv installer/resources Desktop

echo "-- 5/6 -- Demarrage automatique et configuration"
sudo mv installer/rc.local /etc
sudo chmod +x /etc/rc.local
sudo mv installer/Xwrapper.config /etc/X11
sudo mv installer/xinitrc /etc/X11/xinit

echo "-- 6/6 -- Optimisation demarrage"
sudo cp installer/cmdline.txt /boot
sudo cp installer/config.txt /boot

echo "-- Installation terminee"
echo "-- ! Redemarrage !"

currentscript=$0

function finish {
    rm -r installer
    shred -u ${currentscript};
    sudo reboot
}

trap finish EXIT
