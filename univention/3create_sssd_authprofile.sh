#!/bin/bash
# Set some environment variables (taken from http://docs.software-univention.de/domain-3.2.html)
source /etc/univention/ucr_master

cat >/etc/auth-client-config/profile.d/sss <<__EOF__
[sss]
nss_passwd=   passwd:   compat sss
nss_group=    group:    compat sss
nss_shadow=   shadow:   compat
nss_netgroup= netgroup: nis

pam_auth=
    auth [success=3 default=ignore] pam_unix.so nullok_secure try_first_pass
    auth requisite pam_succeed_if.so uid >= 500 quiet
    auth [success=1 default=ignore] pam_sss.so use_first_pass
    auth requisite pam_deny.so
    auth required pam_permit.so

pam_account=
    account required pam_unix.so
    account sufficient pam_localuser.so
    account sufficient pam_succeed_if.so uid < 500 quiet
    account [default=bad success=ok user_unknown=ignore] pam_sss.so
    account required pam_permit.so

pam_password=
    password sufficient pam_unix.so obscure sha512
    password sufficient pam_sss.so use_authtok
    password required pam_deny.so

pam_session=
    session required pam_mkhomedir.so skel=/etc/skel/ umask=0077
    session optional pam_keyinit.so revoke
    session required pam_limits.so
    session [success=1 default=ignore] pam_sss.so
    session required pam_unix.so
__EOF__