# Download the required extension
sudo apt install libsecret-1-dev -y
sudo apt install gcc -y

# Ask user what login name/pw they want to use
echo "Please create credentials to allow access by others:"
read -p 'Remote Desktop access username: ' rdpuser
read -p 'Remote Desktop access password (only letters and/or numbers!): ' rdppw
echo "Your username/password will be $rdpuser/$rdppw."
read -p "A self-signed certificate is required and will be created. Hit [ENTER] to start and prepare to answer questions for the certificate." 

# Download the code snippet that generates RDP credentials
wget -O ./grd_rdp_credentials.c https://gitlab.gnome.org/-/snippets/1778/raw/master/grd_rdp_credentials.c
# Compile the file
gcc grd_rdp_credentials.c `pkg-config --libs --cflags libsecret-1`
# Use the program to store the credentials via libsecret
./a.out $rdpuser $rdppw

# Create the server certificate and private keyfile
openssl genrsa -out tls.key 4096
openssl req -new -key tls.key -out tls.csr
openssl x509 -req -days 730 -signkey tls.key -in tls.csr -out tls.crt

# Move the certificate and keyfile to a better location
mkdir ./.config/remote-desktop
mv ./tls.key ./.config/remote-desktop/tls.key
mv ./tls.crt ./.config/remote-desktop/tls.crt

# Set the location of the two files
dconf write /org/gnome/desktop/remote-desktop/rdp/tls-key "'./.config/remote-desktop/tls.key'" 
dconf write /org/gnome/desktop/remote-desktop/rdp/tls-cert "'./.config/remote-desktop/tls.crt'"

# Cleanup
rm ./tls.csr
rm ./a.out
rm ./grd_rdp_credentials.c

gsettings set org.gnome.desktop.remote-desktop.rdp view-only  false    

echo "RDP credentials configured. You can now sign in with the new credentials."
