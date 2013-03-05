#!/bin/bash

PATH="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources:${PATH}"

for ssid in $(airport -s | awk '{print $1}' | grep 'ardrone'); do
  current_ssid=$(airport -I | grep ' SSID' | awk '{print $2}')
  echo -e "Disconnecting from $current_ssid\n"
  sudo airport -z
  
  echo "Attempting to connect to $ssid"
  sudo networksetup -setairportnetwork en0 $ssid
  res=$?
  if [ "$?" != "0" ]
  then
    continue
  fi
  echo "Got $ssid"
  sleep 20

  if [ "$1" = "-float" ]
  then
      echo "Floating..."
      for i in {1..10}; do
	telnet=$( netcat -v -n -z -w 1 192.168.1.$i 23 2>&1 )
	echo $telnet
	if [[ $telnet = *open* ]]
	then
	  if [[ $ssid = *200266* ]]
	  then
	    node ./float.js 192.168.1.1 yes &
	  else 
	    node ./float.js 192.168.1.1 &
	  fi
 	  break
	fi
      done
  fi
  node ey-dronage/server.js &
  server_pid=$!
  sleep 5
  open http://localhost:3001
  sleep 30
  kill -9 $server_pid
done


