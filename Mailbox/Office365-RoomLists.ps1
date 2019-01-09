#Russell Evans
#2018

#Get Commands : 

#Get Basic Info about a Room MB
Get-Mailbox -Identity "NY Soho Conference Room" | Format-List 

#Gets listing of Rooms setup with the Room Finder
Get-DistributionGroupMember -Identity "NYC" 

#Get listing of All RoomMailboxes
Get-Mailbox -ResultSize unlimited | select name,PrimarySmtpAddress,RecipientTypeDetails | Where {$_.RecipientTypeDetails-eq "RoomMailbox"}

#Get Any room lists that have been setup : 
Get-DistributionGroup | select Displayname,RecipientTypeDetails | Where {$_.RecipientTypeDetails-eq "RoomList"}

#Get Calendar Processing
Get-CalendarProcessing -Identity "Sunset Room" | fl

#Room Creation and Modifications

#Remove Room List
Remove-DistributionGroup -Identity "NJ"

#Create Room
New-Mailbox -Name ConfRoom1 -DisplayName "Conference Room 1" -Room

#Create Room List
New-DistributionGroup -Name "London" -DisplayName "London" -PrimarySmtpAddress London@domain.com -RoomList

#Add Room to Group. In this case London is a room list, and Archimedes1 is the Room being added. 
Add-DistributionGroupMember -Identity "London" -Member Archimedes1@domain.com

#Rename Existing Room MBs
Set-Mailbox "NYC-Conf-A@domain.com" -DisplayName "NY Central Park Conference Room" -Name "NY Central Park Conference Room" -Alias CentralParkCR -EmailAddresses SMTP:CentralParkCR@domain.com,smtp:NYC-Conf-A@domain.com -ResourceCapacity 14 

#changes the display name, the primary SMTP address (called the default reply address), and the room capacity. Also, the previous reply address is kept as a proxy address.
Set-Mailbox "NYC-Conf-A@domain.com" -DisplayName "Central Park" -EmailAddresses SMTP:CentralParkCR@domain.com,smtp:NYC-Conf-A@domain.com -ResourceCapacity 14

#Change MailBox DisplayName
Set-Mailbox ChiWarnerBigTrain@domain.com -DisplayName "CHI Warner Training Room"

#Modify Settings 
# The string below Adds the Users name to the Subject, Deletes the Subject, Leaves any attachments, and Leaves and text in the Body of the Invite. The outcome of this is a Room Caledard that shows who booked the room, but doesnt show the subject. 
Set-CalendarProcessing -Identity sunsetroom@domain.com -AddOrganizerToSubject $true -DeleteSubject $true -DeleteAttachments $false -DeleteComments $false

#Permissions for Calendar : Tracy Dwyer <user@domain.com>
Add-MailboxFolderPermission "NYC-Conf-A:\Calendar" -User user@domain.com -AccessRights Editor

#Set Default Permissions on Calendar to Free Busy
Set-MailboxFolderPermission "NY Central Park Conference Room:\Calendar" -User "Default" -AccessRights AvailabilityOnly

# Script to Set Delegate, and Cal Processing properties for NYC
Import-csv C:\ActiveScripts\1-8-2019\NYCRooms.csv | foreach {Set-calendarprocessing -Identity $_.alias –ResourceDelegate newyorkapprover@domain.com --AutomateProcessing:AutoAccept -deletecomments $false -deleteattachments $false -deletesubject $false -MaximumDurationInMinutes 1440 -BookingWindowInDays 1080 -AllRequestInPolicy $true -AllBookInPolicy $false -DeleteNonCalendarItems $false}

# Script to add full access rights for the Con Manager Group to Room Mailboxes

Import-csv C:\ActiveScripts\1-8-2019\NYCRooms.csv | foreach {Add-MailBoxPermission -identity $_.alias -User ConManagers -AccessRights FullAccess -Automapping $False}

#Set ConManagerNY485 Mail Enabled Sec Group full access to New York Approvers Shared MB
Add-MailboxPermission newyorkapprover@domain.com -user ConManagers -AccessRights FullAccess