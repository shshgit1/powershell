try{

$getDateTime=Get-Date
$today=Get-Date

$logfilePath="\\go-fs02\non-restricted$\ICT\scripts\log\CiscoUmbrellaLogs\$env:COMPUTERNAME.txt"
$logfilePath2="\\go-fs02\non-restricted$\ICT\scripts\log\CiscoUmbrellaLogs\installed\installed.txt"
$errorLogPath= "\\go-fs02\non-restricted$\ICT\scripts\log\errors\error.txt"


$exist= Test-Path -Path "C:\ProgramData\Cisco\Cisco Secure Client\Umbrella\Orginfo.json"
if($exist){
echo "secure client installed. time now is $getDateTime" >> \\go-fs02\non-restricted$\ICT\scripts\log\CiscoUmbrellaLogs\$env:COMPUTERNAME.txt
}
else{
echo "secure client not installed. time now is $getDateTime" >> \\go-fs02\non-restricted$\ICT\scripts\log\CiscoUmbrellaLogs\$env:COMPUTERNAME.txt
New-Item -Path C:\cisco -Force -ItemType Directory

Copy-Item -Path "\\10.50.1.16\non-restricted$\ICT\scripts\log\CiscoUmbrella\cisco-secure-client-win-5.1.2.42-core-vpn-predeploy-k9.msi" -Destination "C:\cisco\cisco-core-vpn-predeploy-k9.msi" -Force  >> $logfilePath
Copy-Item -Path "\\10.50.1.16\non-restricted$\ICT\scripts\log\CiscoUmbrella\cisco-secure-client-win-5.1.2.42-umbrella-predeploy-k9.msi" -Destination "C:\cisco\cisco-umbrella-predeploy-k9.msi" -Force  >> $logfilePath



C:\cisco\cisco-core-vpn-predeploy-k9.msi /quiet  >> $logfilePath

Start-Sleep -Seconds 60  >> $logfilePath

C:\cisco\cisco-umbrella-predeploy-k9.msi /quiet  >> $logfilePath

Start-Sleep -Seconds 60  >> $logfilePath

Copy-Item -Path "\\10.50.1.16\non-restricted$\ICT\scripts\log\CiscoUmbrella\OrgInfo.json" -Destination "C:\programdata\cisco\cisco secure client\umbrella\OrgInfo.json" -Force  >> $logfilePath

echo $env:COMPUTERNAME >> $logfilePath2

}

}
catch
{
echo "CiscoUmbrella" >> $errorLogPath
echo "$env:COMPUTERNAME $today" $_ >> $errorLogPath

}



