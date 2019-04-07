#!/bin/bash 
echo "running script" 
if [ "$DEBUG" == "true" ] 
then 
	echo "running nmap $NMAP_ARG -oX - | python3 /usr/nmap_logstash/nmap_xml_to_json.py | curl -H "x-nmap-target: $HEADER_INFO" http://$LOGSTASH_SERVER:$LOGSTASH_PORT --data-binary @- " 
fi 
if [ "$LOGSTASH_USER" = "" ] 
then 
	nmap $NMAP_ARG -oX - | python3 /usr/nmap_logstash/nmap_xml_to_json.py | curl -H "x-nmap-target: $SCAN_DESC" $LOGSTASH_SERVER --data-binary @- 
else 
	nmap $NMAP_ARG -oX - | python3 /usr/nmap_logstash/nmap_xml_to_json.py | curl -u $LOGSTASH_USER:$LOGSTASH_PASS -H "x-nmap-target: $SCAN_DESC" $LOGSTASH_SERVER --data-binary @- 
fi 
