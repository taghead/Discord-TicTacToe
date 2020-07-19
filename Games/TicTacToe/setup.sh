#!/bin/bash
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

apt install -y python3-pip python3-venv mysql-server
python3 -m venv env
source ./env/bin/activate 
pip3 install -r requirements.txt