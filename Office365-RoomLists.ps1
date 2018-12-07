#Russell Evans
#2018

#Get Commands : 

#Get Basic Info about a Room MB
Get-Mailbox -Identity "Room Name" 

#Gets listing of Rooms setup with the Room Finder
Get-DistributionGroupMember -Identity "Room Finder" 

#Get listing of All RoomMailboxes
Get-Mailbox -ResultSize unlimited | select name,RecipientTypeDetails | Where {$_.RecipientTypeDetails-eq "RoomMailbox"}

#Get Any room lists that have been setup : 
Get-DistributionGroup | select Displayname,RecipientTypeDetails | Where {$_.RecipientTypeDetails-eq "RoomList"}

#Room Creation and Modifications

#Create Room List
New-DistributionGroup -Name "London" -DisplayName "London" –PrimarySmtpAddress London@domain.com –RoomList

#Add Room to Group. In this case London is a room list, and Archimedes1 is the Room being added. 
Add-DistributionGroupMember –Identity "London" -Member Archimedes1@domain.com
