#!/bin/bash
# Set some environment variables
source /etc/univention/ucr_master

mkdir -p /etc/lightdm/lightdm.conf.d
cat >>/etc/lightdm/lightdm.conf.d/99-hide-guest-userlogin.conf <<__EOF__
[SeatDefaults]
allow-guest=false
__EOF__