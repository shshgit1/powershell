$CurrPolicy=Get-ExecutionPolicy
Write-Host Original policy is $CurrPolicy 
Set-ExecutionPolicy Unrestricted -Force -Confirm:$false

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName PresentationCore,PresentationFramework
 
function beginUpdate{
Write-Host "Beginning update."
   
Write-Host policy is $CurrPolicy 
 
Install-PackageProvider -Name NuGet -Force -Confirm:$false
Install-Module -Name PSWindowsUpdate -Force -Confirm:$false
Get-WindowsUpdate;

Install-WindowsUpdate -acceptall

Write-Host "Update complete. Windows will restart."
$boxInput=[System.Windows.MessageBox]::Show("Update complete. Windows will restart.")

Set-ExecutionPolicy $CurrPolicy -Force
Write-host updatedpolicy is $CurrPolicy

shutdown /r /f
}

$boxInput=[System.Windows.MessageBox]::Show("Windows has an update. Click yes to run the update. Your computer WILL RESTART once the update is complete. 
Remember to save your work before running this update. Click no to snooze for 10 minutes.","Update required","YesNo","question")


switch($boxInput){
"Yes"{
beginUpdate
    }
"No"{
Write-Host "Snoozing for 10 min"
$boxInput=[System.Windows.MessageBox]::Show("Snoozing for 10 minutes.")
Start-Sleep -seconds 600
$boxInput=[System.Windows.MessageBox]::Show("Update will begin now.")
beginUpdate
    }
}


