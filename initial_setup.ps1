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
            powershell -ExecutionPolicy Bypass
            echo "donedonedonedonedonedonedonedonedonedone"
        }
    }
}

if ($isAdmin -eq $false){
    $runAdmin = Read-Host -Prompt 'Attempt to run as Admin? Y/N'
    if($runAdmin -eq "Y" -or $runAdmin -eq "y"){
        Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$fileDirectory`"" -Verb RunAs
        exit 0
    }
}

#$executePolicy = Get-ExecutionPolicy
#if ($executePolicy -eq "Restricted" -or $executePolicy -eq "Bypass")
#{
#    echo "Execution policy is set to $executePolicy"
#    start-process powershell –verb runAs
#    $changePolicyCheck = Read-Host -Prompt 'Change policy to Unrestricted? Y/N'
#    clear
#    echo "Requries admin, if insatll fails use [Set-ExecutionPolicy Unrestricted] in powershell as admin"
#    echo "it is recommened to change policy back to restricted after install, [Set-ExecutionPolicy Restricted]"
#    pause
#    clear
#    if($changePolicyCheck -eq "Y" -or $changePolicyCheck -eq "y"){
#        Set-ExecutionPolicy Unrestricted
#    }
#}

Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
$executePolicy = Get-ExecutionPolicy

#if ($executePolicy -eq "Unrestricted"){
#    Set-ExecutionPolicy Restricted
#}

clear

choco install python --version 3.6.6
python -m pip install discord.py
python -m pip install giphy_client
python -m pip install mysql-connector