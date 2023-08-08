$CurrPolicy=Get-ExecutionPolicy
Write-Host Original policy is $CurrPolicy 
Set-ExecutionPolicy Unrestricted -Force -Confirm:$false

Write-Host "Beginning update."
   
Write-Host policy is $CurrPolicy 
 
Install-PackageProvider -Name NuGet -Force -Confirm:$false
Install-Module -Name PSWindowsUpdate -Force -Confirm:$false
Get-WindowsUpdate;

Install-WindowsUpdate -acceptall

Write-Host "Update complete."


Set-ExecutionPolicy $CurrPolicy -Force
Write-host updatedpolicy is $CurrPolicy
