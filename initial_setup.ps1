#If unable to run conventionally open powershell and run [Start-Process powershell.exe "-ExecutionPolicy Bypass"]
#this saves the need to change execution policy in that session of powershell. Simply put temporarly allows unsigned scripts.
#If you don't want to run this script Download Python3.6.6 and use the following commands [python -m pip install discord.py]
#[python -m pip install giphy_client] [python -m pip install mysql-connector]


$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
$checkExecutePolicy = Get-ExecutionPolicy 
$directory = Get-Location
$fileDirectory = $directory.tostring() + "\" + "initial_setup.ps1"
echo "Current filepath $fileDirectory"
echo "Admin: $isAdmin"
if ($isAdmin -eq $true){
    if ($checkExecutePolicy -ne "Bypass"){
        echo "Execution policy is set to $checkExecutePolicy"
        $runPowershellBypass = Read-Host -Prompt 'Attempt to run [powershell -ExecutionPolicy Bypass] Y/N'
        if($runPowershellBypass -eq "Y" -or $runPowershellBypass -eq "y"){
            Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$fileDirectory`""
        }
    }
}

if ($isAdmin -eq $false){
    $runAdmin = Read-Host -Prompt 'Hmm this might not work without admin... attempt to run as Admin? Y/N '
    if($runAdmin -eq "Y" -or $runAdmin -eq "y"){
        Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$fileDirectory`"" -Verb RunAs
        exit 0
    }
}


if ( Get-ChildItem Env:ChocolateyPath ) {
    echo "==========Chocolatey already installed.`n Skipping install"
} else {
    clear
    echo "Current filepath $fileDirectory"
    echo "Admin: $isAdmin"
    echo "==========Installing chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

}

if ( Get-ChildItem Env:ChocolateyPath ) {
    echo "`n`n`n"
    echo "==========Starting installs using Chocolatey"
    choco install python --version 3.6.6 -y
} else {
        echo "`n`n`n"
        echo "==========Chocolatey not installed... skipping installs using Chocolatey." 
}


echo "`n`n`n"
echo "==========Installing python modules"
python -m pip install discord.py
python -m pip install giphy_client
python -m pip install mysql-connector

echo "`n`n`n Continue to exit?"
pause
exit 0