
# Install script for formatting PC
# 2020
# Stian Larsen
# 
# NB! - Need internet to work


# Check that Powershell is opened in elevated mode
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {  
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Break
}
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
$Php7Path = "C:\Tools\php74\php.exe"
$DockerPath = "C:\Program Files\Docker\Docker\Docker Desktop.exe"
$OpenVPNPath = "C:\Program Files\OpenVPN\bin\openvpn-gui.exe"


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
    "openvpn",
    "google-backup-and-sync"
)

try {
    foreach ($Program in $InstalledPrograms) {
        Write-Verbose "Installing $InstalledPrograms" | Green
        choco install $InstalledPrograms -y --verbose | Out-file "C:\logs\chocolatey\installed$Get-Date.log"
    
        if ((Test-path $InstalledPrograms) -eq $True) {
            Write-Output "$InstalledPrograms successfully installed! Continuing installation.." | Green
        }
    
        else {
            Write-Output "$(Get-TimeStamp)"
            Out-Null;
        }
    }
}
catch [System.IO.FileNotFoundException], [System.IO.DirectoryNotFoundException] {
    Write-Output "$(Get-TimeStamp) - Houston, you have a problem"
        
}
    
# Update
powershell.exe -file "B:\Projects\FormattingScript\UpdateScript.ps1"
        
# Removes Windows default programs

try {
    Write-Host "Removing Windows Bloatware." -ForegroundColor Yellow
    $AppList = @(
        "Microsoft.3DBuilder",
        "Microsoft.Appconnector",
        "Microsoft.BingFinance",
        "Microsoft.BingNews",
        "Microsoft.BingSports",
        "Microsoft.BingTranslator",
        "Microsoft.BingWeather",
        "Microsoft.GamingServices",
        "Microsoft.Microsoft3DViewer",
        "Microsoft.MicrosoftOfficeHub",
        "Microsoft.MicrosoftPowerBIForWindows",
        "Microsoft.MicrosoftSolitaireCollection",
        "Microsoft.MinecraftUWP",
        "Microsoft.NetworkSpeedTest",
        "Microsoft.Office.OneNote",
        "Microsoft.People",
        "Microsoft.Print3D",
        "Microsoft.SkypeApp",
        "Microsoft.Wallet",
        "Microsoft.WindowsAlarms",
        "Microsoft.WindowsCamera",
        "microsoft.windowscommunicationsapps",
        "Microsoft.WindowsMaps",
        "Microsoft.WindowsPhone",
        "Microsoft.WindowsSoundRecorder",
        "Microsoft.Xbox.TCUI",
        "Microsoft.XboxApp",
        "Microsoft.XboxSpeechToTextOverlay",
        "Microsoft.YourPhone",
        "Microsoft.ZuneMusic",
        "Microsoft.ZuneVideo"
    )

    ForEach ($App in $AppList) {
        $AppPackageFullName = (Get-AppxPackage $App).PackageFullName

        if ($AppPackageFullName) {
            Write-Host "Removing Package: $App"
            Remove-AppxPackage -package $PackageFullName -AllUsers
        }
        else {
            Write-host "Unable to find package: $App"
        }
    }
}
catch {
    Write-Output "$(Get-TimeStamp) - Houston, you have a problem"
    Write-Error -Exception -ErrorAction Stop
}

    
# Prompt for new ComputerName

try {
    $NewComputerName = Read-Host -Prompt "Enter New Computer name: "
    Write-Host "Changing name.." -ForegroundColor Yellow | Rename-Computer -NewName $NewComputerName

    Write-host "$env:COMPUTERNAME needs to be restarted. Do you want to do it now?" -ForegroundColor Yellow
}
catch {
    Write-Output "$(Get-TimeStamp) - Houston, you have a problem"
    Write-Error -Message -Exception "Could not change $env:COMPUTERNAME"
}

#Scheduled Task

Import-Module TaskScheduler $task = New-Task
$task.Settings.Hidden = $true
Add-TaskAction -Task $task -Path C:\Windows\system32\WindowsPowerShell\v1.0\powershell.exe –Arguments “-File B:\Projects\FormattingScript\script.ps1”
Add-TaskTrigger -Task $task -Daily -At “10:00”
Register-ScheduledJob –Name ”Continiuing PowerShellScript” -Task $task

