#!/bin/bash

# prepare gitlab config
mv /tmp/gitlab.rb /etc/gitlab/gitlab.rb 
# run the configure
gitlab-ctl reconfigure >/dev/null 2>&1 &
# capture reconfigure pid id $last_pid
last_pid=$!
# sleep for config to complete
sleep 150 
# seeding db
echo yes | /usr/bin/gitlab-rake gitlab:setup
# removing process tree
/usr/local/bin/killtree.sh $last_pid kill >/dev/null 2>&1 &