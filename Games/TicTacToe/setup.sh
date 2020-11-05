#!/bin/sh

# Folder path variables
PATH_TO_FILES="Games/TicTacToe"

# Default variables
IGNORE_ROOT=0
SKIP_CHECK_ENVIRONMENT_VARIABLES=0
SETUP_PATH_DIRECTORY="$HOME/TagheadDiscordBotCollection"
START_AFTER_INSTALL=0

# Functions
applyconfig()
{
if [ "$SKIP_CHECK_ENVIRONMENT_VARIABLES" -eq 0 ]
then
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
        DISCORDTOKEN="\"$DISCORDTOKEN"\"
    fi

    if [ -z ${GIPHYTOKEN+x} ]; 
    then 
        echo "GIPHYTOKEN is unset... setting GIPHYTOKEN to default";
        GIPHYTOKEN="input(\"Giphy Token:\")"; 
    else 
        echo "GIPHYTOKEN is set to '$GIPHYTOKEN'";
        GIPHYTOKEN="\"$GIPHYTOKEN"\"
    fi

    if [ -z ${PREFIX+x} ]; 
    then 
        echo "PREFIX is unset... setting PREFIX to default";
        PREFIX="input(\"Prefix:\")"; 
    else 
        echo "PREFIX is set to '$PREFIX'";
        PREFIX="\"$PREFIX"\"
    fi

    if [ -z ${SQLHOST+x} ]; 
    then 
        echo "SQLHOST is unset... setting SQLHOST to default";
        SQLHOST="input(\"My SQL server ip:\")"; 
    else 
        echo "SQLHOST is set to '$SQLHOST'";
        SQLHOST="\"$SQLHOST"\"
    fi

    if [ -z ${SQLUSER+x} ]; 
    then 
        echo "SQLUSER is unset... setting SQLUSER to default";
        SQLUSER="input(\"My SQL database username:\")"; 
    else 
        echo "SQLUSER is set to '$SQLUSER'";
        SQLUSER="\"$SQLUSER"\"
    fi

    if [ -z ${SQLPASS+x} ]; 
    then 
        echo "SQLPASS is unset... setting SQLPASS to default";
        SQLPASS="input(\"My SQL users password:\")"; 
    else 
        echo "SQLPASS is set to '$SQLPASS'";
        SQLPASS="\"$SQLPASS"\"
    fi

    if [ -z ${SQLDATABASE+x} ]; 
    then 
        echo "SQLDATABASE is unset... setting SQLDATABASE to default";
        SQLDATABASE="input(\"My SQL database name:\")";  
    else 
        echo "SQLDATABASE is set to '$SQLDATABASE'";
        SQLDATABASE="\"$SQLDATABASE"\"
    fi
fi

echo "
class config:
    token = "$DISCORDTOKEN"
    giphy_token = "$GIPHYTOKEN"
    prefix = "$PREFIX"
    sqlHost = "$SQLHOST" 
    sqlUser = "$SQLUSER"
    sqlPassword = "$SQLPASS" 
    sqlDatabase = "$SQLDATABASE" 
" > "$SETUP_PATH_DIRECTORY/$PATH_TO_FILES/config.py"
}

# Handle arguments
for arg in "$@"
do
    case "$arg" in
        -ir|--ignore-root)
            IGNORE_ROOT=1
            echo " Ignoring root user status"
            shift
            ;;
        -se|--skip-environment)
            SKIP_CHECK_ENVIRONMENT_VARIABLES=1
            echo "Skipping environment variables check"
            shift
            ;;
        -p=*|--path=*)
            SETUP_PATH_DIRECTORY="${arg#*=}"
            echo "Setting up in ${arg#*=} as the path"
            [ -d ${arg#*=} ] && echo "Path ${arg#*=} exists."
            [ ! -d ${arg#*=} ] && echo "Path does not exists... making path ${arg#*=}" && mkdir ${arg#*=}
            [ ! -d ${arg#*=} ] && echo "Unable to make directory ${arg#*=}" && exit 0
            shift
            ;;
        -s|--start)
            echo "Starting application after install"
            START_AFTER_INSTALL=1
            shift
            ;;
        -snc|--start-new-config)
            echo "Starting application after applying new configuration"
            
            shift
            ;;
        -h|--help)
            echo -e """
            \nEnvironment Variables
                These variables are used to configure the config.py, not
                declaring a variable will default it to an input prompt
                on every run.
                    DISCORDTOKEN 	- Contains discord bot api token
                    GIPHYTOKEN 	- Contains giphy api token
                    PREFIX        - Bot prefix
                    SQLHOST 	    - Contains SQL host ip
                    SQLUSER	    - Contains username for SQL Database
                    SQLPASS	    - Contains password for SQL Database
                    SQLDATABASE	- Contains database name

            \nARGUMENTS
                -ir     --ignore-root       | Ignores user privileges check
                -se     --skip-environment  | Skips environment variables check
                -p=     --path=             | Set install path. Example -p=/opt/bot
                -s      --start             | Start application after install
                -snc    --start-new-config  | Start applications and re-check environment
                                            | variables for new values to apply to the
                                            | configuration files.
                                            
                -h      --help              | Helps
            """
            exit 0
            shift
            ;;
        *)
            OTHER_ARGUMENTS+="$1"
            shift # Remove generic argument from processing
            ;;
    esac
done

if [ "$(id -u)" -ne "0" -a "$IGNORE_ROOT" -eq 0 ];
then
    echo """
    This script runs optimally as a root user. Please run as root or sudo.
    If you wish to ignore this wait 10 seconds for the code to continue,
    else press CTRL+C.
    """
    sleep 10
fi

mkdir "$SETUP_PATH_DIRECTORY"
cd "$SETUP_PATH_DIRECTORY"
git init
git remote add -f origin https://gitlab.com/Taghead/TagheadDiscordBotCollection.git
git config core.sparseCheckout true
echo "$PATH_TO_FILES" >> .git/info/sparse-checkout
git pull origin master
rm -R "$SETUP_PATH_DIRECTORY/.git"

applyconfig

unset DISCORDTOKEN
unset GIPHYTOKEN
unset PREFIX
unset SQLHOST
unset SQLUSER
unset SQLPASS
unset SQLDATABASE

cd "$SETUP_PATH_DIRECTORY/$PATH_TO_FILES"

apt-get install -y python3-pip python3-venv
python3 -m venv env
if [ "$SHELL"=="/bin/zsh" ]; then chmod +x ./env/bin/activate && ./env/bin/activate
elif [ "$SHELL"=="/bin/sh" ]; then chmod +x ./env/bin/activate && ./env/bin/activate
elif [ "$SHELL"=="/bin/bash" ]; then source ./env/bin/activate
else source ./env/bin/activate
fi
pip3 install -r requirements.txt

if [ "$START_AFTER_INSTALL" -eq 1 ]; then python main.py; fi
