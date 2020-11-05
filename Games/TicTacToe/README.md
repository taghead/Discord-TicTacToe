### About TicTacToe bot

TicTacToe bot contains the following commands.

```
@ZN help            | Calls the police
@ZN wall @username  | Builds a wall
@ZN gif             | Search for a gif
@ZN link            | embeds link
@ZN serverID        | Gets current server id
@ZN xo              | TicTacToe
```

This repository was originally created as a fun way to play around with Python, Discord.py and MySQL. 

At this point it's maintaince is only done irregularly. New features will be added when I need to refresh my programming skills.

### Operating System Compatability
This bot should work as long as you have Python and an SQL server. This has currently been tested on the following:
- Ubuntu
- Debian
- DietPi
- DietPi using Docker

It can be assumed that this will likely work on most Ubuntu and Debian distros.

### Dependencies
Dependencies should automatically be installed using the provided installation scripts setup.sh but just in case here is a list.
- Python 3
    - discord.py        (Python Module)
    - giphy_client      (Python Module)
    - mysql-connector   (Python Module)


### Environment Variables
> The following variables are optional to declare, though doing so will prevent prompts from occuring when running the application. Applying the variables will allow the [setup.sh](/Games/TicTacToe/setup.sh) to set the values in [config.py](/Games/TicTacToe/config.py). 
> > `DISCORDTOKEN`  *- Contains discord bot api token*
> > `GIPHYTOKEN` 	*- Contains giphy api token*
> > `PREFIX`        *- Bot prefix*
> > `SQLHOST` 	    *- Contains SQL host ip*
> > `SQLUSER`	    *- Contains username for SQL Database*
> > `SQLPASS`	    *- Contains password for SQL Database*
> > `SQLDATABASE`	*- Contains database name*
> 
> To help put it into perspective content here is the default [config.py](/Games/TicTacToe/config.py).
>```python
>class config:
>    token = input("Discord Bot Token:")                         # Discord Bot Token
>    giphy_token = input("Giphy Token:")                         # Giphy API token
>    prefix = input("Bot prefix:")                               # Replace this with your desired prefix
>    sqlHost = input("My SQL server ip:")                        # Manually installed SQL onto another device
>    sqlUser = input("My SQL database user")                     # Change only if you changed #practiceCreateUsers.sql and practiceCreate.sql
>    sqlPassword = input("My SQL database user password:")       # Change only if you changed #practiceCreateUsers.sql and practiceCreate.sql
>    sqlDatabase = input("My SQL database password:")            # Change only if you changed #practiceCreateUsers.sql and practiceCreate.sql
>```


### Setup Method - Using the setup script ( Linux Only )

Once the environement variables are declared run the script.
```shell
wget -O /tmp/setup.sh https://gitlab.com/Taghead/TagheadDiscordBotCollection/-/raw/master/Games/TicTacToe/setup.sh
chmod +x /tmp/setup.sh
/tmp/setup.sh
```

### Setup Method - Docker

##### *Get required files*
```shell
wget https://gitlab.com/Taghead/TagheadDiscordBotCollection/-/raw/master/Games/TicTacToe/Dockerfile
wget https://gitlab.com/Taghead/TagheadDiscordBotCollection/-/blob/master/Games/TicTacToe/requirements.txt
wget https://gitlab.com/Taghead/TagheadDiscordBotCollection/-/raw/master/Games/TicTacToe/setup.sh

```

##### *Build the docker image*
```shell
docker build . -t ttt_discord_bot:latest
```

##### *Run the docker image and apply environment variables*

In this step you will be passing the following variables into the docker container

Run the following ( replace the agular brackets <...> with your value.)

 ```shell
 docker run -it \ 
     -e DISCORDTOKEN=<Discord Token Here> \
     -e GIPHYTOKEN=<Giphy Token Here> \
     -e PREFIX=<Bot Prefix Here> \
     -e SQLHOST=<SQL Host ip address here> \
     -e SQLUSER=<Username for SQL Database here> \
     -e SQLPASS=<Password for SQL Database here> \
     -e SQLDATABASE=<SQL Database Name> \
     ttt_discord_bot:latest
 ```


### Know Issues

- SQL Server configuration requires refactoring to work. 
