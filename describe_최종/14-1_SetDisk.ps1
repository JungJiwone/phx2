# https://learn.microsoft.com/en-us/powershell/module/storage/set-disk?view=windowsserver2022-ps
# https://learn.microsoft.com/en-us/powershell/module/storage/initialize-disk?view=windowsserver2022-ps
# https://learn.microsoft.com/en-us/powershell/module/storage/set-partition?view=windowsserver2022-ps
# https://learn.microsoft.com/en-us/powershell/module/storage/get-partition?view=windowsserver2022-ps
# https://learn.microsoft.com/en-us/powershell/module/storage/format-volume?view=windowsserver2022-ps
# https://tiprelay.com/%EC%9C%88%EB%8F%84%EC%9A%B010%EC%97%90%EC%84%9C-powershell%EB%A1%9C-%EB%93%9C%EB%9D%BC%EC%9D%B4%EB%B8%8C%EB%A5%BC-%ED%8F%AC%EB%A7%B7%ED%95%98%EB%8A%94-%EB%B0%A9%EB%B2%95/

$disknum = 1
$driveletter = "Z"

# Set disk online
Set-disk -Number $disknum -IsOffline $false

# initailize disk partitionstyle
Initialize-Disk -Number $disknum -PartitionStyle MBR

New-Partition -DiskNumber $disknum -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel myDrive

Get-Partition -DiskNumber $disknum | Set-Partition -NewDriveLetter $driveletter

# install iSCSI Target with admin tools
Install-WindowsFeature FS-iSCSITarget-Server -IncludeManagementTools

# restart computer to apply changes
Restart-Computer -Force 
