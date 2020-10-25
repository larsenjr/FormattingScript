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

choco.exe install chrome
choco.exe install firefox
choco.exe install 7zip.install
choco.exe install notepadplusplus.install
choco.exe install git.install
choco.exe install putty.install
choco.exe install sysinternals
choco.exe install teamviewer
choco.exe install vscode
choco.exe install winscp.install

$PSScriptRoot


Start-Process -FilePath "powershell" -Verb RunAs Get-item "B:\Projects\FormattingScript\UpdateScript.ps1"
& "B:\Projects\FormattingScript\UpdateScript.ps1"
Write-Host "Script:" $UpdateScript.ps1
Write-Host "Path:" $PSScriptRoot