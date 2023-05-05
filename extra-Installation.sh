# Installation of our ChatGPT chatbox.
sudo wget -P ./Downloads https://github.com/BenSolong/FYP/releases/download/Version1.1/chatbot-linux-x64.zip
sudo unzip ./Downloads/chatbot-linux-x64.zip -d ./Desktop
sudo chmod +x ./Desktop/chatbot-linux-x64/chatbot


# Installation of Google Chrome.
sudo wget -P ./Downloads https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i ./Downloads/google-chrome-stable_current_amd64.deb

# Installation of VScode.
sudo snap install --classic code

# Installation of PyCharm.
sudo snap install pycharm-community --classic

# Desktop Optimization
sudo apt install gnome-tweaks -y
sudo apt install gnome-shell-extensions -y
gnome-extensions enable ding@rastersoft.com
gnome-extensions enable ubuntu-appindicators@ubuntu.com
gnome-extensions enable ubuntu-dock@ubuntu.com
