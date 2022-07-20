#!/bin/bash
#get password from guestinfo and change in 7z script
password=$(vmtoolsd --cmd 'info-get guestinfo.encryptionpwd')
password=${password//$'\n'/}
sed -i "s/##encryptionpwd##/"$password"/g" 7z.ps1
#get username from guestinfo and chagne it in 7z script
username=$(vmtoolsd --cmd 'info-get guestinfo.username')
sed -i "s/##username##/"$username"/g" 7z.ps1
sshpass -p "tartans" ssh -o StrictHostKeyChecking=no Administrator@Host1 "powershell.exe" < 7z.ps1
