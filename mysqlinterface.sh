#!/bin/sh
sudo apt-get install mysql-server -y
clear
loop=1
while [ $loop = 1 ]
do
    if [[ $EUID -ne 0 ]]; then
        echo "You are not running as root user restart as root." 
        echo "Use 'sudo su' before running or" 
        echo "Use 'sudo mysqlinterface.sh'"
        exit 1
    fi
    echo '====================================='
    mysqladmin version # mysqladmin -p -u root version
    echo '====================================='
    echo '1. Start SQL'
    echo '2. Stop SQL'
    echo '3. Enter SQL CLI'
    echo '0. Exit'
    echo '====================================='
    read -p 'Input: ' usrIn
    clear
    if [ $usrIn = 1 ]
    then service mysql start
    fi

    if [ $usrIn = 2 ]
    then mysqladmin shutdown
    fi

    if [ $usrIn = 3 ]
    then mysql
    fi

    if [ $usrIn = 0 ]
    then exit 0
    fi
    clear

    # Install mySQL
    
    # mysql_secure_installation
    # Check Status
    # systemctl status mysql.service

done