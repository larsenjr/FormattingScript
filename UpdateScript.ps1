
# UpdateScript
#
#
# 05.06.2020
# Stian Larsen

$isAdmin = [bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")

    if ($isAdmin -eq $False) {
        Write-Host "You need to start this script as admin!" "`n"
        $ScriptDir = Split-Path $script:MyInvocation.MyCommand.Path
        Write-host "Your location is $ScriptDir"
        Start-Sleep -Seconds 2
       
        $FilePath = Resolve-Path "UpdateScript.ps1"

        Start-Process powershell -Verb runAs -Command Set-location $Scriptdir | Push-Location $FilePath

    }

    $AnswerText = "n";

    if ($AnswerText -eq $True) {
        Out-Null
        Exit;
    }
Write-host "Updating applications.. Please Wait." -ForegroundColor Yellow

    choco update all -y --verbose


    Write-host "Upgrading applications.. Please wait" -ForegroundColor Yellow

    choco upgrade all -y --verbose 
   

   if ($UpdatedPrograms -eq $True) {
        Out-Null
   }

   Read-host -Prompt "Press Enter to Exit"