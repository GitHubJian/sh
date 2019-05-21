#!/usr/bin/expect
set timeout -1

set host [lindex $argv 0]
set root [lindex $argv 1]
set password [lindex $argv 2]
set filename [lindex $argv 3]
set path [lindex $argv 4]
set branch [lindex $argv 5]
set tag [lindex $argv 6]

spawn ssh $root@$host

expect {
   "yes/no"  { send "yes\r";exp_continue }
   "password:" { send "$password\r" }
}

expect "*]#*" { 
  send "sh /search/odin/.sh/$filename $path $branch $tag \r"
}

expect {
  "tag '$tag'" {
    send "exit 1"
  }
  "tag]*$tag -> $tag" {
    send_user "Create tag is success -> $tag"
    send "exit 1"
  }
}

expect "*]#*" send "exit 1"

