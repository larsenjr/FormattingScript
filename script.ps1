#Requires -RunAsAdministrator
# Install script for formatting PC
# April 2020
# Stian Larsen
# 
# NB! - Need internet to work

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


# Check that Powershell is opened in elevated mode

$isAdmin = [bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")

    if ($isAdmin -eq $False) {
        Write-Host "You need to start this script as admin!" "`n"
        Start-Sleep -Seconds 2
        Start-Process powershell_ise -Verb runAs
    }

## .bat script for running ExecutionPolicy
    if ($isAdmin -eq $True) {
        $RunBat = .\executionPolicy.bat 
        $UserCredentidals = "NT AUTHORITY\SYSTEM"
        Start-Process 'cmd.exe' -Credential $UserCredentidals -ArgumentList "/c $RunBat"
        Write-Output "Setting ExecutionPolicy to Bypass"
    }

# Functions

    # Get the timestamp. Used to track error-messages
    function Get-TimeStamp {
        return "[{0:MM/dd/yy} {0:HH:mm:ss}]" -f (Get-Date)
    }

    # Function for green writing
    function Green {
        process { Write-Host $_ -ForegroundColor Green }
    }

#Install choco package with powershell

    Write-Output "Configuring chocolatey.." | Green

    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Installing programs
    $InstalledPrograms = @(
        "googlechrome", 
        "firefox",
        "7zip.install",
        "vlc",
        "discord.install",
        "sharex",
        "teamviewer",
        "spotify",
        "classic-shell",
        "sumatrapdf",
        "bitwarden",
        "git.install",
        "vscode.install",
        "sublimetext3",
        "notepadplusplus.install",
        "mobaxterm",
        "putty",
        "openssh",
        "python3",
        "php",
        "docker-cli",
        "openvpn" 
    )

    foreach ($Program in $InstalledPrograms) {
        Write-Verbose "Installing $InstalledPrograms" | Green
            choco install $InstalledPrograms -y --verbose | Out-file "C:\logs\chocolatey\$InstalledPrograms.log"

        if ((Test-path $InstalledPrograms) -eq $True) {
            Write-Output "$InstalledPrograms successfully installed! Continuing installation.." | Green
        }

        else {
            Write-Output "$(Get-TimeStamp)"
        }
    }

## Update

    Write-Output "Checking updates" | Green
        choco update all -a


## Checking upgrades.

    Write-Output "Checking Upgrades" | Green
        choco upgrade all -a
        
# Removes Windows default programs

    Write-Host "Removing Windows Bloatware." -ForegroundColor Yellow
        $AppList = 
            "*3DBuilder*",
            "*Getstarted*",
            "*WindowsAlarms*",
            "*WindowsCamera*",
            "*bing*",
            "*MicrosoftOfficeHub*",
            "*OneNote*",
            "*people*",
            "*WindowsPhone*",
            "*photos*",
            "*SkypeApp*",
            "*solit*",
            "*WindowsSoundRecorder*",
            "*windowscommunicationsapps*",
            "*zune*",
            "*WindowsMaps*",
            "*Sway*",
            "*CommsPhone*",
            "*ConnectivityStore*",
            "*Microsoft.Messaging*",
            "*Facebook*",
            "*Twitter*",
            "*Drawboard PDF*"

    ForEach ($App in $AppList) {
        $AppPackageFullName = (Get-AppxPackage $App).PackageFullName

        if ($AppPackageFullName) {
            Write-Host "Removing Package: $App"
            Remove-AppxPackage -package $PackageFullName
        }
        else {
            Write-host "Unable to find package: $App"
        }
    }
    
# Prompt for new ComputerName
    $NewComputerName = Read-Host -Prompt "Enter New Computer name: "
    Write-Host "Changing name.." -ForegroundColor Yellow | Rename-Computer -NewName $NewComputerName

    Write-host "$env:COMPUTERNAME needs to be restarted. Do you want to do it now?" -ForegroundColor Yellow

# Scheduled Task
    $Path = Get-Location
    $Action= New-ScheduledTaskAction -Execute "Powershell.exe" -Argument "$env:USERPROFILE\script.ps1"
    $TaskTrigger = New-ScheduledTaskTrigger -AtLogon -RunOnce
    $TaskUser = New-ScheduledTaskPrincipal "$env:USERPROFILE"
    $TaskSettingSet = New-ScheduledTaskSettingsSet
    $NewTask = New-ScheduledTask -Action $Action -Principal $TaskUser -Trigger $TaskTrigger -Settings $TaskSettingSet

    $Confirmation = Read-host " ( y / n ) "


    switch ($Confirmation) {
            y {Write-Host "Your computer will be restarted in 5 seconds" -ForegroundColor Green; Register-ScheduledTask Script.ps1 -InputObject $NewTask; Start-Sleep 5; Restart-Computer}
            n {Write-Host "You have to manually restart $env:COMPUTERNAME by yourself for the changes to take effect" -ForegroundColor Red; Exit;}
        }

    if($Confirmation -eq 'yes') {
        Start-Sleep -Seconds 5; Restart-Computer
    }

    else {
        Out-Null;
    }


# Domain Join
    $IfShouldJoinDomain = Read-Host -Prompt "Should the computer join a domain? "
# Adding machine to Domain
    if ($IfShouldJoinDomain -eq 'y') {
        $WriteDomain = Read-Host -Prompt "Specify your domain name (*domain*\*user*)"
        Add-Computer -DomainName $WriteDomain
    }

# Adding computer to Workgroup
    if ($IfShouldJoinDomain -eq 'n') {
        $NoDomainAssignWorkgroup = 'WORKGROUP'

            if ($AlreadyWorkGroup -eq $True) {
                Out-Null;
            }
            if ($NoDomainAssignWorkgroup -eq $False) {
                $GetComputer= Get-ComputerName
                Add-Computer -WorkgroupName $GetComputer  | Start-Sleep -Seconds 5; Restart-Computer;
            }
    }

    Read-Host "Press any key to continue" | Out-Null