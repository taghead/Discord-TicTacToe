# TIC TAC TOE

> **Environment Variables**
> The following variables are optional to declare, though doing so will prevent prompts from occuring when running the application. Applying the variables will allow the [setup.sh](/Games/TicTacToe/setup.sh) to set the values in [config.py](/Games/TicTacToe/config.py). 
> > `DISCORDTOKEN`  *- Contains discord bot api token*
> > `GIPHYTOKEN` 	*- Contains giphy api token*
> > `PREFIX`        *- Bot prefix*
> > `SQLHOST` 	    *- Contains SQL host ip*
> > `SQLUSER`	    *- Contains username for SQL Database*
> > `SQLPASS`	    *- Contains password for SQL Database*
> > `SQLDATABASE`	*- Contains database name*

## Config file
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
- DietPi
- DietPi using Docker

## Setup using the setup script
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

## Setup using the dockerfile ( Must be built )
Get required files
```
wget https://gitlab.com/Taghead/TagheadDiscordBotCollection/-/raw/master/Games/TicTacToe/Dockerfile
wget https://gitlab.com/Taghead/TagheadDiscordBotCollection/-/blob/master/Games/TicTacToe/requirements.txt
wget https://gitlab.com/Taghead/TagheadDiscordBotCollection/-/raw/master/Games/TicTacToe/setup.sh

```

####Build the docker image
```shell
docker build . -t ttt_discord_bot:latest
```

#### Run the docker image and apply environment variables

> In this step you will be passing the following variables into the docker container
>
> `DISCORDTOKEN`*- Contains discord bot api token*
> `GIPHYTOKEN` 	*- Contains giphy api token*
> `PREFIX`      *- Bot prefix*
> `SQLHOST` 	*- Contains SQL host ip*
> `SQLUSER`	    *- Contains username for SQL Database*
> `SQLPASS`	    *- Contains password for SQL Database*
> `SQLDATABASE`	*- Contains database name*
> 
> Run the following
> ```shell
> docker run -it \ 
>     -e DISCORDTOKEN=<Discord Token Here> \
>     -e GIPHYTOKEN=<Giphy Token Here> \
>     -e PREFIX=<Bot Prefix Here> \
>     -e SQLHOST=<SQL Host ip address here> \
>     -e SQLUSER=<Username for SQL Database here> \
>     -e SQLPASS=<Password for SQL Database here> \
>     -e SQLDATABASE=<SQL Database Name> \
>     ttt_discord_bot:latest
> ```
