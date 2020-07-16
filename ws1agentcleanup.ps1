#############################################
# File: ws1agentcleanup.ps1
# Author: Phil Helmling
# Date: 12 September 2019
# Script to uninstall and cleanup WorkspaceONE Agent and residual items for testing/re-testing purposes
#############################################
#Uninstall Agent - requires manual delete of device object in console
$b = Get-WmiObject -Class win32_product -Filter "Name like 'Workspace ONE Intelligent Hub'"
$b.Uninstall()
#uninstall WS1 App
Get-AppxPackage *AirWatchLLC* | Remove-AppxPackage
 
#Delte reg keys
Remove-Item -Path HKLM:\SOFTWARE\Airwatch\* -Recurse
Remove-Item -Path HKLM:\SOFTWARE\AirwatchMDM\* -Recurse
Remove-Item -Path HKLM:\SOFTWARE\Microsoft\EnterpriseResourceManager\Tracked\* -Recurse
Remove-Item -Path HKLM:\SOFTWARE\Microsoft\Enrollments\* -Recurse
Remove-Item -Path HKLM:\SOFTWARE\Microsoft\Provisioning\omadm\Accounts\* -Recurse
# may not work ;)
Remove-Item -Path HKLM:\SOFTWARE\Microsoft\EnterpriseDesktopAppManagement\*\MSI\* -Recurse
 
#Delete folders
$path = "$env:ProgramData\AirWatch\UnifiedAgent\Logs\"
Get-ChildItem $path -Recurse |Remove-Item -Force
# del %programdata%\AirWatch\UnifiedAgent\Logs\*.*
 
#delete certificates
$Certs = get-childitem cert:"CurrentUser" -Recurse
$AirwatchCert = $certs | Where-Object {$_.Issuer -eq "CN=AirWatchCa"}
foreach ($Cert in $AirwatchCert) {
    $cert | Remove-Item -Force
}
 
$AirwatchCert = $certs | Where-Object {$_.Subject -like "*AwDeviceRoot*"}
foreach ($Cert in $AirwatchCert) {
    $cert | Remove-Item -Force
}
