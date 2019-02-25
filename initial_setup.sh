#Linux Mint 19.1 Tessa
sudo apt-get install build-essential checkinstall -y
sudo apt-get install libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev -y

sudo cd /usr/src
sudo wget https://www.python.org/ftp/python/3.6.6/Python-3.6.6.tgz

sudo tar xzf Python-3.6.6.tgz
sudo cd Python-3.6.6
sudo ./configure --enable-optimizations
sudo make altinstall

sudo apt-get install python3-venv -y
python3.6 source ./env/bin/activate 

python3.6 -m venv env
python3.6 source ./env/bin/activate 

sudo python3.6 -m pip install discord.py
sudo python3.6 -m pip install giphy_client
sudo python3.6 -m pip install mysql-connector

#
#https://discordapp.com/oauth2/authorize?client_id=487618066172084225&scope=bot
#-----
#TIC TAC TOE
#link shortner
#custom prefix
#------
# /etc/init.d/mysql start
# /etc/init.d/mysql stop
# /etc/init.d/mysql restart
