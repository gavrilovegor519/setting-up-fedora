#!/bin/bash

wget https://dl.pstmn.io/download/latest/linux64 -O /tmp/postman-linux-x64.tar.gz
sudo tar xvzf /tmp/postman-linux-x64.tar.gz -C /opt
rm /tmp/postman-linux-x64.tar.gz

cat << EOF > ~/.local/share/applications/Postman.desktop
[Desktop Entry]
Encoding=UTF-8
Name=Postman
Exec=/opt/Postman/app/Postman %U
Icon=/opt/Postman/app/resources/app/assets/icon.png
Terminal=false
Type=Application
Categories=Development;
EOF
