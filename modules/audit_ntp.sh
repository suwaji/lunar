# audit_ntp
#
# Network Time Protocol (NTP) is a networking protocol for clock synchronization
# between computer systems.
# Most security mechanisms require network time to be synchronized.
#
# Refer to Section(s) 3.6 Page(s) 62-3 CIS CentOS Linux 6 Benchmark v1.0.0
# Refer to Section(s) 3.6 Page(s) 75-6 CIS Red Hat Linux 5 Benchmark v2.1.0
# Refer to Section(s) 3.6 Page(s) 65-6 CIS Red Hat Linux 6 Benchmark v1.2.0
# Refer to Section(s) 2.4.5.1 Page(s) 35-6 CIS Apple OS X 10.5 Benchmark v1.1.0
# Refer to Section(s) 6.5 Page(s) 55-6 SLES 11 Benchmark v1.0.0
# Refer to Section(s) 1.9.2 Page(s) 16-7 ESX Server 4 Benchmark v1.1.0
#.

audit_ntp () {
  if [ "$os_name" = "SunOS" ] || [ "$os_name" = "Linux" ] || [ "$os_name" = "Darwin" ] || [ "$os_name" = "VMkernel" ]; then
    funct_verbose_message "Network Time Protocol"
    if [ "$os_name" = "SunOS" ]; then
      check_file="/etc/inet/ntp.conf"
      funct_file_value $check_file server space pool.ntp.org hash
      if [ "$os_version" = "10" ] || [ "$os_version" = "11" ]; then
        service_name="svc:/network/ntp4:default"
        funct_service $service_name enabled
      fi
    fi
    if [ "$os_name" = "Darwin" ]; then
      check_file="/private/etc/hostconfig"
      funct_file_value $check_file TIMESYNC eq -YES- hash
      funct_launchctl_check org.ntp.ntpd on
      check_file="/private/etc/ntp.conf"
    fi
    if [ "$os_name" = "VMkernel" ]; then
      service_name="ntpd"
      funct_chkconfig_service $service_name on
      check_file="/etc/ntp.conf"
      funct_append_file $check_file "restrict 127.0.0.1"
    fi
    if [ "$os_name" = "Linux" ]; then
      check_file="/etc/ntp.conf"
      total=`expr $total + 1`
      log_file="ntp.log"
      funct_linux_package check ntp
      if [ "$audit_mode" != 2 ]; then
        echo "Checking:  NTP is enabled"
      fi
      if [ "$package_name" != "ntp" ]; then
        if [ "$audit_mode" = 1 ]; then
          insecure=`expr $insecure + 1`
          echo "Warning:   NTP not enabled [$insecure Warnings]"
        fi
        if [ "$audit_mode" = 0 ]; then
          echo "Setting:   NTP to enabled"
          log_file="$work_dir/$log_file"
          echo "Installed ntp" >> $log_file
          funct_linux_package install ntp
        fi
      else
        if [ "$audit_mode" = 1 ]; then
          secure=`expr $secure + 1`
          echo "Secure:    NTP installed [$secure Passes]"
        fi
        if [ "$audit_mode" = 2 ]; then
          restore_file="$restore_dir/$log_file"
          funct_linux_package restore ntp $restore_file
        fi
      fi
      service_name="ntp"
      funct_chkconfig_service $service_name 3 on
      funct_chkconfig_service $service_name 5 on
      funct_append_file $check_file "restrict default kod nomodify nopeer notrap noquery" hash
      funct_append_file $check_file "restrict -6 default kod nomodify nopeer notrap noquery" hash
      funct_file_value $check_file OPTIONS eq "-u ntp:ntp -p /var/run/ntpd.pid" hash
    fi
    for server_number in `seq 0 3`; do
      ntp_server="$server_number.$country_suffix.pool.ntp.org"
      funct_file_value $check_file server space $ntp_server hash
    done
  fi
}
