-- Automatic Reboot of HS100 --

Is a Simple Script which works with TP-Link devices and reboots the smart plug if internet is having issues. 

in the Plug.sh file you need to change the ip to match yours at home.

python tplink_smartplug.py -c reboot -t 192.168.1.121

also you will need to change the log file destination

echo $(date -u) $loss "Restarting Plug" >> /plug/log.txt
 
then you will need to add it to cron
  

