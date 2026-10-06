#!/bin/bash 
echo "running script" 

if [ "$LOGSTASH_USER" = "" ] 
then 
	if [ "$DEBUG" == "true" ] 
	then 
		echo "running nmap $NMAP_ARG -oX - | python3 /usr/nmap_logstash/nmap_xml_to_json.py | curl -H "x-nmap-target: $HEADER_INFO" $LOGSTASH_SERVER --data-binary @- " 
		
		nmap $NMAP_ARG -oX - > temp.xml
		echo "************nmap output************"
		cat temp.xml
		cat temp.xml | python3 /usr/nmap_logstash/nmap_xml_to_json.py > temp.json
		echo "************json output************"
		cat temp.json
		echo "************upload to logstash************"
		cat temp.json | curl -H "x-nmap-target: $HEADER_INFO" -H "Content-Type: application/json" $LOGSTASH_SERVER -d @-
	else
		nmap $NMAP_ARG -oX - | python3 /usr/nmap_logstash/nmap_xml_to_json.py | curl -H "x-nmap-target: $SCAN_DESC" -H "Content-Type: application/json" $LOGSTASH_SERVER -d @- 
	fi 
	
else 
	if [ "$DEBUG" == "true" ] 
	then 
		echo "running nmap $NMAP_ARG -oX - | python3 /usr/nmap_logstash/nmap_xml_to_json.py | curl  -u $LOGSTASH_USER:xxxxxxx -H "x-nmap-target: $HEADER_INFO" $LOGSTASH_SERVER --data-binary @- " 
		nmap $NMAP_ARG -oX - > temp.xml
		echo "************nmap output************"
		cat temp.xml
		cat temp.xml | python3 /usr/nmap_logstash/nmap_xml_to_json.py > temp.json
		echo "************json output************"
		cat temp.json
		echo "************upload to logstash************"
		cat temp.json | curl -u $LOGSTASH_USER:$LOGSTASH_PASS -H "x-nmap-target: $SCAN_DESC" $LOGSTASH_SERVER --data-binary @-
	else
		nmap $NMAP_ARG -oX - | python3 /usr/nmap_logstash/nmap_xml_to_json.py | curl -u $LOGSTASH_USER:$LOGSTASH_PASS -H "x-nmap-target: $SCAN_DESC" $LOGSTASH_SERVER --data-binary @- 
	fi 
	
fi 
