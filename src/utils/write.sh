#!/usr/bin/expect
set timeout -1

set host [lindex $argv 0]
set root [lindex $argv 1]
set password [lindex $argv 2]
set filename [lindex $argv 3]
set file [lindex $argv 4]

spawn ssh $root@$host

expect {
   "yes/no"  { send "yes\r";exp_continue }
   "password:" { send "$password\r" }
}

# expect "]#"
# send "mkdir -m 777 /search/odin/.sh\r"
expect "]#"
send "cd /search/odin/.sh \r"
expect "]#"
send "touch $filename.sh \r"
expect "]#"
send "echo '#!/bin/sh' > $filename.sh \r"
expect "]#"
send "echo -e 'if [[ \$\# == 0 ]] then echo -e' >> $filename.sh\r"
expect "]#"
send "exit \r"
expect eof
