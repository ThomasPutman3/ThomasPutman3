#!/bin/sh

#replace password in text files

vmtoolsd --cmd "info-get guestinfo.passwordtoken" > /home/user/Desktop/password.txt
vmtoolsd --cmd "info-get guestinfo.secrettoken" > /home/user/Desktop/secret.txt
vmtoolsd --cmd "info-get guestinfo.logintoken" > /home/user/Desktop/login.txt

vmtoolsd --cmd "info-get guestinfo.finaltoken" > /home/jails/token.txt
#get password buffer size from guestinfo and replace in buffer.c ##passwordbuff##

passbuff=$(vmtoolsd --cmd "info-get guestinfo.passwordbuff")
sed -i "s/##passwordbuff##/"$passbuff"/g" /home/user/Desktop/buffer.c

#get username buffer size from guestinfo and replace in buffer.c ##usernamebuff##

userbuff=$(vmtoolsd --cmd "info-get guestinfo.usernamebuff")
sed -i "s/##usernamebuff##/"$userbuff"/g" /home/user/Desktop/buffer.c

#get password input buffer size from guestinfo and replace in buffer.c ##inputbuff##

inpbuff=$(vmtoolsd --cmd "info-get guestinfo.inputbuff")
sed -i "s/##inputbuff##/"$inpbuff"/g" /home/user/Desktop/buffer.c

#all variables are now replaced (buffer.c should have numbers in the buffer size instead of variables)

#recompile buffer.c into a new program with gcc

gcc -m32 -z execstack -fno-stack-protector -o /home/jails/buffer /home/user/Desktop/buffer.c
