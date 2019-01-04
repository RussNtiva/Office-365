#To get a list of all the policies and the corresponding IM settings
Get-CsClientPolicy | ft Identity,DisableSavingIM,EnableIMAutoArchiving
#To get only the policies with disabled conversation historya
Get-CsClientPolicy | ? {$_.DisableSavingIM -eq $true} | ft Identity,DisableSavingIM,EnableIMAutoArchiving
#To See what policy is Enabled for a user.
Get-CsOnlineUser -Identity user@domain.com | ft ClientPolicy
#Get Policy Information
Get-CsClientPolicy -Identity ClientPolicyNoSaveIMNoArchivingNoIMURL
#Set CS Policy for a particular User.
Grant-CsClientPolicy -PolicyName Tag:ClientPolicyNoSaveIMNoArchivingNoIMURL -Identity user@domain.com
Grant-CsClientPolicy -PolicyName Tag:ClientPolicyNoSaveIMNoArchivingNoIMURL -Identity user@domain.com