$Trigger = New-ScheduledTaskTrigger -At 10:00am –Daily # Specify the trigger settings
$User = "NT AUTHORITY\SYSTEM" # Specify the account to run the script
$Action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "C:\PS\StartupScript.ps1" # Specify what program to run and with its parameters
Register-ScheduledTask -TaskName "PowerShellScript" -Trigger $Trigger -User $User -Action $Action -RunLevel Highest –Force # Specify the name of the task
try {
        
    $Path = Get-Location
    $Action = New-ScheduledTaskAction -Execute "Powershell.exe" -Argument "$env:USERPROFILE\script.ps1"
    $TaskTrigger = New-ScheduledTaskTrigger -AtLogon
    $TaskUser = New-ScheduledTaskPrincipal "$env:USERPROFILE"
    $TaskSettingSet = New-ScheduledTaskSettingsSet
    $NewTask = New-ScheduledTask -Action $Action -Principal $TaskUser -Trigger $TaskTrigger -Settings $TaskSettingSet

    $Confirmation = Read-host " ( y / n ) "

    switch ($Confirmation) {
        y { Write-Host "Your computer will be restarted in 5 seconds" -ForegroundColor Green; Register-ScheduledTask Script.ps1 -InputObject $NewTask; Start-Sleep 5; Restart-Computer }
        n { Write-Host "You have to manually restart $env:COMPUTERNAME by yourself for the changes to take effect" -ForegroundColor Red; Exit; }
    }

    if ($Confirmation -eq 'yes') {
        Start-Sleep -Seconds 5; Restart-Computer
    }
        
    else {
        Out-Null;
    }
}
catch {
    Write-Output "$(Get-TimeStamp) - Houston, you have a problem!"
    Write-Error -Exception -ErrorAction Stop
}

try {
    # Domain Join
    $IfShouldJoinDomain = Read-Host -Prompt "Should the computer join a domain? "
    # Adding machine to Domain
    if ($IfShouldJoinDomain -eq 'y') {
        $WriteDomain = Read-Host -Prompt "Specify your domain name (*domain*\*user*)"
        Add-Computer -DomainName $WriteDomain

        # Adding computer to Workgroup
        if ($IfShouldJoinDomain -eq 'n') {
            $NoDomainAssignWorkgroup = 'WORKGROUP'

            if ($AlreadyWorkGroup -eq $True) {
                Out-Null;
            }
            if ($NoDomainAssignWorkgroup -eq $False) {
                $GetComputer = Get-ComputerName
                Add-Computer -WorkgroupName $GetComputer  | Start-Sleep -Seconds 5; Restart-Computer;
            }
        }
    }
}
catch {
    Write-Output "$(Get-TimeStamp) - Houston, you have a problem!"
    Write-Error -Exception -ErrorAction Stop
}

# Easy command for removing all shortcuts, links and .exe from your desktop. 

try {
    $DesktopFolder = (Get-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders").Desktop
    $DesktopShortcuts = Get-ChildItem $DesktopFolder
    
    foreach ($item in $DesktopShortcuts) {
        if ($item -match "$_.lnk") {
            Remove-item $item.FullName
            Write-Output "$item link shortcut in $DesktopFolder removed"
        }
        elseif ($item -match "$_.url") {
            Remove-item $item.FullName
            Write-Output "$item url shortcut in $DesktopFolder removed"
        }
        elseif ($item -match "$_.exe") {
            Remove-item $item.FullName
            Write-Output "$item url shortcut in $DesktopFolder removed"
        }
    }
}
catch [System.IO.FileNotFoundException], [System.IO.DirectoryNotFoundException] {
    Write-Output "$(Get-TimeStamp) - Houston, you have a problem" 
        
}


## Adding the other disk drives. this is not working properly yet!
$PartitionDisk = Get-Disk | Where PartitionStyle -eq 'raw'

if ($PartitionDisk -eq $true) {
    Initialize-disk -PartitionStyle "MBR" -PassThru | New-Partition -AssignDriveLetter -UseMaximumSize |
    Format-Volume -FileSystem NTFS -NewFileSystemLabel "Disk2" -Confirm:$true | Set-disk -Number 2 -IsReadOnly $False -AsJob
}
else {
    Continue;
}

Read-Host "Press any key to continue" | Out-Null


   