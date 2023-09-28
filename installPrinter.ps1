$getDateTime=Get-Date

echo "start checking if printer exists in $env:COMPUTERNAME at $getDateTime" >> \\go-fs02\non-restricted$\ICT\scripts\RunAtStartup\logs\$env:COMPUTERNAME.txt

Set-ExecutionPolicy Unrestricted -Force -Confirm:$false >> "\\go-fs02\non-restricted$\ICT\scripts\RunAtStartup\logs\$env:COMPUTERNAME.txt"

$checkPrinter=Get-WmiObject -Query "select * from win32_printer where name= 'GO-PS03' "



if ($checkPrinter -eq $null){

echo "printer does not exist in $env:COMPUTERNAME at $getDateTime" >> \\go-fs02\non-restricted$\ICT\scripts\RunAtStartup\logs\PrinterInstallLog.txt

Copy-Item -Path "\\10.50.1.16\non-restricted$\ICT\scripts\RunAtStartup\printerinstall.printerExport" -Destination "C:\Windows\System32\printerinstall.printerExport" -Force >> "\\go-fs02\non-restricted$\ICT\scripts\RunAtStartup\logs\$env:COMPUTERNAME.txt"

echo "begin installation of printer on $env:COMPUTERNAME at $getDateTime" >> "\\go-fs02\non-restricted$\ICT\scripts\RunAtStartup\logs\$env:COMPUTERNAME.txt"


C:\Windows\System32\spool\tools\PrintBrm.exe -r -f C:\Windows\System32\printerinstall.printerExport -o force >> "\\go-fs02\non-restricted$\ICT\scripts\RunAtStartup\logs\$env:COMPUTERNAME.txt"

}
else{

echo "printer exists in $env:COMPUTERNAME at $getDateTime" >> \\go-fs02\non-restricted$\ICT\scripts\RunAtStartup\logs\PrinterInstallLog.txt

}

