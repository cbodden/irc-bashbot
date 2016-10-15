#!/usr/bin/env bash
#===============================================================================
#          FILE: irc_bashbot.sh
#         USAGE: ./irc_bashbot.sh
#   DESCRIPTION: this is an irc bot that accepts commands real time
#       OPTIONS: none so far
#  REQUIREMENTS: determining
#          BUGS: there are some just have not found them yet
#         NOTES:
#        AUTHOR: cesar@pissedoffadmins.com
#  ORGANIZATION: pissedoffadmins.com
#       CREATED: 14 Oct 2016
#      REVISION: 5
#===============================================================================

## sourcing config file
if [[ -e config/irc_bashbot.config ]]
then
    source config/irc_bashbot.config
else
    printf "%s\n" \
        "Config file not found" \
        "Exiting"
    exit 1
fi

## main script elements like TRAP and TEMP_FILE
source core/main.shlib

## SEND && RECV funcs
source core/helpers.shlib
export -f SEND

## NICK, USER, JOIN
source core/connectors.shlib

## main SEND RECV && PONG loop
source core/loop.shlib
export CHANNEL NAME

## calling main funcs
main
connectors
loop
