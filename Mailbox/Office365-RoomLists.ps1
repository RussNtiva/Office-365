#Russell Evans
#2018

#Get Commands : 

#Get Basic Info about a Room MB
Get-Mailbox -Identity "Test Room" | Format-List 

#Gets listing of Rooms setup with the Room Finder
Get-DistributionGroupMember -Identity "Room Finder" 

#Get listing of All RoomMailboxes
Get-Mailbox -ResultSize unlimited | select name,PrimarySmtpAddress,RecipientTypeDetails | Where {$_.RecipientTypeDetails-eq "RoomMailbox"}

#Get Any room lists that have been setup : 
Get-DistributionGroup | select Displayname,RecipientTypeDetails | Where {$_.RecipientTypeDetails-eq "RoomList"}

#Get Calendar Processing
Get-CalendarProcessing -Identity NYC-Conf-A | fl

#Room Creation and Modifications

#Create Room List
New-DistributionGroup -Name "London" -DisplayName "London" –PrimarySmtpAddress London@domain.com –RoomList

#Add Room to Group. In this case London is a room list, and Archimedes1 is the Room being added. 
Add-DistributionGroupMember –Identity "London" -Member Archimedes1@domain.com

#Rename Room Mailbox
Set-User ChiLoopFranklin@domain.com -FirstName "CHI Loop Franklin Conference Room"

#Change MailBox DisplayName
Set-Mailbox ChiWarnerBigTrain@domain.com -DisplayName "CHI Warner Training Room"

#Modify Settings 
# The string below Adds the Users name to the Subject, Deletes the Subject, Leaves any attachments, and Leaves and text in the Body of the Invite. The outcome of this is a Room Caledard that shows who booked the room, but doesnt show the subject. 
Set-CalendarProcessing -Identity NYC-Conf-A@domain.com -AddOrganizerToSubject $true -DeleteSubject $true -DeleteAttachments $false -DeleteComments $false

#Permissions for Calendar : 
Add-MailboxFolderPermission "NY Office Small Conference Room:\Calendar" -User RoomAdmins@domain.com -AccessRights Editor

