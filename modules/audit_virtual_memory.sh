# audit_virtual_memory
#
# Set the system flag to force randomized virtual memory region placement.
#
# Randomly placing virtual memory regions will make it difficult for to write
# memory page exploits as the memory placement will be consistently shifting.
#
# Refer to Section(s) 1.6.3 Page(s) 46 CIS CentOS Linux 6 Benchmark v1.0.0
# Refer to Section(s) 1.6.3 Page(s) 51-2 CIS Red Hat Linux 5 Benchmark v2.1.0
# Refer to Section(s) 1.6.3 Page(s) 48-9 CIS Red Hat Linux 6 Benchmark v1.2.0
# Refer to Section(s) 4.3 Page(s) 37 SLES 11 Benchmark v1.0.0
#.

audit_virtual_memory () {
  if [ "$os_name" = "Linux" ]; then
    funt_verbose_message "Randomised Virtual Memory Region Placement"
    if [ "$os_vendor" = "CentOS" ] || [ "$os_vendor" = "Red" ]; then
      if [ "$os_version" > "5" ]; then
        check_file="/etc/sysctl.conf"
        funct_file_value $check_file kernel.randomize_va_space eq 2 hash
      fi
    fi
  fi
}
