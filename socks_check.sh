#!/bin/bash

SCRIPT_DIR="$(cd "$( dirname "$0" )" && pwd)"
SOCKS=$(cat $SCRIPT_DIR/socks.chk)
OUTFILE=$SCRIPT_DIR"/socks.lst"

ATTEMPTS=5
SCORES=3
TIMEOUT=2
MAXTIME=5

SITE=$1
while [ -z $SITE ]; do
    echo
    echo -n "Enter site: " 
        read SITE
done

echo $(date '+%Y.%m.%d %H:%M:%S')" checking socks servers on site "$SITE
echo $(date '+%Y.%m.%d %H:%M:%S')

echo -n > $OUTFILE

for SOCK in $SOCKS
do
    echo `date '+%Y.%m.%d %H:%M:%S'`" checking sock: "$SOCK
    CHK=0
    for ((i=1;i<=$ATTEMPTS;i++));
    do
        HTML=
        HTML=$(curl -L -x socks5://$SOCK// -s --max-time $MAXTIME --connect-timeout $TIMEOUT $SITE)
        CURLSTATUS=$(echo $?)
        if [[ $CURLSTATUS -eq 0  && $(echo $HTML | wc -m) -gt 1000 ]]; then
            ((CHK++))
        fi
        echo $(date '+%Y.%m.%d %H:%M:%S')"     curl status: "$CURLSTATUS"    bytes: "$(echo $HTML | wc -m)"    scores: "$CHK
        if [[ $((ATTEMPTS - i)) -lt $((SCORES - CHK)) ]]; then
            echo `date '+%Y.%m.%d %H:%M:%S'`"     $(tput setaf 1)$(tput bold)low score, breaking$(tput sgr 0)"
            break
        fi
        if [[ $CHK -ge $SCORES ]]; then
            break
        fi
    done
    if [[ $CHK -ge $SCORES ]]; then
        echo $SOCK >> $OUTFILE
        echo $(date '+%Y.%m.%d %H:%M:%S')"     $(tput setaf 2)$(tput bold)good sock found$(tput sgr 0)"
    fi
done

echo $(date '+%Y.%m.%d %H:%M:%S')
echo $(date '+%Y.%m.%d %H:%M:%S')" checking done, socks found: "$(cat $OUTFILE | wc -l)
echo
