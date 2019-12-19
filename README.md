# Provisioning Lab - MongoDBEnv

## Aims
- To create a provisioning script that will create a server with a mongodb
database. This includes:
  - Installing a mongodb server on my server
  - Configuring the mongodb server
  - Writing the steps in a provisioning scripts to automate the setup process

## Installing the MongoDB server
- Create a db folder in the environment folder
- Create a provision.sh file in the db file
- input into the provision.sh file: ``wget -qO - https://www.mongodb.org/static/pgp/server-3.2.asc | sudo apt-key add -``
  - This gets the public keys in order to gain access to the MongoDB repo
- input into the provision.sh file: ``echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list ``
  -  This creates a list file for MongoDB and adds MongoDB repo details so apt knows where to download the packages.
- Input into provisions.sh :
````
sudo apt-get update
sudo apt-get install -y mongodb-org=3.2.20 mongodb-org-server=3.2.20 mongodb-org-shell=3.2.20 mongodb-org-mongos=3.2.20 mongodb-org-tools=3.2.20
````
  - This reloads the local package database and installs the specific version of MongoDB needed, in this case version 3.2.20
- Then input:
````
echo "mongodb-org hold" | sudo dpkg --set-selections
echo "mongodb-org-server hold" | sudo dpkg --set-selections
echo "mongodb-org-shell hold" | sudo dpkg --set-selections
echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
echo "mongodb-org-tools hold" | sudo dpkg --set-selections
````
  - This pins a specific version of MongoDB so that the packages won't update when a newer version becomes available

## Configuring the MongoDB server
- In order to change the IP address of the server you need to first create a mongod.conf file in the local-host machine.
- You can then sync this created folder with a folder in the VM
- By changing the IP of the synced folder in the local-host machine, the IP will then also be changed in the VM.
To create the mongod.conf file in the host machine, you can ``vagrant ssh`` on the host terminal to get into the VM and then run ``cat /etc/mongod.conf`` on the VM. You can then copy the contents of this file and paste it into a file which you create on the local machine. Then change the IP on the host machine file which will change the IP on the associated synced file.
````
config.vm.synced_folder "environment/db", "/home/ubuntu/environment"
````
Now on the VM terminal, link the synced_folder with the mongod.conf file, so that the IP on the mongod.conf file will be changed. Ensure to remove the mongod.config file first:
````
sudo rm /etc/mongod.conf
sudo ln -s /home/ubuntu/environment/mongod.conf /etc/mongod.conf
````
For the change to take effect restart mongod:
````
sudo systemctl restart mongod
````
