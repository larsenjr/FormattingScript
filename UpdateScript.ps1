# UpdateScript
#
#
# 05.06.2020
# Stian Larsen


$isAdmin = [bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")

    if ($isAdmin -eq $False) {
        Write-Host "You need to start this script as admin!" "`n"
        Start-Sleep -Seconds 2
        $InstallationPath = Get-Location
        Start-Process powershell -Verb runAs
    }

    Write-host "Updating applications.. Please Wait." -ForegroundColor Yellow

    choco update all -a --verbose


    Write-host "Upgrading applications.. Please wait" -ForegroundColor Yellow
    choco upgrade all -a --verbose 
   

   if ($UpdatedPrograms -eq $True) {
        Out-Null
   }