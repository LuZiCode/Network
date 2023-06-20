$ForsestParameters = @{
    DomainName           = "kursus1.com"
    DomainNetbiosName    = "KURSUS1" 
    DomainMode           = "Win2012R2"
    DatabasePath         = "C:\Windows\NTDS" 
    LogPath              = "C:\Windows\NTDS" 
    SysvolPath           = "C:\Windows\SYSVOL"
    ForestMode           = "Win2012R2"
    InstallDns           = $true
    NoRebootOnCompletion = $true
    SafeModeAdministratorPassword = (ConvertTo-SecureString -String "Passw0rd" -AsPlainText -Force)
}


Write-Host "Applying @ForestParameters to the Post Deplayment Configuration"

Install-ADDSForest @ForsestParameters

$confirmation = Read-Host "Configuration complete. Would you like to restart the server now? (yes/no)"

if ($confirmation -eq "yes") {
    Restart-Computer -Force
} else {
    Write-Host "Server will not restart at this time. Please remember to restart the server manually."
}


