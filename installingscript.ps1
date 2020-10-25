# 2020
# Stian Larsen
# 
# NB! - Need internet to work
# Programs in installed with packetmanager chocolatey. 
# NB! This is for only my personal use. Paths are different and need a change if you want to use the script.

# Executes PowerShell with admin privileges and starts the script in elevated mode. 
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{  
  $arguments = "& '" +$myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb runAs -ArgumentList $arguments
  Break
}
# Installing main programs for me. Feel free to remove / add programs by yourself. You can find programs you want to install on chocolatey.org
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco.exe install chrome -y
choco.exe install firefox -y
choco.exe install 7zip.install -y
choco.exe install notepadplusplus.install -y
choco.exe install git.install -y
choco.exe install putty.install -y
choco.exe install sysinternals -y
choco.exe install teamviewer -y
choco.exe install vscode -y
choco.exe install winscp.install -y

$PSScriptRoot


Start-Process -FilePath "powershell" -Verb RunAs Get-item "B:\Projects\FormattingScript\UpdateScript.ps1"
& "B:\Projects\FormattingScript\UpdateScript.ps1"
Write-Host "Script:" $UpdateScript.ps1
Write-Host "Path:" $PSScriptRoot