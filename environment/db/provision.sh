#!/bin/bash

# wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
# echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
# sudo apt-get update
# sudo apt-get install -y mongodb-org
# sudo service mongod start
# sudo service mongod status

# getting keys to gain access to repo
wget -qO - https://www.mongodb.org/static/pgp/server-3.2.asc | sudo apt-key add -
# add mongodb repo details so apt knows where to download the packages. Creates a list file for Mongodb.
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

sudo apt-get update
sudo apt-get install -y mongodb-org=3.2.20 mongodb-org-server=3.2.20 mongodb-org-shell=3.2.20 mongodb-org-mongos=3.2.20 mongodb-org-tools=3.2.20

echo "mongodb-org hold" | sudo dpkg --set-selections
echo "mongodb-org-server hold" | sudo dpkg --set-selections
echo "mongodb-org-shell hold" | sudo dpkg --set-selections
echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
echo "mongodb-org-tools hold" | sudo dpkg --set-selections

sudo rm /etc/mongod.conf
# links foler in VM to another folder in the VM
sudo ln -s /home/ubuntu/environment/mongod.conf /etc/mongod.conf


sudo systemctl restart mongod
# sudo service mongod start
sudo systemctl enable mongod.service
