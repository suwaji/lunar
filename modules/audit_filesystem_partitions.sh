# audit_filesystem_partitions
#
# Check filesystems are on separate partitions
#
# Refer to Section(s) 1.1.1,5,7,8,9 Page(s) 14-21 CIS CentOS Linux 6 Benchmark v1.0.0
# Refer to Section(s) 1.1.1,5,7,8,9 Page(s) 15-22 CIS Red Hat Linux 5 Benchmark v2.1.0
# Refer to Section(s) 1.1.1,5,7,8,9 Page(s) 18-26 CIS Red Hat Linux 6 Benchmark v1.0.0
# Refer to Section(s) 2.1,5,7,8,9 Page(s) 14-21 SLES 11 Benchmark v1.2.0
#.

audit_filesystem_partitions() {
  if [ "$os_name" = "Linux" ]; then
    for filesystem in /tmp /var /var/log /var/log/audit /home; do
      funct_verbose_message "Filesystem $filesystem is a separate partition"
      mount_test=`mount |awk '{print $3}' |grep "^filesystem$"`
      if [ "$mount_test" != "$filesystem" ]; then
        if [ "$audit_mode" != "2" ]; then
          if [ "$audit_mode" = 1 ] || [ "$audit_mode" = 0 ]; then
            insecure=`expr $insecure + 1`
            echo "Warning:   Filesystem $filesystem is not a separate partition [$insecure Warnings]"
          fi
        else
          if [ "$audit_mode" = 1 ]; then
            secure=`expr $secure + 1`
            echo "Secure:    Filesystem $filesystem is a separate filesystem [$secure Passes]"
          fi
        fi
      fi
    done
  fi
}
