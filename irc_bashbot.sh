#!/usr/bin/env bash
#===============================================================================
#          FILE:
#         USAGE:
#   DESCRIPTION:
#       OPTIONS:
#  REQUIREMENTS:
#          BUGS:
#         NOTES:
#        AUTHOR: cesar@pissedoffadmins.com
#  ORGANIZATION: pissedoffadmins.com
#       CREATED: 14 Oct 2016
#      REVISION: 1
#===============================================================================

## sourcing config file
source config/irc_bashbot.config

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
