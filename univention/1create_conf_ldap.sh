#!/bin/bash
# Set some environment variables (taken from http://docs.software-univention.de/domain-3.2.html)
source /etc/univention/ucr_master

cat >/etc/ldap/ldap.conf <<__EOF__
TLS_CACERT /etc/univention/ssl/ucsCA/CAcert.pem
URI ldap://$ldap_master:7389
BASE $ldap_base
__EOF__