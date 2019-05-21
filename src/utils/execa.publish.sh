#!/usr/bin/expect
set timeout -1

set host [lindex $argv 0]
set root [lindex $argv 1]
set password [lindex $argv 2]
set shellPath [lindex $argv 3]
set projectPath [lindex $argv 4]
set pm2 [lindex $argv 5]
set branch [lindex $argv 6]
set tag [lindex $argv 7]

spawn ssh $root@$host

expect {
   "yes/no"  { send "yes\r";exp_continue }
   "password:" { send "$password\r" }
}

expect "*]#*" { 
  send "sh $shellPath/publish.sh $projectPath $pm2 $branch $tag \r"
}

expect {
  "release success by $tag" {
    send "exit 1"
  }
}
