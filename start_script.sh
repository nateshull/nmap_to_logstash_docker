#!/bin/bash 
echo "running script" 

if [ "$LOGSTASH_USER" = "" ] 
then 
	if [ "$DEBUG" == "true" ] 
	then 
		echo "running nmap $NMAP_ARG -oX - | python3 /usr/nmap_logstash/nmap_xml_to_json.py | curl -H "x-nmap-target: $HEADER_INFO" $LOGSTASH_SERVER --data-binary @- " 
	fi 
	nmap $NMAP_ARG -oX - | python3 /usr/nmap_logstash/nmap_xml_to_json.py | curl -H "x-nmap-target: $SCAN_DESC" $LOGSTASH_SERVER --data-binary @- 
else 
	if [ "$DEBUG" == "true" ] 
	then 
		echo "running nmap $NMAP_ARG -oX - | python3 /usr/nmap_logstash/nmap_xml_to_json.py | curl  -u $LOGSTASH_USER:xxxxxxx -H "x-nmap-target: $HEADER_INFO" $LOGSTASH_SERVER --data-binary @- " 
	fi 
	nmap $NMAP_ARG -oX - | python3 /usr/nmap_logstash/nmap_xml_to_json.py | curl -u $LOGSTASH_USER:$LOGSTASH_PASS -H "x-nmap-target: $SCAN_DESC" $LOGSTASH_SERVER --data-binary @- 
fi 
