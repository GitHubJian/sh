#!/usr/bin/expect
set timeout -1

set host [lindex $argv 0]
set root [lindex $argv 1]
set password [lindex $argv 2]
set shellPath [lindex $argv 3]
set projectPath [lindex $argv 4]
set tag [lindex $argv 5]

spawn ssh $root@$host

expect {
   "yes/no"  { send "yes\r";exp_continue }
   "password:" { send "$password\r" }
}

expect "*]#*" { 
  send "sh $shellPath/online.batch.sh $shellPath $projectPath $tag \r"
}

expect {
  "batch online complete" {
    send "exit 1"
  }
}
