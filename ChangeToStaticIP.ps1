# Define the parameters for the static IP configuration
$IPAddress = "192.168.1.100"
$SubnetMask = "255.255.255.0"
$DefaultGateway = "192.168.1.1"  # Replace with the actual default gateway IP address

# Get the network adapter interface index for the internal switch
$InterfaceIndex = (Get-NetAdapter | Where-Object {$_.Name -like "*Ethernet*"}).InterfaceIndex

# Check if the IP configuration already exists
$ExistingIPConfig = Get-NetIPAddress -InterfaceIndex $InterfaceIndex -AddressFamily IPv4 -ErrorAction SilentlyContinue
if ($ExistingIPConfig) {
    Write-Host "Static IP address configuration already exists for the internal network on the DC1 Server."
    Write-Host "Skipping IP configuration."
}
else {
    # Set the static IP address configuration
    $StaticIPConfig = New-NetIPAddress -InterfaceIndex $InterfaceIndex -IPAddress $IPAddress -PrefixLength 24

    # Set the subnet mask
    $StaticIPConfig | Set-NetIPAddress -PrefixLength 24 -IPAddress $IPAddress

    # Set the default gateway
    $DefaultGatewayConfig = New-NetRoute -InterfaceIndex $InterfaceIndex -DestinationPrefix "0.0.0.0/0" -NextHop $DefaultGateway

    # Print output to the user
    Write-Host "Static IP address configuration for the internal network completed:"
    Write-Host "IP Address:    $IPAddress"
    Write-Host "Subnet Mask:   $SubnetMask"
    Write-Host "Default Gateway:   $DefaultGateway"
}
