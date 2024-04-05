$today=Get-Date

$getDateTime=Get-Date

$GetYear=(get-date).year
$GetMonth=(get-date).ToString("MM")

$filePath = "\\go-fs02\non-restricted$\ICT\scripts\log\UpdateLogs\$GetYear$GetMonth\"
$logfilePath="\\go-fs02\non-restricted$\ICT\scripts\log\UpdateLogs\$GetYear$GetMonth\$env:COMPUTERNAME.txt"
$errorLogPath= "\\go-fs02\non-restricted$\ICT\scripts\log\errors\error.txt"



if (-not (Test-Path $filePath)){
New-Item -Path $filePath -Force -ItemType Directory
}
else
{ Write-Host "folder exist"
}

echo "Start update for $env:COMPUTERNAME at $getDateTime" >> $logfilePath

try{


Install-PackageProvider -Name NuGet -Force -Confirm:$false >> $logfilePath
Install-Module -Name PSWindowsUpdate -Force -Confirm:$false >> $logfilePath
Get-WindowsUpdate >> $logfilePath

Install-WindowsUpdate -acceptall >> $logfilePath

echo "Updated $env:COMPUTERNAME at $getDateTime" >> $logfilePath
}

catch {
echo "silentupdate" >> $errorLogPath
echo "$env:COMPUTERNAME $today" $_ >> $errorLogPath 
}