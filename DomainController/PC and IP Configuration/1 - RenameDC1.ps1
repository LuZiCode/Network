# Rename the computer
Rename-Computer -NewName "DC1"
Write-Host "Renamed the Server Name to DC1"

# Check if a restart is pending
$PendingRestart = Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager" -Name PendingFileRenameOperations -ErrorAction SilentlyContinue

if ($PendingRestart) {
    # If a restart is pending, prompt the user
    $RestartPrompt = Read-Host -Prompt "A restart is required to apply changes. Do you want to restart now? (Y/N)"

    if ($RestartPrompt -eq "Y") {
        Restart-Computer
    }
} else {
    Write-Host "No restart is necessary."
}
