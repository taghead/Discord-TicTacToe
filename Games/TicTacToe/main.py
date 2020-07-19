from giphy import *
import mysql.connector
import discord


# START OF Connects to sql
#
try:
    mydb = mysql.connector.connect(
        host=config.sqlHost,
        user=config.sqlUser,
        passwd=config.sqlPassword,
        database=config.sqlDatabase
    )
    mycursor = mydb.cursor()
except:
    print('Unable to connect to Database \nhost: '+config.sqlHost+'Database: '+config.sqlDatabase)
#
# END OF Connects to sql



client = discord.Client()


# START OF getServerID method
#   This method gets serverID of the last user
async def getServerID(message):
    for server in client.guilds:
        if server.id == message.server.id:
            server = server
            return server
#
# END OF getServerID method


# START OF When message is sent on discord by any user
#
@client.event
async def on_message(message):
    if message.author == client.user:  # Prevents bot from replying to itself.
        return
    # START OF Commands. If statements passed here are to be considered commands
    #
    
    ############################################################################# ServerID ########################################################################
    if message.content.startswith(config.prefix+'serverID'): # Gets server ID
        server = await getServerID(message)
        await client.send(message.channel,
                                                 '**' + server.name + '\'s ID is: **`' + server.id + '`')

    ############################################################################ Knots&Cross ######################################################################
    if message.content.startswith(config.prefix + 'xo'): #Game of knots and crosses
        try:
            # START OF Checks privileges
            #
            if message.server.me.server_permissions.manage_messages:
                await client.delete_message(message)
                privCheckManageMess = " "
            else:
                privCheckManageMess = "Please allow me to Manage Messages so I can delete user input"
            # 
            # END OF Check privileges
            
            # START OF Default variables
            #   Default is written to sql if server does not exist and prevents server crosstalk
            grid = ['-', '-', '-', '-', '-', '-', '-', '-', '-'] #Each index represents a location for X or O
            found = False #If server is found in SQL
            server = await getServerID(message) #Gets serverID
            ID = 0 #Reset ID
            xo = "X" #Default xo to be written to SQL
            usrIn = " " #Resets user input 
            power = " " #Resets power used to format rows. 3 by 3
            #
            # END OF Default variables

            # START OF Get saveData from Database
            #
            mycursor.execute("SELECT * FROM gameTicTacToe WHERE serverID = " + str(server.id)) #Queries database
            for row in mycursor: #My cursor  uses the mydb.cursor() and contains a list of arrays for each row
                if server.id == str(row[1]): # IF serverID is the same as the databases column serverID
                    if "tictactoe" == row[2]: # IF "tictactoe" is the databases column gameName
                        ID = row[0] # Sets ID to the databases sessID (row[0])
                        saveData = row[3] # Sets saveData to databases saveData[3]
                        xo = row[4] # Sets xo to databases saveData[4]
                        for i, v in enumerate(grid): # Enumerates through the grid array
                            grid[i] = saveData[i] # Sets grid array (grid = ['-', '-', '-', '-', '-', '-', '-', '-', '-']) to
                                                    # to the data in saveData example data grid = ['X', 'O', '-', '-', '-', 'X', '-', '-', '-']
                        found = True # Used to validate if server was found in database and create a entry
            if not found:
                await client.send(message.channel,
                                        'Oh hey, it\'s this servers first time using this check out ' + config.prefix + ' xo help')
                saveData = grid[0] + grid[1] + grid[2] + grid[3] + grid[4] + grid[5] + grid[6] + grid[7] + grid[8] # Sets database to default saveData
                mycursor.execute("INSERT INTO gameTicTacToe (serverID, gameName, saveData, saveData0) VALUES (%s, %s, %s, %s)", # Executes query to insert default data into Database Row
                                (server.id, "tictactoe", str(saveData), "X"))          # <-- Default data being placed
                mydb.commit() # 'Commits' aka saves changes to database
            #
            # END OF Get saveData from Database
            
            # START OF User Input
            #             
            try:
                usrIn = message.content[len(config.prefix) + len('xo '):] # Removes prefix and command from the rest of the input
                row = usrIn[0]  # Gets user inputs first character. Valid characters are ABC. (Characters are checked in later IF)
                col = usrIn[1]  # Gets user inputs second character. Valid characters are 123 (Characters are checked in later IF).  
            except:
                row = "Default" # Default value on fail
                col = "Default" # Default value on fail
                emb_xo_help=discord.Embed(description=
                                        'Aight so here is the deal, you and your mate are having issues ' +
                                        'he stole the last bottle of coke and now you have to fight to get ' +
                                        'it back. To fight you must learn the following' +
                                        '\n\n The syntax for placing your X/O is `' + config.prefix + 
                                        ' xo [A/B/C][1/2/3]`. \nWorking exmaple `' + config.prefix + ' xo A1`' +
                                        '\n\n To do a new game type ' + config.prefix + ' xo new')
                await client.send(message.channel, embed=emb_xo_help)
                                        
            #
            # END OF User Input

            # START OF Game functions
            #
            if found: # IF GAME found else skips
                # START OF New game
                #
                if usrIn[0] == 'n' or xo == 'N':
                    grid = ['-', '-', '-', '-', '-', '-', '-', '-', '-']
                    saveData = grid[0] + grid[1] + grid[2] + grid[3] + grid[4] + grid[5] + grid[6] + grid[7] + grid[8]
                    mycursor.execute("UPDATE gameTicTacToe SET saveData = %s WHERE sessID = %s", (str(saveData), str(ID)))
                    mydb.commit()
                    await client.send(message.channel, 'All right, the board is cleaned.')
                #
                # END OF New game

                # START OF Game Algortihms
                #
                elif xo == 'X' or xo == 'O' or 'o' or 'x': # NO LONGER NEEDED X O x o is now auto resolved through the server
                    if row == 'A' or row == 'B' or row == 'C' or row == 'a' or row == 'b' or row == 'c': # Fail Safe ensures correct input in userIn[0]
                        if col == '1' or col == '2' or col == '3': # Fail Safe ensures correct input in userIn[1]
                            if row == 'A' or row == 'a':
                                power = 0
                            if row == 'B' or row == 'b':
                                power = 3
                            if row == 'C' or row == 'c':
                                power = 6
                            locationXO = int(col) - 1 + power # Calculates input to grid location
                            # START OF IF occupied
                            #   Checks if grid location already contains X O x o
                            if grid[locationXO] == 'x' or grid[locationXO] == 'X' or grid[locationXO] == 'O' or grid[
                                locationXO] == 'o':
                                await client.send(message.channel,
                                                        'Nice try, but you can\'t kill off ' + grid[
                                                            locationXO] + ' like that. Try again.')
                                ox = xo
                            # 
                            # END OF IF occupied
                            else: # Inverts xo X = O or O = X
                                grid[locationXO] = xo 
                                ox = str(xo)
                                if xo == 'X':
                                    xo = 'O'
                                elif xo == 'O':
                                    xo = 'X'
                            msg = '>\t1\t2\t3\n'
                            for i, v in enumerate(grid):  #Places A B C starting from 0 and every 3 increment
                                if i == 6:
                                    msg += 'C\t'
                                if i == 3:
                                    msg += 'B\t'
                                if i == 0:
                                    msg += 'A\t'
                                msg += v + '\t'
                                if i == 2 or i == 5 or i == 8:
                                    msg += '\n' # Creates new line before placing A B or C
                            emb_xo = discord.Embed(
                                description=ox + ' made a move.\n' + '```sql\n ' + msg + '```' + 'It\'s your turn ' + xo)
                            emb_xo.set_footer(text='TicTacToe v2 | ' + privCheckManageMess)
                            await client.send(message.channel, embed=emb_xo)
                            # START OF Update Database
                            #   updates saveData in the database using the new saveData
                            saveData = grid[0] + grid[1] + grid[2] + grid[3] + grid[4] + grid[5] + grid[6] + grid[7] + grid[
                                8] # Saves grid as a single String into saveData
                            mycursor.execute("UPDATE gameTicTacToe SET saveData = %s WHERE sessID = %s", # Updates saveData and saves to saveData
                                            (str(saveData), str(ID))) 
                            mycursor.execute("UPDATE gameTicTacToe SET saveData0 = %s WHERE sessID = %s", # Updates last valid placement (X or O) and saves to saveData0
                                            (str(xo), str(ID)))
                            mydb.commit() # Commits changes to database
                            #
                            # END OF Update Database
                        else: # Fail Safe ensures correct input in userIn[0]
                            await client.send(message.channel,
                                                    'Something went wrong... remember the rows are 1,2 or 3. Example command ` ' 
                                                    + config.prefix + 'xo C3`')
                    else: # Fail Safe ensures correct input in userIn[1]
                        await client.send(message.channel,
                                                'Something went wrong... remember the rows are A,B or C. Example command `' 
                                                + config.prefix + 'xo B2`')
                else: # Fail Safe ensures X X o o are the only thing received from the database
                    await client.send(message.channel,
                                            'Please use X or O. Example command ` ' + config.prefix + 'xo A1`')
        except:
            pass
        # 
        # END OF Game functions

    ############################################################################### LINK ##########################################################################
    if message.content.startswith(config.prefix + 'link'): #Embeds given links @prefix link NAME | URL
        try:
            # START OF Checks privileges
            #
            if message.server.me.server_permissions.manage_messages:
                await client.delete_message(message)
                privCheckManageMess = " "
            else:
                privCheckManageMess = "Please allow me to Manage Messages so I can delete user input"
            # 
            # END OF Checks privileges

            #START OF Default Variables
            #
            usrMes = message.content[len(config.prefix) + len('link '):] #Removes prefix and command name from usrMes
            userID = message.author.id #Gets the ID of the user that requests the command
            linkName = ' ' # Default Value
            foundBreak = False # Default Value used as a delimiter
            httpCheckOne = False # Default Value used for reformmating string
            httpCheckTwo = False # Default Value used for reformmating string
            httpCheckThree = False # Default Value used for reformmating string
            httpCheckFour = False # Default Value used for reformmating string
            #
            # END OF Default Variables
            
            # START OF Seperating linkName from linkURL
            # 
            for i, v in enumerate(usrMes):
                if usrMes[i] == '|': # Stops adding to linkName with the delimiter
                    foundBreak = True
                    break
                linkName += usrMes[i]
            if not foundBreak:
                raise ValueError
            linkURL = usrMes[len(linkName) + 1:]
            #
            # END OF Seperating linkName from linkURL
            
            # START OF Formatting and correcting linkURL
            #
            if linkURL.startswith('http://'): # Checks user input if auto correct is needed
                httpCheckOne = True
                linkURL = linkURL[7:]
            elif linkURL.startswith('https//'): # Checks user input if auto correct is needed
                httpCheckTwo = True
                linkURL = linkURL[8:]
            if linkURL.startswith('http:/'): # Checks user input if auto correct is needed
                httpCheckThree = True
                linkURL = linkURL[6:]
            elif linkURL.startswith('https/'): # Checks user input if auto correct is needed
                httpCheckFour = True
                linkURL = linkURL[7:]            
            if httpCheckOne or httpCheckThree: # Auto corrects input
                linkURL = 'http://' + str(linkURL) 
            elif httpCheckTwo or httpCheckFour: # Auto corrects input
                linkURL = 'https://' + str(linkURL)    
            else: # Auto corrects input
                linkURL = 'https://' + str(linkURL)                
            #
            # END OF Formatting and correcting linkURL
            emb_link = discord.Embed(description= '<@' + userID + '> sent: [' + str(linkName) + ']' + '(' + str(linkURL) + ') ') 
            emb_link.set_footer(text=privCheckManageMess)
            await client.send(message.channel, embed=emb_link)
        except ValueError:
            await client.send(message.channel, 
                                                    'Use the following syntax ```' + config.prefix + 'link [Name] | [URL]\n' +
                                                    '```Working example```' + config.prefix + 'link Google | google.com```')

    ################################################################################ GIF ##########################################################################
    if message.content.startswith(config.prefix + 'gif'): #Search giphy for gif @prefix gif QUERY
        usrMes = message.content[len(config.prefix) + len('gif'):]
        gifUrl = giphy.searchRandom(usrMes)
        try:
            emb_gif = discord.Embed(description='**Found an image for **:' + 
            '***['+usrMes+']('+gifUrl+')***')
            emb_gif.set_image(url=gifUrl)
            emb_gif.set_footer(text='powered by Giphy')
            emb_gif.set_thumbnail(url='https://media.giphy.com/media/3o6gbbuLW76jkt8vIc/giphy.gif')
            await client.send(message.channel, embed=emb_gif)
        except:
            gifInvalidURL = str('https://giphy.com/search/'+usrMes[1:])
            emb_gif = discord.Embed(description='**Ring ring, ring ring.... the number**:' + 
            '***['+str(usrMes)+']('+gifInvalidURL+')*** \ncould not reached (BAD REQUEST ERROR 400)')
            emb_gif.set_footer(text='powered by Giphy')
            await client.send(message.channel, embed=emb_gif)

    ################################################################################ WALL #########################################################################
    if message.content.startswith(config.prefix + 'wall'): #Build a 4x4 Wall mentioning the user
        usrMen = '<@' + message.mentions[0].id + '> '  # Saves mentioned user into usrMen variable
        if message.content.startswith(config.prefix + 'wall @everyone'):
            await client.send(message.channel, 'Don\'t @everone please, it hurts people.')
        else:
            await client.send(message.channel, 'building a wall...')
            tmpUsrMen = usrMen + usrMen + usrMen + usrMen + '\n'
            for x in range(3):
                tmpUsrMen += tmpUsrMen
            emb_wall = discord.Embed(description=tmpUsrMen)
            await client.send(message.channel, embed=emb_wall)

    ################################################################################ HELP #########################################################################
    if message.content.startswith(config.prefix + 'help'): #Displays help
        cLA = ['help | Calls the police', 'wall @username | Builds a wall', 'gif | Search for a gif', 'link | embeds link',
               'serverID | Gets current server id', "xo | TicTacToe"]  # List of commands
        cDLA = ['short | Link Shortener']  # List of WIP commands
        showCLA = ' '
        for x in cLA:
            showCLA += '`\n' + config.prefix + x + '`\n'
        showCDLA = ' '
        for x in cDLA:
            showCDLA += '`\n' + config.prefix + x + '`\n'
        gifUrl = giphy.searchRandom('funny meme')
        emb_help = discord.Embed(description='**Oh no, feeling down?** ' +
                                             '**Worry not we got a GIF to cheer you up, take a look over to the right.**')
        emb_help.add_field(name='------------',
                           value='\n \n **If by help you meant commands try the following**\n' + showCLA, inline=False)
        emb_help.add_field(name='------------', value='\n \n **WIP currently not enabled**\n' + showCDLA, inline=False)
        emb_help.set_thumbnail(url=gifUrl)
        await client.send(message.channel, embed=emb_help)
    #
    # END OF Commands IF statements.
#
# END OF When message is sent on discord by any user

# START OF do this when bot starts
#
@client.event
async def on_ready():
    print('=============== \n Bot Name: ' + client.user.name +
          '\n Running on ' + str(len(client.guilds)) + ' servers' +
          '\n Bot Prefix : ' + config.prefix + '\n===============')
    activity=discord.Game(name='Try \'' + config.prefix + 'help\'')
    await client.change_presence(status=discord.Status.idle, activity=activity)
#
# END OF do this when bot starts
client.run(config.token)
