try{
$getDateTime=Get-Date
$GetYear=(get-date).year
$GetMonth=(get-date).ToString("MM")
$today=Get-Date


$filePath = "\\go-fs02\non-restricted$\ICT\scripts\log\PrinterInstallLogs\$GetYear$GetMonth\"
$logfilePath= "\\go-fs02\non-restricted$\ICT\scripts\log\PrinterInstallLogs\$GetYear$GetMonth\$env:COMPUTERNAME.txt"
$logfilePath2= "\\go-fs02\non-restricted$\ICT\scripts\log\PrinterInstallLogs\PrinterInstallLog.txt"
$errorLogPath= "\\go-fs02\non-restricted$\ICT\scripts\log\errors\error.txt"
$printerExportSource= "\\10.50.1.16\non-restricted$\ICT\scripts\log\printerinstall.printerExport"


if (-not (Test-Path $filePath)){
New-Item -Path $filePath -Force -ItemType Directory
}
else
{ Write-Host "folder exist"
}

Write-Host "check if exist"
echo "start checking if printer exists in $env:COMPUTERNAME at $getDateTime" >> $logfilePath

$checkPrinter=Get-WmiObject -Query "select * from win32_printer where name= 'GO-PS03' "



if ($checkPrinter -eq $null){

echo "printer does not exist in $env:COMPUTERNAME at $getDateTime" >> $logfilePath2

Copy-Item -Path $printerExportSource -Destination "C:\Windows\System32\printerinstall.printerExport" -Force >> $logfilePath

echo "begin installation of printer on $env:COMPUTERNAME at $getDateTime" >> $logfilePath


C:\Windows\System32\spool\tools\PrintBrm.exe -r -f C:\Windows\System32\printerinstall.printerExport -o force >> $logfilePath

}
else{

echo "printer exists in $env:COMPUTERNAME at $getDateTime" >> $logfilePath2

}

}
catch{

echo "installprinter" >> $errorLogPath
echo "$env:COMPUTERNAME $today" $_ >> $errorLogPath


}