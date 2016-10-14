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

LC_ALL=C
LANG=C
set -o pipefail
set -o nounset
set -o errexit

PROGNAME=$(basename $0)
PROGDIR=$(readlink -m $(dirname $0))

ORN=$(tput setaf 3)
RED=$(tput setaf 1)
BLU=$(tput setaf 4)
GRN=$(tput setaf 40)
CLR=$(tput sgr0)
MNHDR="${BLU}[*]${CLR} "
BDHDR="${RED}[*]${CLR} "
COLHDR="${GRN}[*]${CLR} "

if [[ $(uname) != "Linux" ]]
then
    printf "%s\n" "${RED}Needs Linux${CLR}"
    exit 1
fi

trap 'rm -rf ${TMP_FILE1 ${TMP_FILE2} ; exit' 0 1 2 3 9 15

TMP_FILE1=$(mktemp --tmpdir ${PROGNAME}.$$.XXXXXXXXXX)
TMP_FILE2=$(mktemp --tmpdir ${PROGNAME}.$$.XXXXXXXXXX)

if [[ -r ${PROGNAME}.config ]]
then
    source ${PROGNAME}.config
else
    printf "%s\n" "${PROGNAME}.config not found!!"
fi

# Basic helpers for communication with via IRC protocol
function RECV()
{
    ${ORN}
    echo "< $@" >&2
    ${CLR}
}

function SEND()
{
    ${BLU}
    echo "> $@" >&2;
    printf "%s\r\n" "$@" >&3;
    ${CLR}
}
export -f RECV
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
            SEND "PONG $2"
            continue
            ;;
        "PRIVMSG "*" :"*)
            CHANNEL=$2
            CMD=${3#:}
            ARG=${@:4}
            while IFS= read -r LINE; do
                if [[ ${CMD} == ".aws" ]]
                then
                    aws ec2 describe-instances \
                        --output text \
                        --query 'Reservations[*].Instances[*].[InstanceId,KeyName,InstanceType,State.Name]' > ${TMP_FILE1}
                    cat ${TMP_FILE1} | tr '\t' ' ' | column -t > ${TMP_FILE2}
                    _CNT=1
                    _FCNT=$(wc -l ${TMP_FILE2} | awk '{print$1}')
                    SEND "PRIVMSG ${CHANNEL} :Here is your requested info ${NAME}:"
                    while [[ "${_CNT}" -le "${_FCNT}" ]]
                    do
                        _OUT=$(sed -n ${_CNT}p ${TMP_FILE2})
                        SEND "PRIVMSG ${CHANNEL} :${_OUT}"
                        let _CNT=_CNT+1
                        sleep .25
                    done
                    SEND "PRIVMSG ${CHANNEL} :Here is ARG: ${ARG}"
                fi
            done&
            continue
            ;;
        *)
            continue
            ;;
    esac
done <&3
