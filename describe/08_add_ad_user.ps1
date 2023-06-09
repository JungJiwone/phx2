## 파일을 다운로드하여 실행할 경우, Powershell의 실행 정책 설정을 확인해 주시길 바랍니다. 
## Get-ExecutionPolicy : 실행 정책 확인
## Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser 
## Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine 


## AD 모듈 설치 
Import-Module ActiveDirectory

## 주요 변수 설정 
$dcpath="DC=vclass,DC=phoenix"
$ou="Phoenix"
$groupname="phoenix"
$oupath="OU=" + $ou + "," + $dcpath

## OU 만들기 
New-ADOrganizationalUnit -Name $ou -Path $dcpath

## 생성된 OU를 삭제하고자 할 경우, 삭제 방지설정을 해제해야 함. 
## Get-ADOrganizationalUnit -Identity $oupath | Set-ADObject -ProtectedFromAccidentalDeletion:$false -PassThru | Remove-ADOrganizationalUnit -Confirm:$false 

## 생성된 OU내에 보안그룹 생성 
New-ADGroup -Name $groupname -GroupCategory Security -GroupScope Global -DisplayName $groupname -Path $oupath 

## AD 사용자를, OU내에 생성 + 그룹에 등록 
$count=0..10 #배열 변수 0~10
foreach ($i in $count)
{ 
  $username="PHX" + "{0:d2}" -f $i #10진법으로 2자리=00, 01, 02 ...
  New-AdUser -Name $username -Path $oupath -Enabled $True -AccountPassword (ConvertTo-SecureString "VMware1!" -AsPlainText -force) -passThru  -PasswordNeverExpires 1  
	#-PasswordNeverExpires 1 : 계정 만료 안시킴!
  Add-ADGroupMember -Identity $groupname -Members $username
 }
