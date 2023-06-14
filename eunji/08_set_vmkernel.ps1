# install PowerCLI
Install-Module -Name VMware.PowerCLI -Whatif

# warning ignore
Set-PowerCLIConfiguration -Scope AllUser -ParticipateInCEIP $false -Whatif

# Certification ignore
Set-PowerCLIConfiguration -InvaildCertificateAction Igroe -Whatif

# Connect to VMware vSphere server
Connect-VIServer -Server sa-vcsa-01.vclass.local -User administrator@vsphere.local -Password VMware1!

# VMkernel NIC 업링크 구성
$esxiHostname = "sa-esxi-04.vclass.local"
$vmknicName = "vmk1"
$uplinkNic = "vmnic2"

$esxiHost = Get-VMHost -Name $esxiHostname
$vmknic = Get-VMHostNetworkAdapter -VMHost $esxiHost -Name $vmknicName

# 기존에 사용 중인 업링크 제거
$vmknic | Get-VMHostNetworkAdapterPhysicalNic -Uplink | ForEach-Object {
    Remove-VMHostNetworkAdapter -VMHostPhysicalNic $_ -Confirm:$false
}

# 새로운 업링크 추가
$uplinkNicObj = Get-VMHostNetworkAdapter -VMHost $esxiHost -Name $uplinkNic
Add-VMHostNetworkAdapter -VMHost $esxiHost -VirtualSwitch $vmknic.VirtualSwitch -PortGroup $vmknic.PortGroup -PhysicalNic $uplinkNicObj

# VMware vSphere 서버와의 연결 종료
Disconnect-VIServer -Server <vcenter_server> -Force