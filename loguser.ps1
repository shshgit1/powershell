$GetDateTime=Get-Date
$GetYear=(get-date).year
$GetMonth=(get-date).ToString("MM")
echo "$env:USERNAME $env:COMPUTERNAME $GetDateTime" >> N:\ICT\scripts\log\$GetYear$GetMonth.txt
