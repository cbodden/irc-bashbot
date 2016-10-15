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

source aws_irc_bashbot.config
source core/main.shlib
source core/helpers.shlib
source core/connectors.shlib

main
connectors

CHANNEL=
NAME=
export CHANNEL NAME

while read -r LINE
do
    # strip trailing carriage return
    LINE=${LINE%%$'\r'}

    RECV "$LINE"
    set -- $LINE

    case "$1" in
        :*)
            # turn: :nickname!example.host.com into: nickname
            NAME=${1%%!*}
            NAME=${NAME#:}
            shift
            ;;
    esac

    case "$@" in
        "PING "*)
            _SERVER="$2"
                SEND "PONG ${_SERVER}"
            continue
            ;;
        "PRIVMSG "*" :"*)
            CHANNEL=$2
            CMD=${3#:}
            ARG=${@:4}
            if [[ ${CMD} = .* ]]
            then
                if [[ ${CMD} == ".aws" ]]
                then
                    source lib/aws.shlib
                    .aws
                fi
            fi
            continue
            ;;
        *)
            continue
            ;;
    esac
done <&3
