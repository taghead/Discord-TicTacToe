#!/bin/sh
    if [ "$1" == "--ignore" ]
    then
        echo " Ignoring root user status"
    elif [[ $EUID == 0 ]]
    then
        echo """ 
        The script runs optimally as a root user. Please run as root or sudo.
        If you wish to ignore this and proceed use --ignore as the first flag.
        """
        exit 1
    fi


# Environemnt variables required
# DISCORDTOKEN 	- Contains discord bot api token
# GIPHYTOKEN 	- Contains giphy api token
# PREFIX        - Bot prefix
# SQLHOST 	    - Contains SQL host ip
# SQLUSER	    - Contains username for SQL Database
# SQLPASS	    - Contains password for SQL Database
# SQLDATABASE	- Contains database name

if [ -z ${DISCORDTOKEN+x} ]; 
then 
    echo "DISCORDTOKEN is unset... setting DISCORDTOKEN to default";
    DISCORDTOKEN="input(\"Discord Bot Token:\")"; 
else 
    echo "DISCORDTOKEN is set to '$DISCORDTOKEN'";
fi

if [ -z ${GIPHYTOKEN+x} ]; 
then 
    echo "GIPHYTOKEN is unset... setting GIPHYTOKEN to default";
    GIPHYTOKEN="input(\"Giphy Token:\")"; 
else 
    echo "GIPHYTOKEN is set to '$GIPHYTOKEN'";
fi

if [ -z ${PREFIX+x} ]; 
then 
    echo "PREFIX is unset... setting PREFIX to default";
    PREFIX="\"@ZN\""; 
else 
    echo "PREFIX is set to '$PREFIX'";
fi

if [ -z ${SQLHOST+x} ]; 
then 
    echo "SQLHOST is unset... setting SQLHOST to default";
    SQLHOST="\"localhost\""; 
else 
    echo "SQLHOST is set to '$SQLHOST'";
fi

if [ -z ${SQLUSER+x} ]; 
then 
    echo "SQLUSER is unset... setting SQLUSER to default";
    SQLUSER="\"normalUser\""; 
else 
    echo "SQLUSER is set to '$SQLUSER'";
fi

if [ -z ${SQLPASS+x} ]; 
then 
    echo "SQLPASS is unset... setting SQLPASS to default";
    SQLPASS="\"1234\""; 
else 
    echo "SQLPASS is set to '$SQLPASS'";
fi

if [ -z ${SQLDATABASE+x} ]; 
then 
    echo "SQLDATABASE is unset... setting SQLDATABASE to default";
    SQLDATABASE="\"practice\""; 
else 
    echo "SQLDATABASE is set to '$SQLDATABASE'";
fi

mkdir src
cd src
git init
git remote add -f origin https://gitlab.com/Taghead/TagheadDiscordBotCollection.git
git config core.sparseCheckout true
echo "Games/TicTacToe" >> .git/info/sparse-checkout
git pull origin master

echo "
class config:
    token = "$DISCORDTOKEN"
    giphy_token = "$GIPHYTOKEN"
    prefix = "$PREFIX"
    sqlHost = "$SQLHOST" 
    sqlUser = "$SQLUSER"
    sqlPassword = "$SQLPASS" 
    sqlDatabase = "$SQLDATABASE" 
"

unset DISCORDTOKEN
unset GIPHYTOKEN
unset PREFIX
unset SQLHOST
unset SQLUSER
unset SQLPASS
unset SQLDATABASE

cd Games/TicTacToe

apt install -y python3-pip python3-venv mysql-server
python3 -m venv env
source ./env/bin/activate 
pip3 install -r requirements.txt