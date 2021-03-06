# audit_home_perms
#
# While the system administrator can establish secure permissions for users'
# home directories, the users can easily override these.
# Group or world-writable user home directories may enable malicious users to
# steal or modify other users' data or to gain another user's system privileges.
#
# Refer to Section(s) 5.4 Page(s) 51-52 CIS Apple OS X 10.8 Benchmark v1.0.0
# Refer to Section(s) 6.6 Page(s) 22 CIS FreeBSD Benchmark v1.0.5
# Refer to Section(s) 13.7 Page(s) 158-9 SLES 11 Benchmark v1.0.0
# Refer to Section(s) 9.7 Page(s) 77 CIS Solaris 11.1 v1.0.0
# Refer to Section(s) 9.7 Page(s) 121 CIS Solaris 10 v1.1.0
#.

audit_home_perms () {
  if [ "$os_name" = "SunOS" ] || [ "$os_name" = "Linux" ] || [ "$os_name" = "Darwin" ] || [ "$os_name" = "FreeBSD" ]; then
    funct_verbose_message "Home Directory Permissions"
    if [ "$audit_mode" != 2 ]; then
      echo "Checking:  User home directory permissions"
    fi
    check_fail=0
    for home_dir in `cat /etc/passwd |cut -f6 -d":" |grep -v "^/$" |grep "home"`; do
      if [ -d "$home_dir" ]; then
        funct_check_perms $home_dir 0700
      fi
    done
    if [ "$os_name" = "Darwin" ]; then
      funct_check_perms /Users 0700
    fi
  fi
}
