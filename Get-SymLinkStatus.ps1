$symLinkPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy Objects\*Machine\Software\Policies\Microsoft\Windows\Filesystems\NTFS"
if (Test-Path $symLinkPath) {
    Write-Host "symLinkPath Found"

    #Tests if SymLink GPO is ENABLED if disables, enables it

    Get-ItemProperty -Path $symLinkPath | Select-Object SymLink*

    if ((Get-ItemProperty -Path $symLinkPath | Select-Object SymLinkState -ExpandProperty SymLinkState) -eq 0) {

        Set-ItemProperty -Path $symLinkPath -Name "SymLinkState" -Value 1
        Write-Host SymLinkState set to 1

    } else {
        Write-Host SymLinkState already ENABLED
    }
    #Tests if SymlinkLocalToLocalEvaluation GPO is ENABLED if disables, enables it
    if ((Get-ItemProperty -Path $symLinkPath | Select-Object SymlinkLocalToLocalEvaluation -ExpandProperty SymlinkLocalToLocalEvaluation) -eq "0") {
        
        Set-ItemProperty -Path $symLinkPath -Name "SymlinkLocalToLocalEvaluation" -Value 1
        Write-Host SymlinkLocalToLocalEvaluation set to 1 
    } else {
        Write-Host SymlinkLocalToLocalEvaluation already ENABLED
    }


} else {
    exit
}