FROM kalilinux/kali-linux-docker

ENV container docker

RUN apt-get update -y
RUN apt-get install metasploit-framework -y

RUN mkdir /usr/nmap_logstash

RUN curl https://raw.githubusercontent.com/nateshull/nmap_xml_to_json/master/nmap_xml_to_json.py > /usr/nmap_logstash/nmap_xml_to_json.py

RUN curl https://raw.githubusercontent.com/nateshull/nmap_to_logstash_docker/master/start_script.sh > /usr/nmap_logstash/start_script.sh

ENV DEBUG="false"

ENV NMAP_ARG="-O 10.10.10.0/24 "

ENV LOGSTASH_SERVER="http://logstash:5000"

ENV LOGSTASH_USER=""

ENV LOGSTASH_PASS="Password"

ENV SCAN_DESC="NMapDocker"

RUN chmod -R 777 /usr/nmap_logstash/*

ENTRYPOINT /usr/nmap_logstash/start_script.sh
