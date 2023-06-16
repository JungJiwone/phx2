# 정방향 조회 도메인 만들기 => 이미 만들어져있음 
# Add-DnsServerPrimaryZone -Name "vclass.phoenix" -ZoneFile "vclass.phoenix.dns"  

# 역방향 조회 도메인 만들기  => 주석에서 한글 사용 시 끝에 공백 추가하기!!! 
Add-DnsServerPrimaryZone -NetworkID 20.20.20.0/24 -ZoneFile "20.20.20.in-addr.arpa.dns"

# DNS 포워딩 
# Add-DnsServerForwarder -IPAddress 200.200.200.245 -PassThru

# Domain Controller Record
Add-DnsServerResourceRecordA -Name "PHX-vcsa" -ZoneName "vclass.phoenix" -IPv4Address "20.20.20.20"
Add-DnsServerResourceRecordPtr -Name "20" -ZoneName "20.20.20.in-addr.arpa" -PtrDomainName "PHX-vcsa.vclass.phoenix"

Add-DnsServerResourceRecordA -Name "PHX-esxi-01" -ZoneName "vclass.phoenix" -IPv4Address "20.20.20.11"
Add-DnsServerResourceRecordPtr -Name "11" -ZoneName "20.20.20.in-addr.arpa" -PtrDomainName "PHX-esxi-01.vclass.phoenix"

Add-DnsServerResourceRecordA -Name "PHX-esxi-02" -ZoneName "vclass.phoenix" -IPv4Address "20.20.20.12"
Add-DnsServerResourceRecordPtr -Name "12" -ZoneName "20.20.20.in-addr.arpa" -PtrDomainName "PHX-esxi-02.vclass.phoenix"

Add-DnsServerResourceRecordA -Name "PHX-esxi-03" -ZoneName "vclass.phoenix" -IPv4Address "20.20.20.13"
Add-DnsServerResourceRecordPtr -Name "13" -ZoneName "20.20.20.in-addr.arpa" -PtrDomainName "PHX-esxi-03.vclass.phoenix"
