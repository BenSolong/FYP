sudo service xrdp stop
sudo apt remove xrdp -y
gsettings set org.gnome.desktop.remote-desktop.rdp enable false
gsettings set org.gnome.desktop.remote-desktop.rdp view-only  false
gsettings set org.gnome.desktop.remote-desktop.rdp enable true
systemctl --user --now enable pipewire.socket
systemctl --user restart gnome-remote-desktop.service
