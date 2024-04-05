Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName PresentationCore,PresentationFramework

$today=Get-Date

$timeDifference=New-TimeSpan -Start $(gcim win32_operatingsystem).lastbootuptime -End $today

$timeDifferenceInDays=$timeDifference.days

if ($timeDifferenceInDays -gt 6){
echo "$timeDifferenceInDays days since restart. Current date and time is $today. Current user is $env:USERNAME">> #log file location
# $boxInput=[System.Windows.MessageBox]::Show("Windows has installed an update. To complete the update, please restart your computer. Should you have any questions, please do not hesitate to contact ICT support.")
}
else{
echo "$timeDifferenceInDays days since restart. Current date and time is $today. Current user is $env:USERNAME. This devices does not require a restart.">> #log file location
}
