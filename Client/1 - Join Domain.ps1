# Variables
$domain = "kursus1.com"
$domainUser = "Administrator"
$domainPassword = ConvertTo-SecureString "Passw0rd" -AsPlainText -Force 
$domainCredential = New-Object System.Management.Automation.PSCredential ($domainUser, $domainPassword)

$dnsServer = "192.168.1.1" 
$interfaceIndex = (Get-NetAdapter).ifIndex

# Set IP configuration
$ipAddress = "192.168.1.101"
$subnetMask = 24 # 24 bits for the subnet 255.255.255.0
$defaultGateway = "192.168.1.1"
New-NetIPAddress -InterfaceIndex $interfaceIndex -IPAddress $ipAddress -PrefixLength $subnetMask -DefaultGateway $defaultGateway

# Set DNS server
Set-DnsClientServerAddress -InterfaceIndex $interfaceIndex -ServerAddresses $dnsServer

# Add PC to domain
Add-Computer -DomainName $domain -Credential $domainCredential -Restart
