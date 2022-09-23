if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

$currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent() | Select-Object Name -ExpandProperty Name
Write-Host "Promoting user $currentUser would you like to continue?"
$Confirmation = Read-Host "Y/N"
if ($confirmation -like "Y") {
    Add-LocalGroupMember -Group "Administrators" -Member $currentUser
} else { exit }