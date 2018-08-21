#!/usr/bin/bash

list_cons=`ldm list |egrep -v "N|primary" | awk '{print $4}'`
for i in ${list_cons[@]};do
EX(){
/usr/bin/expect -<<EOD
set timeout 1
log_user 0
spawn telnet 0 $i
expect "Press ~? for control options .." { send "\r" }
log_user 1
expect "login:"
expect eof
EOD
}
TE=$(EX) &>/dev/null
HOST=`echo "$TE"|awk '{print $1}' | tr -d '\n' | tr -d '\r'`
done
for i in ${HOST[@]}; do
echo $i
done
exit 0
