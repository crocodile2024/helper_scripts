#!/bin/bash

# Paketlisten aktualisieren und Updates installieren
echo "Aktualisiere Paketlisten..."
sudo apt-get update -y

echo "Installiere verfügbare Updates..."
sudo apt-get upgrade -y

# fail2ban installieren
echo "Installiere fail2ban..."
sudo apt-get install fail2ban -y

# fail2ban konfigurieren
echo "Konfiguriere fail2ban für SSH..."
sudo bash -c 'cat << EOF > /etc/fail2ban/jail.local
[sshd]
enabled = true
port = ssh
logpath = %(sshd_log)s
backend = %(sshd_backend)s
EOF'

# fail2ban Dienst neu starten, um die Konfiguration zu übernehmen
echo "Starte fail2ban neu..."
sudo systemctl restart fail2ban

# Überprüfen, ob fail2ban läuft
echo "Überprüfen, ob fail2ban läuft..."
sudo systemctl status fail2ban

echo "Skript abgeschlossen."
