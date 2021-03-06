# audit_talk_server
#
# The talk software makes it possible for users to send and receive messages
# across systems through a terminal session. The talk client (allows initiate
# of talk sessions) is installed by default.
# The software presents a security risk as it uses unencrypted protocols for
# communication.
#
# Refer to Section(2) 2.1.10 Page(s) 53-54 CIS CentOS Linux 6 Benchmark v1.0.0
# Refer to Section(s) 2.1.10 Page(s) 61-2 CIS Red Hat Linux 5 Benchmark v2.1.0
# Refer to Section(s) 2.1.10 Page(s) 56 CIS Red Hat Linux 6 Benchmark v1.2.0
# Refer to Section(s) 5.1.5 Page(s) 43 SLES 11 Benchmark v1.0.0
#.

audit_talk_server () {
  if [ "$os_name" = "Linux" ]; then
    if [ "$os_vendor" = "CentOS" ] || [ "$os_vendor" = "Red" ]; then
      funct_verbose_message "Talk Server Daemon"
      funct_linux_package uninstall talk-server
    fi
  fi
}
