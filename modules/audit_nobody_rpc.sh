# audit_nobody_rpc
#
# The keyserv process, if enabled, stores user keys that are utilized with
# Sun's Secure RPC mechanism.
# The action listed prevents keyserv from using default keys for the nobody
# user, effectively stopping this user from accessing information via Secure
# RPC.
#
# Refer to Section(s) 6.2 Page(s) 47 CIS Solaris 11.1 v1.0.0
# Refer to Section(s) 6.3 Page(s) 88 CIS Solaris 10 v5.1.0
#.

audit_nobody_rpc () {
  if [ "$os_name" = "SunOS" ]; then
    if [ "$os_version" = "10" ]; then
      funct_verbose_message "Nobody Access for RPC Encryption Key Storage Service"
      check_file="/etc/default/keyserv"
      funct_file_value $check_file ENABLE_NOBODY_KEYS eq NO hash
    fi
  fi
}
