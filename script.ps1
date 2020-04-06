
#Requires -RunAsAdministrator
# Install script for choco etter formatting
# 04.04.2020
# Stian Larsen
# 
# Need internet to work
# KEK

## Vars / Paths
$GooglePath = "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
$FirefoxPath = "C:\Program Files\Mozilla Firefox\firefox.exe"
$7ZipPath = "C:\Program Files\7-Zip\7zFM.exe"
$VlcPath = "C:\Program Files\VideoLAN\VLC\vlc.exe"
$DiscordPath = "$env:USERPROFILE\AppData\Local\Discord\app-0.0.306\Discord.exe"
$ShareXPath = "C:\Program Files\ShareX\ShareX.exe"
$TeamViewerPath = "C:\Program Files (x86)\TeamViewer\TeamViewer.exe"
$SpotifyPath = "$env:USERPROFILE\AppData\Roaming\Spotify\Spotify.exe"
$ClassicShellPath = "C:\Program Files\Classic Shell\ClassicIE_64.exe"
$SumatraPath = "C:\Program Files\SumatraPDF\SumatraPDF.exe"
$BitwardenPath = "C:\Program Files\Bitwarden\Bitwarden.exe"
## Dev
$GitPath = "C:\Program Files\Git\cmd\git.exe"
$VsCodePath = "C:\Program Files\Microsoft VS Code\Code.exe"
$SublimePath = "C:\Program Files\Sublime Text 3\sublime_text.exe"
$NotepadPath = "C:\Program Files\Notepad++\notepad++.exe"
$MobaXtermPath = "C:\Program Files (x86)\Mobatek\MobaXterm\MobaXterm.exe"
$PuttyPath = "C:\Program Files\PuTTY\putty.exe"
$OpenSSHPath = "C:\Program Files\OpenSSH-Win64\ssh.exe"
$Python3Path = "C:\Program Files (x86)\Microsoft Visual Studio\Shared\Python37_64\python.exe"
$JavaPath = "C:\Program Files\Java\jdk-13.0.1\bin\java.exe"
$Php7Path = "C:\Tools\php74\php.exe"
$DockerPath = "C:\Program Files\Docker\Docker\Docker Desktop.exe"
$OpenVPNPath ="C:\Program Files\OpenVPN\bin\openvpn-gui.exe"

