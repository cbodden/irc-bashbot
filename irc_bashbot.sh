#!/usr/bin/env bash
#===============================================================================
#          FILE: irc_bashbot.sh
#         USAGE: ./irc_bashbot.sh
#   DESCRIPTION: this is an irc bot that accepts commands real time
#       OPTIONS: none so far
#  REQUIREMENTS: decently minimal for now
#          BUGS: there are some just have not found them yet
#         NOTES: better documentation in the README file
#        AUTHOR: cesar@pissedoffadmins.com
#  ORGANIZATION: pissedoffadmins.com
#       CREATED: 14 Oct 2016
#      REVISION: 12
#===============================================================================

## check and source config file
if [[ -e config/irc_bashbot.config ]]
then
    source config/irc_bashbot.config
else
    printf "%s\n" \
        "Config file not found" \
        "Exiting"
    exit 1
fi

## make sure script is running in the background if not force it
_TMPPID="$$"
case $(ps -o stat= -p $$) in
    *+*)
        ## if running in foreground
        exec $0 & disown $!
        kill -9 ${_TMPPID} 2>&1
        ;;
    *)
        ## if running in background
        ;;
esac

## main script elements like TRAP and TEMP_FILE
source core/main.shlib

## logging shlib
source core/logging.shlib

## SEND && RECV funcs
source core/helpers.shlib

## NICK, USER, JOIN
source core/connectors.shlib

## main SEND RECV && PONG loop
source core/loop.shlib

## calling main funcs
main
logging
connectors
loop
