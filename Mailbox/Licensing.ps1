Get-MsolAccountSku | Select -ExpandProperty ServiceStatus

Get-MSOLUser -All | select userprincipalname,islicensed,{$_.Licenses.AccountSkuId}| Export-CSV c:\userlist.csv -NoTypeInformation