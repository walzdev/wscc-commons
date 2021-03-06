#!/bin/bash
# Set some environment variables (taken from http://docs.software-univention.de/domain-3.2.html)
source /etc/univention/ucr_master

cat >>/usr/share/pam-configs/local_groups <<__EOF__
Name: activate /etc/security/group.conf
Default: yes
Priority: 900
Auth-Type: Primary
Auth:
    required    pam_group.so use_first_pass
__EOF__