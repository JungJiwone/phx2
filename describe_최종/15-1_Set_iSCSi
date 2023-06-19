# https://www.server-world.info/en/note?os=Windows_Server_2019&p=iscsi&f=1
# https://learn.microsoft.com/ko-kr/powershell/module/iscsitarget/?view=windowsserver2019-ps
# https://www.server-world.info/en/note?os=Windows_Server_2019&p=iscsi&f=3
# https://learn.microsoft.com/ko-kr/powershell/module/iscsitarget/new-iscsiservertarget?view=windowsserver2022-ps
# https://learn.microsoft.com/ko-kr/powershell/module/iscsitarget/new-iscsivirtualdisk?view=windowsserver2019-ps
# https://learn.microsoft.com/ko-kr/powershell/module/iscsitarget/set-iscsiservertarget?view=windowsserver2022-ps
# https://learn.microsoft.com/ko-kr/powershell/module/iscsitarget/add-iscsivirtualdisktargetmapping?view=windowsserver2019-ps


$driveletter = "Z"
$targetname = "iscsi-phx"
$diskpath = $driveletter + ":\iSCSIDisk\phx-LUN0.vhdx"
$disksize = 100GB

# create iSCSI Target
New-IscsiServerTarget -TargetName $targetname -InitiatorId @("IPAddress:20.20.30.11","IPAddress:20.20.30.12","IPAddress:20.20.30.13")

# create iSCSI virtual disk
New-IscsiVirtualDisk -Path $diskpath -SizeBytes $disksize 

# assign iSCSI virtual disk to iSCSI Target
Add-IscsiVirtualDiskTargetMapping -TargetName $targetname -Path $diskpath

# confirm settings
Get-IscsiServerTarget -TargetName $targetname 

# restart service
Restart-Service -Name WinTarget
