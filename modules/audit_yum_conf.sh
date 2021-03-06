# audit_yum_conf
#
# Make sure GPG checks are enabled for yum so that malicious sofware can not
# be installed.
#
# Refer to Section(s) 1.2.3 Page(s) 32 CIS CentOS Linux 6 Benchmark v1.0.0
# Refer to Section(s) 1.2.3 Page(s) 34 CIS Red Hat Linux 5 Benchmark v2.1.0
# Refer to Section(s) 1.1.3 Page(s) 34 CIS Red Hat Linux 6 Benchmark v1.2.0
#.

audit_yum_conf () {
  if [ "$os_name" = "Linux" ]; then
    if [ "$os_vendor" = "CentOS" ] || [ "$os_vendor" = "Red" ]; then
      funct_verbose_message "Yum Configuration"
      check_file="/etc/yum.conf"
      funct_file_value $check_file gpgcheck eq 1 hash
    fi
  fi
}
