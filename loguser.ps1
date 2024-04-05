try{
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName PresentationCore,PresentationFramework


$today=Get-Date
$time=Get-Date -Format HH:mm

$timeDifference=New-TimeSpan -Start $(gcim win32_operatingsystem).lastbootuptime -End $today

$timeDifferenceInDays=$timeDifference.days

$logfilePath="N:\ICT\scripts\log\RestartStatus\$GetYear$GetMonth\$env:COMPUTERNAME.txt"
$logfilePath2= "N:\ICT\scripts\log\Userlogons\$GetYear$GetMonth.txt"
$errorLogPath= "\\go-fs02\non-restricted$\ICT\scripts\log\errors\error.txt"



$GetYear=(get-date).year
$GetMonth=(get-date).ToString("MM")
$GetMonthL=(get-date).ToString("MMM")
$GetDayOfMonth=(get-date).day
$csvFpath="N:\ICT\scripts\log\RestartStatus\$GetYear$GetMonth.csv" 

$filePath = "N:\ICT\scripts\log\RestartStatus\$GetYear$GetMonth\"

if (-not (Test-Path $filePath)){
New-Item -Path $filePath -Force -ItemType Directory
}


else
{ Write-Host "folder exist"
}


if ($timeDifferenceInDays -gt 40){

echo "$timeDifferenceInDays days since restart. Current date and time is $today. Current user is $env:USERNAME". Initiating restart>> $logfilePath

shutdown /r /t 2

}

elseif ($timeDifferenceInDays -gt 7){
echo "$timeDifferenceInDays days since restart. Current date and time is $today. Current user is $env:USERNAME">> $logfilePath
$boxInput=[System.Windows.MessageBox]::Show("Windows has installed an update. To complete the update, please restart your computer at your convenience. Should you have any questions, please do not hesitate to contact ICT support.")
}


else{

echo "$timeDifferenceInDays days since restart. Current date and time is $today. Current user is $env:USERNAME. This devices does not require a restart." >> $logfilePath
}

echo "$env:USERNAME $env:COMPUTERNAME $today" >> $logfilePath2

$data = [PSCustomObject]@{
    Hostname = $env:COMPUTERNAME
    User=$env:USERNAME
    DaysSinceRestart=$timeDifferenceInDays
    LastLogon="$GetDayOfMonth $GetMonthL $GetYear"
    LastLogonTime=$time
}

$data | Export-Csv -Path $csvFpath -NoTypeInformation -Append

}
catch{
echo "loguser" >> $errorLogPath
echo "$env:COMPUTERNAME $today" $_ >> $errorLogPath
}