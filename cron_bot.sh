#!/usr/bin/env bash

## this script is a hack fix for a weird issue where the irc bot keeps getting
## killed off at standard intervals.

set -o nounset

for ITER in $(\
    ps -ef \
    | awk '/irc_bashbot.sh$/ {print $2}')
do
    kill -9 ${ITER}
done

sleep 5

<<<<<<< HEAD
~/git/mine/irc-bashbot/irc_bashbot.sh
=======
cd ~/git/mine/irc-bashbot/
./irc_bashbot.sh
>>>>>>> devwork
