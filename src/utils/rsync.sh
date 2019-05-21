#!/usr/bin/expect
set timeout -1

set host [lindex $argv 0]
set root [lindex $argv 1]
set password [lindex $argv 2]
set path [lindex $argv 3]

spawn rsync -rva --delete .temp/target/ $root@$host:$path

expect {
   "yes/no"  { send "yes\r";exp_continue }
   "password:" { send "$password\r" }
}

expect {
   "rsync error" { exit 1 }
}
