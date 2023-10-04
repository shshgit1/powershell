Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName PresentationCore,PresentationFramework

$today=Get-Date

$timeDifference=New-TimeSpan -Start $(gcim win32_operatingsystem).lastbootuptime -End $today

$timeDifferenceInDays=$timeDifference.days

if ($timeDifferenceInDays -gt 7){
echo "$timeDifferenceInDays days since restart. Current date and time is $today. Current user is $env:USERNAME">> N:\ICT\scripts\updaterestart\DevicesRequiringRestart\$env:COMPUTERNAME.txt
$boxInput=[System.Windows.MessageBox]::Show("Windows has installed an update. To complete the update, please restart your computer at your convenience. Should you have any questions, please do not hesitate to contact ICT support.")
}
else{

echo "$timeDifferenceInDays days since restart. Current date and time is $today. Current user is $env:USERNAME. This devices does not require a restart." >> N:\ICT\scripts\updaterestart\DevicesRequiringRestart\$env:COMPUTERNAME.txt
}


$GetYear=(get-date).year
$GetMonth=(get-date).ToString("MM")
echo "$env:USERNAME $env:COMPUTERNAME $today" >> N:\ICT\scripts\log\$GetYear$GetMonth.txt
