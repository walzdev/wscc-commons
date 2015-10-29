#!/bin/bash
clear
echo -e "\e[38;5;227mPreparing remaster-root\e[0m"
echo ""
echo "Please wait or hit [Control] + C to abort the installation"
echo ""
sek=15
while [ $sek -ge 1 ]
do
   echo -n " => Starting in $sek seconds..."
   echo -n $'\r'
   sleep 1
   sek=$[$sek-1]
done

echo ""
echo -e "\e[38;5;227mUpdate sources list\e[0m"
apt-get update

echo ""
echo -e "\e[38;5;227mInstall updates\e[0m"
# applications thet cause errors in chrooted upgrade. Therefore we install/update it later with the wscc-installer:
# libgdk-pixbuf2.0-0 libgdk-pixbuf2.0-common gir1.2-gdkpixbuf-2.0 gir1.2-gudev-1.0 onboard onboard-data libsystemd-daemon0 libsystemd-journal0 libsystemd-login0 systemd-services libpam-systemd

# tested and works:
apt-get -y install firefox firefox-locale-en thunderbird thunderbird-gnome-support sudo ntpdate openssh-client samba-common samba-common-bin samba-libs smbclient lshw mount apparmor apport apport-gtk bash-completion bind9-host binutils bsdutils dnsutils e2fslibs e2fsprogs libpython3.4 libpython3.4-minimal libpython3.4-stdlib python-samba python-urllib3 python3-apport python3-distupgrade python3-gdbm python3-problem-report python3-software-properties python3-update-manager python3-urllib3 python3.4 python3.4-minimal gvfs gvfs-backends gvfs-bin gvfs-common gvfs-daemons gvfs-fuse gvfs-libs indicator-session irqbalance libapparmor-perl libapparmor1 libbind9-90 libblkid1 libcgmanager0 libcomerr2 libdns100 libegl1-mesa-lts-vivid libexpat1 libfreetype6 libgail-common libgail18 libgbm1 libgbm1-lts-vivid libgl1-mesa-dri-lts-vivid libgl1-mesa-glx-lts-vivid libglapi-mesa-lts-vivid libgles1-mesa-lts-vivid libgles2-mesa-lts-vivid libgtk2.0-0 libgtk2.0-bin libgtk2.0-common libgudev-1.0-0 libhunspell-1.3-0 libicu52 libisc95 libisccc90 libisccfg90 libldap-2.4-2 liblwres90 libminiupnpc8 libmount1 libnm-gtk-common libnm-gtk0 liboxideqt-qmlplugin liboxideqtcore0 liboxideqtquick0 libsmbclient libsnmp-base libsnmp30 libss2 libudev1 libufe-xidgetter0 libuuid1 libwayland-egl1-mesa-lts-vivid libwbclient0 libxatracker2-lts-vivid linux-firmware linux-libc-dev network-manager-gnome oxideqt-codecs software-properties-common software-properties-gtk ssh-askpass-gnome thermald tzdata ubiquity ubiquity-frontend-gtk ubiquity-ubuntu-artwork ubuntu-release-upgrader-core ubuntu-release-upgrader-gtk udev unity-settings-daemon update-manager update-manager-core util-linux uuid-runtime webaccounts-extension-common xserver-xorg-core-lts-vivid xul-ext-ubufox xul-ext-unity xul-ext-webaccounts xul-ext-websites-integration

echo ""
echo -e "\e[38;5;227mRemove games, GDrive, landscape gui installer and ubuntu firefox extension\e[0m"
apt-get -y purge gnomine gnome-mines aisleriot gnome-mahjongg gnome-sudoku landscape-client-ui-install xul-ext-ubufox unity-scope-gdrive

echo ""
echo -e "\e[38;5;227mAutoremoving old dependencies\e[0m"
apt-get -y autoremove

echo ""
echo -e "\e[38;5;227mInstall software we want to use in WSCC\e[0m"
wget http://download.opensuse.org/repositories/isv:ownCloud:desktop/xUbuntu_14.04/Release.key
apt-key add - < Release.key
mkdir -p /usr/share/wscc-commons/apps/owncloud
mv Release.key /usr/share/wscc-commons/apps/owncloud
sh -c "echo 'deb http://download.opensuse.org/repositories/isv:/ownCloud:/desktop/xUbuntu_14.04/ /' >> /etc/apt/sources.list.d/owncloud-client.list"
apt-get update

apt-get -y install numlockx vim owncloud-client
echo "greeter-setup-script=/usr/bin/numlockx on" >> /usr/share/lightdm/lightdm.conf.d/50-unity-greeter.conf

// Used to clean up files from win crap
apt-get install -y dos2unix



## copy whole stuff from remaster/data in appropriate folders
# etc

# lib
cp -v /usr/share/wscc-commons/remaster/data/lib/plymouth/ubuntu_logo.png /lib/plymouth/ubuntu_logo.png
cp -R -v /usr/share/wscc-commons/remaster/data/lib/plymouth/themes/ubuntu-logo/* /lib/plymouth/themes/ubuntu-logo
cp -R -v /usr/share/wscc-commons/remaster/data/lib/plymouth/themes/ubuntu-text/* /lib/plymouth/themes/ubuntu-text

# usr
rm -v /usr/share/backgrounds/*.jpg
cp -R -v /usr/share/wscc-commons/remaster/data/usr/share/backgrounds/* /usr/share/backgrounds
cp -R -v /usr/share/wscc-commons/remaster/data/usr/share/gnome-background-properties/* /usr/share/gnome-background-properties
cp -R -v /usr/share/wscc-commons/remaster/data/usr/share/unity-greeter/* /usr/share/unity-greeter


## clean crap from win
dos2unix /usr/share/wscc-commons/*
dos2unix /usr/share/wscc-commons/configs/*
dos2unix /usr/share/wscc-commons/files/etc/init.d/*
dos2unix /usr/share/wscc-commons/library/*
dos2unix /usr/share/wscc-commons/remaster/*
dos2unix /usr/share/wscc-commons/remaster/data/etc/*
dos2unix /usr/share/wscc-commons/remaster/data/lib/plymouth/themes/ubuntu-logo/*
dos2unix /usr/share/wscc-commons/remaster/data/lib/plymouth/themes/ubuntu-text/*
dos2unix /usr/share/wscc-commons/univention/*
echo ""
echo ""
echo -e "Clean files from win crap: \e[38;5;46m done\e[0m"

echo ""
echo ""
echo -e "Remastering root: \e[38;5;46m done\e[0m"

