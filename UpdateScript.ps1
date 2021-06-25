## UpdateScript for Chocolatey


if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  {  
        Write-host "Your location is $ScriptDir"
        $arguments = "& '" +$myinvocation.mycommand.definition + "'"
        Start-Process powershell -Verb runAs -ArgumentList $arguments
        Break
    }

try {
    Write-host "Updating applications.. Please Wait." -ForegroundColor Yellow
        choco update all -y --verbose

    Write-host "Upgrading applications.. Please wait" -ForegroundColor Yellow

    choco upgrade all -y --verbose 
    }


catch {
        Write-Error -Message "Houston we have a problem." -ErrorAction Stop
        Write-Output "Something threw an exception"
    }

if ($UpdatedPrograms -eq $True) {
        Out-Null
        Write-Output "Updated programs successfully"
   }

## Remove all shortcuts on desktop

try {
    $DesktopFolder = (Get-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders").Desktop
    $DesktopFolder2 = (Get-ItemProperty "C:\Users\Public\Desktop").Desktop
    $DesktopShortcuts = Get-ChildItem $DesktopFolder
    $DesktopShortcuts2 = Get-ChildItem $DesktopFolder2

    foreach ($Shortcut in $DesktopShortcuts) {
        if ($Shortcut -match "$_.lnk") {
                Remove-item $Shortcut.FullName
                Write-Output "$Shortcut link shortcut in $DesktopFolder removed"
            }
        elseif ($Shortcut -match "$_.url") {
                Remove-item $Shortcut.FullName
                Write-Output "$Shortcut url shortcut in $DesktopFolder removed"
            }
        elseif ($Shortcut -match "$_.exe") {
            Remove-item $Shortcut.FullName
            Write-Output "$Shortcut exe shortcut in $DesktopFolder removed"
            }
    }
        
}

catch [System.IO.FileNotFoundException], [System.IO.DirectoryNotFoundException] {
    Write-Output "$(Get-TimeStamp) - Houston, you have a problem" 
    
}

   Read-host -Prompt "Press Enter to Exit."