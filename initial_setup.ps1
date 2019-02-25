#https://stackoverflow.com/questions/52578270/install-python-with-cmd-or-powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri "https://www.python.org/ftp/python/3.6.6/python-3.6.6.exe" -OutFile "$env:TEMP/python-3.6.6.exe"
###################################################################################
start-process $env:TEMP/python-3.6.6.exe

python -m pip install discord.py
python -m pip install giphy_client
python -m pip install mysql-connector

# GET SCRIPT SIGNED
#https://knowledge.digicert.com/solution/SO9982.html