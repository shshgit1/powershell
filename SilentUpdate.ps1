Set-ExecutionPolicy Unrestricted -Force -Confirm:$false >> \\go-fs02\non-restricted$\ICT\scripts\updaterestart\logs\$env:COMPUTERNAME.txt

$getDateTime=Get-Date
echo "Start update for $env:COMPUTERNAME at $getDateTime" >> \\go-fs02\non-restricted$\ICT\scripts\updaterestart\logs\$env:COMPUTERNAME.txt

Install-PackageProvider -Name NuGet -Force -Confirm:$false >> \\go-fs02\non-restricted$\ICT\scripts\updaterestart\logs\$env:COMPUTERNAME.txt
Install-Module -Name PSWindowsUpdate -Force -Confirm:$false >> \\go-fs02\non-restricted$\ICT\scripts\updaterestart\logs\$env:COMPUTERNAME.txt
Get-WindowsUpdate >> \\go-fs02\non-restricted$\ICT\scripts\updaterestart\logs\$env:COMPUTERNAME.txt

Install-WindowsUpdate -acceptall >> \\go-fs02\non-restricted$\ICT\scripts\updaterestart\logs\$env:COMPUTERNAME.txt

echo "Updated $env:COMPUTERNAME at $getDateTime" >> \\go-fs02\non-restricted$\ICT\scripts\updaterestart\logs\$env:COMPUTERNAME.txt

echo "setting automatic time" >> \\go-fs02\non-restricted$\ICT\scripts\updaterestart\logs\$env:COMPUTERNAME.txt
w32tm /config /manualpeerlist:"time.windows.com" /syncfromflags:manual /reliable:YES /update >> \\go-fs02\non-restricted$\ICT\scripts\updaterestart\logs\$env:COMPUTERNAME.txt