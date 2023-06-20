# Import the ActiveDirectory module
Import-Module ActiveDirectory

# Specify the domain
$domain = "DC=kursus1,DC=com"

# Specify the OU names and their corresponding full names
$ousAndFullNames = @{
    "Direktør" = @("Egon Ejermand")
    "Økonimi" = @("Jens Jyde", "Ole Opfinder")
    "Løn" = @("Inger Ingenpenge", "Sten Sparemand")
    "Kursus" = @("Vanessa Vedingeting")
    "Marketing" = @("Susanne Sætisø")
    "Lærerteamet" = @("Bent Bogorm", "Hugo Hæmnigsløs", "Claus Cludder")
    "IT Helpdesk" = @("Søren Supernørd")
    "Kundeservice" = @("Niels Næsvis")
    "HR" = @("Søren Styrpåting")
}

# Iterate through each OU and create users
foreach ($ou in $ousAndFullNames.Keys) {
    $ouPath = "OU=$ou,$domain"

    # Iterate through each full name in the current OU
    foreach ($fullName in $ousAndFullNames[$ou]) {
        $nameParts = $fullName -split " "
        $firstName = $nameParts[0]
        $lastName = $nameParts[1]
        $login = $firstName.Substring(0, 2) + $lastName.Substring(0, 2)
        $password = "Passw0rd"

        # Check if the user already exists
        if (-not (Get-ADUser -Filter { SamAccountName -eq $login })) {
            # If the user doesn't exist, create it
            New-ADUser -Name $fullName -SamAccountName $login -GivenName $firstName -Surname $lastName `
                -UserPrincipalName "$login@$domain" -Path $ouPath -AccountPassword (ConvertTo-SecureString -String $password -AsPlainText -Force) -Enabled $true
            Write-Host "Created user: $fullName with login: $login"
        } else {
            Write-Host "Skipped creating user: $fullName. User already exists with login: $login"
        }
    }
}

# Confirm the users were created
Get-ADUser -Filter *
