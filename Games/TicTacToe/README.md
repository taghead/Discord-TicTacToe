# TIC TAC TOE


## Config
```python
class config:
    token = input("Discord Bot Token:")
    giphy_token = input("Giphy Token:")
    prefix = "@ZN "
    sqlHost = "localhost"
    sqlUser = "normalUser"
    sqlPassword = "1234"
    sqlDatabase = "practice"
```

## Dependencies
Dependencies should automatically be installed using the provided installation scripts initial_setup.ps1 (For windows) or initial_setup.sh (For Debian) but just in case here is a list.
- Python 3.6
    - discord.py        (Python Module)
    - giphy_client      (Python Module)
    - mysql-connector   (Python Module)

## Operating System Compatability
This bot should work as long as you have python and an SQL server. This has currently been test on the following:
- Windows
- Ubuntu