#!/bin/bash
			for i in {1..5}; do
			  telnet=$( netcat -v -n -z -w 1 192.168.1.$i 23 2>&1 )
			  echo $telnet
			  if [[ $telnet = *open* ]]
			  then
			    echo "node ./float.js 192.168.1.$i &"
					#node ./float.js 192.168.1.$i &
			  fi
			done
