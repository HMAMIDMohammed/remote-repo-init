FROM debian:latest

# Installation des dépendances et configuration du serveur web Apache
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y apache2 curl wget && \
    echo "Welcome to my web site" > /var/www/html/index.html

# Installation du dépôt Zabbix
RUN wget https://repo.zabbix.com/zabbix/6.4/debian/pool/main/z/zabbix-release/zabbix-release_6.4-1+debian11_all.deb && \
    dpkg -i zabbix-release_6.4-1+debian11_all.deb && \
    apt-get update

# Installation du Zabbix Agent 2
RUN apt-get install -y zabbix-agent2 zabbix-agent2-plugin-*

# Configuration du Zabbix Agent 2
ENV ZABBIX_SERVER_IP="172.19.34.72"
ENV SERVER_NAME="srv-web"
RUN sed -i "s/127.0.0.1/$ZABBIX_SERVER_IP/g" /etc/zabbix/zabbix_agent2.conf && \
    sed -i "s/Zabbix server/$SERVER_NAME/g" /etc/zabbix/zabbix_agent2.conf

# Redémarrage du Zabbix Agent 2
RUN service zabbix-agent2 restart

# Healthcheck
HEALTHCHECK --interval=1m --timeout=30s --retries=3 CMD curl --fail http://localhost:80 || exit 1

# Exposition des ports
EXPOSE 80
EXPOSE 10050

#Fichier de démarrage

#COPY start.sh /start.sh
#RUN chmod +x /script.sh
#ENTRYPOINT ["/start.sh"]
