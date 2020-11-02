# TIC TAC TOE

## Guide
- Start with setting up the dependencies and packages required for the bot by running `chmod 700 ./setup.sh; ./setup.sh;` as root or with sudo.  
- Now configure the SQL server using the following commands. `mysql -p -u root` > Enter > `use mysql;` now copy all the lines under line 4 in #practiceCreateUsers.sql and finally copy the entire #practiceCreate.sql into it. Exit mysql now.
- Finally run `python main.py`
- 
## Config
- The giphy and bot token will be prompted to you on startup. The sqlHost, sqlUser, sqlPassword and sqlDatabase are the default values currently hardcoded into #practiceCreateUsers. So the only variable that can be changed if you want an easy setup is the prefix. 
```python
class config:
    token = input("Discord Bot Token:")
    giphy_token = input("Giphy Token:")
    prefix = "@ZN "             # Replace this with your desired prefix
    sqlHost = "localhost"       # Manually installed SQL onto another device
    sqlUser = "normalUser"      # Change only if you changed #practiceCreateUsers.sql and practiceCreate.sql
    sqlPassword = "1234"        # Change only if you changed #practiceCreateUsers.sql and practiceCreate.sql
    sqlDatabase = "practice"    # Change only if you changed #practiceCreateUsers.sql and practiceCreate.sql
```

## Dependencies
Dependencies should automatically be installed using the provided installation scripts setup.sh but just in case here is a list.
- Python 3
    - discord.py        (Python Module)
    - giphy_client      (Python Module)
    - mysql-connector   (Python Module)

## Operating System Compatability
This bot should work as long as you have python and an SQL server. This has currently been tested on the following:
- Ubuntu
- Debian

## Using the setup script
The setup script requires the following environement variables
```shell
# Environemnt variables required
# DISCORDTOKEN 	- Contains discord bot api token
# GIPHYTOKEN 	- Contains giphy api token
# PREFIX        - Bot prefix
# SQLHOST 	    - Contains SQL host ip
# SQLUSER	    - Contains username for SQL Database
# SQLPASS	    - Contains password for SQL Database
# SQLDATABASE	- Contains database name
```
Once the environement variables are declared run the script.
```shell
wget -O /tmp/setup.sh https://gitlab.com/Taghead/TagheadDiscordBotCollection/-/raw/master/Games/TicTacToe/setup.sh
chmod +x /tmp/setup.sh
/tmp/setup.sh
```

## Using the dockerfile
Checkout Files
```shell
mkdir src
cd src
git init
git remote add -f origin https://gitlab.com/Taghead/TagheadDiscordBotCollection.git
git config core.sparseCheckout true
echo "Games/TicTacToe" >> .git/info/sparse-checkout
git pull origin master
cd Games/TicTacToe
```

Build the docker image
```shell
docker build .
```

Run the docker image and apply environment variables

```shell
# Environemnt variables required
# DISCORDTOKEN 	- Contains discord bot api token
# GIPHYTOKEN 	- Contains giphy api token
# PREFIX        - Bot prefix
# SQLHOST 	    - Contains SQL host ip
# SQLUSER	    - Contains username for SQL Database
# SQLPASS	    - Contains password for SQL Database
# SQLDATABASE	- Contains database name

docker run -it \ 
    -e DISCORDTOKEN=<Discord Token Here> \
    -e GIPHYTOKEN=<Giphy Token Here> \
    -e PREFIX=<Bot Prefix Here> \
    -e SQLHOST=<SQL Host ip address here> \
    -e SQLUSER=<Username for SQL Database here> \
    -e SQLPASS=<Password for SQL Database here> \
    -e SQLDATABASE=<SQL Database Name> \
    b0a351f1d915
```

Populated example
```shell
docker run -it \ 
    -e DISCORDTOKEN=2132h31b87dh912he.o123532ADSADVsqaw1423 \
    -e GIPHYTOKEN=AUhd82nJKADH133 \
    -e PREFIX=@ZN \
    -e SQLHOST=127.0.0.1 \
    -e SQLUSER=User \
    -e SQLPASS=Password \
    -e SQLDATABASE=Bot \
    b0a351f1d915
    ```
