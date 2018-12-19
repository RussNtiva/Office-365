#Create Distribution Lists in O365 
New-DistributionGroup -Name "ACG_Region_US" -Type Distribution -PrimarySmtpAddress "ACG_Region_US@domain.com"
#Change Primary SMTP Address of Group
Set-DistributionGroup -Identity "ACG_Region_US" -PrimarySmtpAddress "ACG_Region_US@domain.com"
#Import Users from CSV
Import-Csv 'C:\ActiveScripts\Distribution Groups\ACG_Region_US.csv' | foreach{Add-DistributionGroupMember -Identity "ACG_Region_US" -Member $_.UPN}

Get-DistributionGroupMember -Identity "ACG_Region_US" -ResultSize unlimited | Export-Csv -Path 'C:\ActiveScripts\Distribution Groups\ACG_Region_US_listing.csv'