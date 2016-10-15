#!/usr/bin/env bash
#===============================================================================
#
#          FILE:
#
#         USAGE:
#
#   DESCRIPTION:
#
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
main

# Basic helpers for communication with via IRC protocol
function RECV()
{
    echo -n "${ORN}"
    echo "< $@"
    # echo "< $@" >&2
    echo -n "${CLR}"
}

function SEND()
{
    echo -n "${BLU}"
    echo "> $@"
    # echo "> $@" >&2
    printf "%s\r\n" "$@" >&3;
    echo -n "${CLR}"
}
# export -f RECV
export -f SEND

exec 3<>/dev/tcp/${SERVER}/${PORT} \
    || { echo "Could not connect"; exit 1; }

SEND "NICK ${NICK}"
SEND "USER ${NICK} 0 * :${NICK}"
SEND "JOIN ${CHAN} ${CHAN_KEY}"

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
            while true
            do
                SEND "PONG ${_SERVER}"
                sleep 180
            done &
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
