# audit_dhcp_server
#
# The Dynamic Host Configuration Protocol (DHCP) is a service that allows
# machines to be dynamically assigned IP addresses.
# Unless a server is specifically set up to act as a DHCP server, it is
# recommended that this service be removed.
#
# Turn off dhcp server
#
# Refer to Section(s) 3.5 Page(s) 61-2 CIS CentOS Linux 6 Benchmark v1.0.0
# Refer to Section(s) 3.3 Page(s) 74 CIS Red Hat Linux 5 Benchmark v2.1.0
# Refer to Section(s) 3.5 Page(s) 64-5 CIS Red Hat Linux 6 Benchmark v1.2.0
# Refer to Section(s) 6.4 Page(s) 54-5 SLES 11 Benchmark v1.0.0
#.

audit_dhcp_server () {
  if [ "$os_name" = "SunOS" ]; then
    if [ "$os_version" = "10" ] || [ "$os_version" = "11" ]; then
      funct_verbose_message "DHCP Server"
      service_name="svc:/network/dhcp-server:default"
      funct_service $service_name disabled
    fi
    if [ "$os_name" = "Linux" ]; then
      if [ "$os_vendor" = "CentOS" ] || [ "$os_vendor" = "Red" ]; then
        funct_linux_package uninstall dhcp
      fi
    fi
  fi
}
