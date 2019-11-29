#!/usr/bin/env bash

# Script to monitor and restart wireless access point when needed

maxPloss=-50 #Maximum percent packet loss before a restart

restart_networking() {
        # Add any commands need to get network back up and running
        #/etc/init.d/networking restart

        #only needed if your running a wireless ap
        python tplink_smartplug.py -c reboot -t 192.168.1.121
        echo $(date -u) $loss "Restarting Plug" >> /plug/log.txt
}

# First make sure we can resolve google, otherwise 'ping -w' would hang
if ! $(host -W5 www.google.com > /dev/null 2>&1); then
        #Make a note in syslog
        logger "wap_check: Network connection is down, restarting network ..."
        restart_networking
        exit
fi

# Initialize to a value that would force a restart

# now ping google for 10 seconds and count packet loss
loss=$( sleep 10 ; ping -q -w10 www.google.com | grep -o "[0-9]*%" | tr -d %) > /dev/null 2>&1

if [ "$loss" -gt "$maxPloss" ]; then
        logger "Packet loss ($loss%) exceeded $maxPloss, restarting network ..."
        restart_networking
fi
