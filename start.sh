#!/bin/bash

# Démarrage du serveur web Apache en arrière-plan
/usr/sbin/apache2ctl -D FOREGROUND &

# Démarrage de l'agent Zabbix 2 en arrière-plan
/usr/sbin/zabbix_agent2 -f
