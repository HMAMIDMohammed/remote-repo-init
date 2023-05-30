# Dockerfile to create a Ubuntu webserver

FROM debian:latest

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y apache2 curl wget
RUN echo "Welcome to my web site" > /var/www/html/index.html
RUN wget https://repo.zabbix.com/zabbix/6.4/debian/pool/main/z/zabbix-release/zabbix-release_6.4-1+debian11_all.deb
RUN dpkg -i zabbix-release_6.4-1+debian11_all.deb
RUN apt update
RUN apt install zabbix-agent2 zabbix-agent2-plugin-*
RUN echo "Server=172.19.34.72" >> /etc/zabbix/zabbix_agentd.conf
RUN echo "ServerActive=172.19.34.72" >> /etc/zabbix/zabbix_agentd.conf
RUN service zabbix-agent2 restart

HEALTHCHECK --interval=1m --timeout=30s --retries=3 CMD curl --fail http://localhost:80 || exit 1



#test

