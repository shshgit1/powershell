try{

$getDateTime=Get-Date
$today=Get-Date

$logfilePath= #log file path
$logfilePath2= #log file path
$errorLogPath= #error log path


$exist= Test-Path -Path "C:\ProgramData\Cisco\Cisco Secure Client\Umbrella\Orginfo.json"
if($exist){
echo "secure client installed. time now is $getDateTime" >> $logfilePath
}
else{
echo "secure client not installed. time now is $getDateTime" >> $logfilePath
New-Item -Path C:\cisco -Force -ItemType Directory

Copy-Item -Path "#source of umbrella installation file" -Destination "C:\cisco\cisco-core-vpn-predeploy-k9.msi" -Force  >> $logfilePath
Copy-Item -Path "#source of umbrella installation file" -Destination "C:\cisco\cisco-umbrella-predeploy-k9.msi" -Force  >> $logfilePath



C:\cisco\cisco-core-vpn-predeploy-k9.msi /quiet  >> $logfilePath

Start-Sleep -Seconds 60  >> $logfilePath

C:\cisco\cisco-umbrella-predeploy-k9.msi /quiet  >> $logfilePath

Start-Sleep -Seconds 60  >> $logfilePath

Copy-Item -Path "#source of umbrella json file" -Destination "C:\programdata\cisco\cisco secure client\umbrella\OrgInfo.json" -Force  >> $logfilePath

echo $env:COMPUTERNAME >> $logfilePath2

}

}
catch
{
echo "CiscoUmbrella" >> $errorLogPath
echo "$env:COMPUTERNAME $today" $_ >> $errorLogPath

}



