#############################################
# File: installWS1AppAllUsers.ps1
# Author: Phil
# Install WS1 APPX to All Users so that subsequent users get the app
#############################################

# Test if WS1 App has been downloaded
$WS1Apppath = [Environment]::GetEnvironmentVariable("ProgramFiles(x86)")+"\Airwatch\AgentUI\Resources\Bundle\AirWatchLLC.VMwareWorkspaceONE\"
$WS1Appfile = Get-ChildItem -Path $WS1Apppath -Filter *.appxbundle
$WS1Applicense = Get-ChildItem -Path $WS1Apppath -Filter *_License1.xml
if(Test-Path "$WS1Apppath\$WS1Appfile"){
    Add-AppxProvisionedPackage -Online -PackagePath $WS1Appfile.FullName -LicensePath $WS1Applicense.FullName;
} else {
    
}
