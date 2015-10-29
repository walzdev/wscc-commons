#!/bin/bash
# Set some environment variables (taken from http://docs.software-univention.de/domain-3.2.html)
source /etc/univention/ucr_master

cat >/usr/share/pam-configs/ucs_mkhomedir <<__EOF__
Name: activate mkhomedir
Default: yes
Priority: 900
Session-Type: Additional
Session:
    required    pam_mkhomedir.so umask=0022 skel=/etc/skel
__EOF__