#!/bin/bash

# set -x

STOP_CONT="no"

# handler for term signal
function sighandler_TERM() {
    echo "signal SIGTERM received\n"

    /etc/init.d/cron stop

    STOP_CONT="yes"
}


if [ "$#" -ne 1 ]; then
    echo "usage: <run>"
    echo "commands:"
    echo "    run: Runs postprocess"
    exit 1
fi

if [ "$1" = "run" ]; then

    update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
    export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 

    chown root:root /etc/crontab 
    /etc/init.d/cron start

    echo "wait for terminate signal"
    while [  "$STOP_CONT" = "no"  ] ; do
      sleep 1
    done

    exit 0
fi

echo "invalid command"
exit 1