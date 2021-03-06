#!/bin/bash

# kab1exscr1pt v.0.3

# Script collection to help with installation and deployment of software packages


if [ "$(id -u)" != "0" ]; then
	echo "You need to execute this tool as root. Try with sudo kab1exscr1pt"
	echo " Tienes que ejecutar esta herramienta como root. Pruebe otra vez con sudo kab1exscr1pt"
	exit 1
fi


clear
sudo mkdir -p /var/log/kab1exscr1pt
echo "kab1exscr1pt v.0.3 for Ubuntu 14.04 LTS"
echo ""
echo "Select software package to install / Seleccione software para instalar"
echo ""
echo "1. Update System"
echo "2. TeamViewer 10"
echo "3. Sopcast Player"
echo "4. Spotify"
echo "5. AceStream"
echo "6. Dropbox"
echo "7. Google Chrome"

echo ""
echo "Enter the package name"
read NUM


case $NUM in


	1)
		echo ""
		echo "Updating package list..."
		apt-get update 
		echo "Updating system...Please wait..."
		apt-get dist-upgrade -y 
		;;
	2)
		echo "Downloading TeamViewer..."
		mkdir -p /tmp/teamviewer 
		wget http://download.teamviewer.com/download/teamviewer_i386.deb -O /tmp/teamviewer/teamviewer.dpkg  >> /var/log/kab1exscr1pt/teamviewerinstall.log  
		echo "Configuring system..."
		dpkg --add-architecture i386  >> /var/log/kab1exscr1pt/teamviewerinstall.log 
		apt-get update >> /var/log/kab1exscr1pt/teamviewerinstall.log 
		echo "Installing Teamviewer..."
		dpkg -i /tmp/teamviewer/teamviewer.dpkg  
		apt-get -f install -y 
	;;

	3)
		add-apt-repository ppa:venerix/pkg -y
		apt-get update
		apt-get install sp-auth build-essential python-glade2 vlc -y
		wget http://sopcast-player.googlecode.com/files/sopcast-player-0.8.5.tar.gz -O /tmp/sopcastplayer.tar.gz
		mkdir -p /tmp/sopcastplayer
		tar zxvf /tmp/sopcastplayer.tar.gz -C /tmp/
		cd /tmp/sopcast-player
		make
		make install
		;;
	4)
		echo "deb http://repository.spotify.com stable non-free" >> /etc/apt/sources.list
		apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 94558F59
		apt-get update && apt-get install spotify-client -y
		;;

	5)
		echo "deb http://repo.acestream.org/ubuntu/ trusty main" >> /etc/apt/sources.list
		wget -O - http://repo.acestream.org/keys/acestream.public.key | sudo apt-key add -
		apt-get update
		apt-get install acestream-full -y
		;;
		
	6)
		wget https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2015.02.12_amd64.deb -O /tmp/dropbox.deb
		dpkg -i /tmp/dropbox.deb
		apt-get -f install -y
		;;
	7)
		wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/chrome.deb
		dpkg -i /tmp/chrome.deb
		apt-get -f install -y
		;;
esac