$isAdmin = [bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")

if ($isAdmin -eq $False) {
    Write-Host "You need to start this script as admin!" "`n"
    Start-Sleep -Seconds 2
    Start-Process powershell_ise -Verb runAs
}

Write-Output Checking ExecutionPolicy.."`n"

Get-ExecutionPolicy

# Check 
$ExecutionPolicy = Get-ExecutionPolicy "`n"

if ($ExecutionPolicy -eq 'Restricted') {
    Write-Output Setting ExecutionPolicy to Bypass.."`n"
        Set-ExecutionPolicy Bypass
    } 
elseif ($ExecutionPolicy -eq 'AllSigned') {
        Write-Output Setting ExecutionPolicy to Bypass.."`n"
        Set-ExecutionPolicy Bypass
    } 
else {
        Write-Output "All good, moving on.." "`n"
    }


function Get-TimeStamp {
    return "[{0:MM/dd/yy} {0:HH:mm:ss}]" -f (Get-Date)
}

function Green {
    process { Write-Host $_ -ForegroundColor Green }
}

function Red {
    process { Write-Host $_ -ForegroundColor Red }
}

#Install choco ved hjelp av powershell:

    Write-Output Configuring chocolatey.. "`n"
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

Write-Output Installing apps "`n"

## Essentials
    ## Google Chrome
        Write-Verbose -Message "Installing Google Chrome" -Verbose
        choco install googlechrome -y --verbose --log-file=C:\logs\chocolatey\googleChromelog.log

        if ((Test-Path $GooglePath) -eq $True) {
            Write-Output "Google Chrome successfully installed! Continuing installation.." "`n" | Green
        }

        else {
            Write-Output "$(Get-TimeStamp)"
            
        }

    ## Firefox
        Write-Output "Installing Firefox.." "`n"
        choco install firefox -y --verbose -log-file=C:\logs\chocolatey\Firefoxlog.log

        if ((Test-Path $FirefoxPath) -eq $True) {
            Write-Output "Firefox successfully installed! Continuing installation.." "`n" | Green
        }
        else {
            Write-Output "$(Get-TimeStamp)"
            
        }

    ## 7-Zip

        Write-Verbose -Message "Installing 7zip" -Verbose
        choco install 7zip.install -y --verbose -log-file=C:\logs\chocolatey\7ziplog.log

        if ((Test-Path $7ZipPath) -eq $True) {
            Write-Output "7-Zip successfully installed! Continuing installation.." "`n" | Green
        }

        else {
            Write-Output "$(Get-TimeStamp)"
            
        }

    ## VLC
        Write-Verbose -Message "Installing VLC" -Verbose
        choco install vlc -y --verbose -log-file=C:\logs\chocolatey\vlclog.log

        if((Test-Path $VlcPath) -eq $True) {
            Write-Output "VLC successfully installed! Continuing installation.." "`n" | Green
        }

        else {
            Write-Output "$(Get-TimeStamp)"
            
        }

    ## Discord
        Write-Verbose -Message "Installing Discord" -Verbose
        choco install discord.install -y --verbose -log-file=C:\logs\chocolatey\discordlog.log

        if ((Test-Path $DiscordPath) -eq $True) {
            Write-Output "Discord successfully installed! Continuing installation.." "`n" | Green
        }

        else {
            Write-Output "$(Get-TimeStamp)"
            
        }

    ## ShareX
        Write-Verbose -Message "Installing ShareX" -Verbose
        choco install sharex -y --verbose -log-file=C:\logs\chocolatey\sharexlog.log

        if((Test-Path $ShareXPath) -eq $True) {
            Write-Output "ShareX successfully installed! Continuing installation.." "`n" | Green
        }

        else {
            Write-Output "$(Get-TimeStamp)"
            
        }

    ## Teamviewer
        Write-Verbose -Message "Installing TeamViewer" -Verbose
        choco install teamviewer -y --verbose -log-file=C:\logs\chocolatey\teamviewerlog.log

        if ((Test-Path $TeamViewerPath) -eq $True) {
            Write-Output "Teamviewer successfully installed! Continuing installation.." "`n" | Green
        }
        else {
            Write-Output "$(Get-TimeStamp)"
            
        }

    ## Spotify
        Write-Verbose -Message"Installing Spotify" -Verbose
        choco install spotify -y --verbose -log-file=C:\logs\chocolatey\spotifylog.log

        if ((Test-Path $SpotifyPath) -eq $True) {
            Write-Output "Spotify successfully installed! Continuing installation.." "`n" | Green
        }
        else {
            Write-Output "$(Get-TimeStamp)"
            
        }

    ## Classic Shell
        Write-Verbose -Message "Installing Classic Shell" -Verbose
        choco install classic-shell -y --verbose -log-file=C:\logs\chocolatey\classicshellog.log

        if ((Test-Path $ClassicShellPath) -eq $True) {
            Write-Output "Classic Shell successfully installed! Continuing installation.." "`n" | Green
        }
        else {
            Write-Output "$(Get-TimeStamp)"
            
        }

    ## Sumatra PDF
        Write-Verbose -Message "Installing SumatraPDF" -Verbose
        choco install sumatrapdf.install -y --verbose -log-file=C:\logs\chocolatey\sumatralog.log

        if ((Test-Path $SumatraPath) -eq $True) {
            Write-Output "Sumatra PDF successfully installed! Continuing installation.." "`n" | Green
        }
        else {
            Write-Output "$(Get-TimeStamp)"
            
        }

    ## Bitwarden

        Write-Verbose -Message "Installing Bitwarden" -Verbose
        choco install bitwarden -y --verbose -log-file=C:\logs\chocolatey\bitwardenlog.log

        if ((Test-Path $BitwardenPath) -eq $True) {
            Write-Output "Bitwarden Desktop successfully installed! Continuing installation.." "`n" | Green
        }
        else {
            Write-Output "$(Get-TimeStamp)"
            
        }
## Development
    # Git
        Write-Verbose -Message "Installing Git" -Verbose
        choco install git.install -y --verbose -log-file=C:\logs\chocolatey\gitlog.log

        if ((Test-Path $GitPath) -eq $True) {
            Write-Output "Git CMD successfully installed! Continuing installation.." "`n" | Green
        }
        else {
            Write-Output "$(Get-TimeStamp)"
        }

    # VSCode

        Write-Verbose -Message "Installing Visual Studio Code" -Verbose

        choco install vscode.install -y --verbose -log-file=C:\logs\chocolatey\vscodelog.log

        if ((Test-Path $VsCodePath) -eq $True) {
            Write-Output "Visual Studio Code successfully installed! Continuing installation.." "`n" | Green
        }
        else {
            Write-Output "$(Get-TimeStamp)"
        }

   # Sublime Text
        Write-Verbose -Message "Installing Sublime Text" -Verbose     
        choco install sublimetext3 -y --verbose -log-file=C:\logs\chocolatey\sublimelog.log

        if ((Test-Path $SublimePath) -eq $True) {
            Write-Output "Sublime Text 3 successfully installed! Continuing installation.." "`n" | Green
        }
        else {
            Write-Output "$(Get-TimeStamp)"
        }

    # Notepad ++ 7.8.5
        Write-Verbose -Message "Installing Notepad++ Version 7.8.5" -Verbose
        choco install notepadplusplus.install -y --verbose -log-file=C:\logs\chocolatey\notepadlog.log
        if ((Test-Path $NotepadPath) -eq $True) {
            Write-Output "Notepad++ successfully installed! Continuing installation.." "`n" | Green
        }
        else {
            Write-Output "$(Get-TimeStamp)"
        }

    # MobaXterm

        Write-Verbose -Message "Installing MobaXterm" -Verbose
        choco install mobaxterm --verbose -log-file=C:\logs\chocolatey\mobaxtermlog.log
        if ((Test-Path $MobaXtermPath) -eq $True) {
            Write-Output "MobaXterm successfully installed! Continuing installation.." "`n" | Green
        }
        else {
            Write-Output "$(Get-TimeStamp)"
        }

    # Putty
        Write-Verbose -Message "Installing PUTTY" -Verbose
        choco install putty -y --verbose -log-file=C:\logs\chocolatey\puttylog.log

        if ((Test-Path $PuttyPath) -eq $True) {
            Write-Output "PUTTY successfully installed! Continuing installation.." "`n" | Green
        }
        else {
            Write-Output "$(Get-TimeStamp)"
        }

    # OpenSSH
        Write-Verbose -Message "Installing OpenSSH" -Verbose
        choco install openssh -y --verbose -log-file=C:\logs\chocolatey\opensshlog.log
        if ((Test-Path $OpenSSHPath) -eq $True) {
            Write-Output "OpenSSH successfully installed! Continuing installation.." "`n" | Green
        }
        else {
            Write-Output "$(Get-TimeStamp)"
        }

# Languages
    # Python3
        Write-Verbose -Message "Installing Python3" -Verbose
        choco install python3 -y --verbose -log-file=C:\logs\chocolatey\python3log.log
        if ((Test-Path $Python3Path) -eq $True) {
            Write-Output "Python3 successfully installed! Continuing installation.." "`n" | Green
        }
        else {
            Write-Output "$(Get-TimeStamp)"
        }
    # Java
        Write-Verbose -Message "Installing Java" -Verbose
        choco install javaruntime -y --verbose -log-file=C:\logs\chocolatey\javalog.log
        if ((Test-Path $JavaPath) -eq $True) {
            Write-Output "Java successfully installed! Continuing installation.." "`n" | Green
        }
        else {
            Write-Output "$(Get-TimeStamp)"
        }
    # PHP7
        Write-Verbose -Message "Installing PHP7" -Verbose
        choco install php -y --verbose -log-file=C:\logs\chocolatey\php7log.log
        if ((Test-Path $Php7Path) -eq $True) {
            Write-Output "PHP successfully installed! Continuing installation.." "`n" | Green
        }
        else {
            Write-Output "$(Get-TimeStamp)"
        }
    # Docker
        Write-Verbose -Message "Installing Docker" -Verbose
        choco install php -y --verbose -log-file=C:\logs\chocolatey\dockerlog.log
        if ((Test-Path $DockerPath) -eq $True) {
            Write-Output "Docker successfully installed! Continuing installation.." "`n" | Green
        }
        else {
            Write-Output "$(Get-TimeStamp)"
        }
    #OpenVPN
        Write-Verbose -Message "Installing OpenVPN" -Verbose
        choco install php -y --verbose -log-file=C:\logs\chocolatey\dockerlog.log
        if ((Test-Path $OpenVPNPath) -eq $True) {
            Write-Output "OpenVPN successfully installed! Continuing installation.." "`n" | Green
        }
        else {
            Write-Output "$(Get-TimeStamp)"
        }

        choco install authy-desktop

        
## Update

    Write-Output "Checking update" | Green
    choco update all -y


Write-Host "All software installed!"