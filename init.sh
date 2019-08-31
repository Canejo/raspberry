#plex
sudo apt-get update
sudo apt-get upgrade

sudo apt-get install apt-transport-https
curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -
echo deb https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list
sudo apt-get update
sudo apt-get install plexmediaserver -y
sudo nano /etc/default/plexmediaserver
#No final da última linha do arquivo, mudar o usuário do plex para osmc
#PLEX_MEDIA_SERVER_USER=osmc

sudo service plexmediaserver restart
#acessar a página para configurar o servidor
#http://192.168.0.8:32400/web/index.html

#transmission
sudo apt-get update && sudo apt-get install transmission-daemon -y
sudo systemctl stop transmission-daemon
#acessar arquivo para alterar as configurações
#editar arquivo /etc/transmission-daemon/settings.json
sudo systemctl start transmission-daemon

#samba
sudo apt-get update
sudo apt-get install samba samba-common-bin -y
#editar arquivo /etc/samba/smb.conf
sudo /etc/init.d/samba restart

#flexget
sudo apt-get install python-dev -y
sudo apt-get install python-pip -y
sudo pip install setuptools
sudo pip install flexget
sudo pip install transmissionrpc
sudo mkdir ~/.flexget
sudo nano ~/.flexget/config.yml
sudo chmod +x ~/.flexget/config.yml
sudo flexget --test execute

#cron
sudo apt-get install cron -y
crontab -e
#na última linha colocar
@hourly /usr/local/bin/flexget -c /home/osmc/.flexget/config.yml --cron execute


#SickRage
sudo apt-get update
sudo apt-get install python-pip python-dev git libssl-dev libxslt1-dev libxslt1.1 libxml2-dev libxml2 libssl-dev libffi-dev build-essential -y
sudo pip install pyopenssl
wget http://sourceforge.net/projects/bananapi/files/unrar_5.2.6-1_armhf.deb
sudo dpkg -i unrar_5.2.6-1_armhf.deb
sudo git clone https://github.com/SickRage/SickRage.git /opt/sickrage
sudo chown -R osmc:osmc /opt/sickrage
#testar
#python /opt/sickrage/SickBeard.py
#acessar http://192.168.0.8:8081/
sudo nano /etc/default/sickrage
#Escreva o texto abaixo:
#SR_USER=osmc
#SR_HOME=/opt/sickrage
#SR_DATA=/opt/sickrage
#SR_PIDFILE=/home/osmc/.sickrage.pid

sudo cp /opt/sickrage/runscripts/init.debian /etc/init.d/sickrage
sudo chmod +x /etc/init.d/sickrage
sudo update-rc.d sickrage defaults
sudo groupadd sickrage
sudo chmod 777 -R /opt/sickrage
sudo pip install -r /opt/sickrage/requirements.txt
sudo service sickrage start

#CouchPotato
sudo apt-get update
sudo apt-get install git-core libffi-dev libssl-dev zlib1g-dev libxslt1-dev libxml2-dev python python-pip python-dev build-essential -y
sudo pip install lxml cryptography pyopenssl

