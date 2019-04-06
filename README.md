# nmap_to_logstash_docker
docker machine to execute nmap network and vulnerability scan and upload to logstash

Environment variables:
NMAP_ARGS - NMap arguments
SCAN_DESC - Scan description; displays under header.x_nmap_target
LOGSTASH_SERVER - Logstash Server (include protocol and port)
LOGSTASH_USER - Logstash user (optional)
LOGSTASH_PASS - Logstash pass (optional)

Based off python script created here:

Example command to run manually 
nmap -p 80,443 -T4 --script http-methods.nse 10.120.15.1-255 -oX - | python nmap_xml_to_json.py | curl -H "x-nmap-target: COX-HttpScan2" http://cox-logstash:5000 --data-binary @-
