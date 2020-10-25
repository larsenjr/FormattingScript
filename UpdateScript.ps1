
# UpdateScript
#
#
# 05.06.2020
# Stian Larsen

#Check that Powershell is opened in elevated mode. Opening the script in elevated mode and continiuing the script as normal.

if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{  
     Write-host "Your location is $ScriptDir"
    $arguments = "& '" +$myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Break
}

try {
    Write-host "Updating applications.. Please Wait." -ForegroundColor Yellow -ErrorAction Stop

    choco update all -y --verbose


    Write-host "Upgrading applications.. Please wait" -ForegroundColor Yellow -ErrorAction Stop

    choco upgrade all -y --verbose 
}
catch {
    Write-Error -Message "Houston we have a problem." -ErrorAction Stop
    Write-Output "Something threw an exception"
}

   if ($UpdatedPrograms -eq $True) {
        Out-Null
   }

   Read-host -Prompt "Press Enter to Exit"