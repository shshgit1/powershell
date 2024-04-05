try{
$getDateTime=Get-Date
$GetYear=(get-date).year
$GetMonth=(get-date).ToString("MM")
$today=Get-Date


$filePath =  #path to store your files
$logfilePath=  #location of log files
$logfilePath2=  #location of 2nd log files
$errorLogPath=  #location of error logs
$printerExportSource=  #location of printer installation file


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
