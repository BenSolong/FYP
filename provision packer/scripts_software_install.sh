#!/bin/bash
sudo apt-get update
# Install PyCharm
sudo snap install pycharm-community --classic #pycharm community ver
sudo snap install pycharm-professional --classic #pycharm professional ver
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
wget https://download3.vmware.com/software/wkst/file/VMware-Workstation-Full-16.2.1-18811642.x86_64.bundle
chmod +x VMware-Workstation-Full-16.2.1-18811642.x86_64.bundle
sudo ./VMware-Workstation-Full-16.2.1-18811642.x86_64.bundle
wget https://github.com/BenSolong/FYP/releases/download/Version1/chatbot-linux-x64.zip
unzip chatbot-linux-x64.zip
chmod +x ./chatbot-linux-x64/chatbot

