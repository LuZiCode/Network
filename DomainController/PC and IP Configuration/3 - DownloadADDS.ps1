# Check if AD DS role is already installed
$ADDSInstalled = Get-WindowsFeature -Name AD-Domain-Services | Select-Object -ExpandProperty Installed

# If AD DS role is not installed, proceed with installation
if (!$ADDSInstalled) {
    # Install AD DS role
    Write-Host "Installing Active Directory Domain Services (AD DS)..."
    Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools -Restart
}
else {
    Write-Host "Active Directory Domain Services (AD DS) is already installed."
}
