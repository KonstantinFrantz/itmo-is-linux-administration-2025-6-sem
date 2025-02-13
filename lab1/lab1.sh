#!/bin/bash

# 1
while IFS=: read -r line; do
  username=$(echo "$line" | cut -d : -f1)
  uid=$(echo "$line" | cut -d : -f3)
  echo "user $username has id $uid" >>work3.log
done </etc/passwd

# 2
last_change=$(chage -l root | grep "Последний раз пароль был изменён" | cut -d : -f2)
echo "$last_change" >>work3.log

# 3
groups=$(cut -d: -f1 /etc/group | tr '\n' ',' | sed 's/,$/\n/')
echo "$groups" >>work3.log

# 4
echo "Be careful!" >/etc/skel/readme.txt

# 5
useradd -m -p "$(openssl passwd -6 -salt "is_itmo" "12345678")" u1

# 6
groupadd g1

# 7
usermod -aG g1 u1

# 8
u1_info=$(id u1)
echo "$u1_info" >>work3.log

# 9
usermod -aG g1 myuser

# 10
g1_users=$(grep "g1" /etc/group | cut -d: -f4)
echo "$g1_users" >>work3.log

# 11
usermod -s /usr/bin/mc u1

# 12
useradd -m -p "$(openssl passwd -6 -salt "itmo_is" "87654321")" u2

# 13
mkdir -p /home/test13
cp work3.log /home/test13/work3-1.log
cp work3.log /home/test13/work3-2.log

# 14
usermod -aG u1 u2
chown -R u1:u1 /home/test13
chmod 750 /home/test13
chmod 640 /home/test13/*

# 15
mkdir -p /home/test14
chown u1:u1 /home/test14
chmod +t /home/test14

# 16
cp "$(which nano)" /home/test14/
chmod u+s /home/test14/nano

# 17
mkdir -p /home/test15
touch /home/test15/secret_file
chmod 111 /home/test15
chmod 444 /home/test15/secret_file

# 18
echo "u1 ALL=(root) /usr/bin/passwd" >/etc/sudoers.d/u1
chmod 440 /etc/sudoers.d/u1
