
function runUpdate {
    $CurrPolicy=Get-ExecutionPolicy
Write-Host policy is $CurrPolicy 
Set-ExecutionPolicy Unrestricted -Force -Confirm:$false

 
Install-PackageProvider -Name NuGet -Force -Confirm:$false
Install-Module -Name PSWindowsUpdate -Force -Confirm:$false
Get-WindowsUpdate

Install-WindowsUpdate -acceptall
Write-Host "Update complete. Windows will restart."


Set-ExecutionPolicy $CurrPolicy -Force
Write-host updatedpolicy is $CurrPolicy

shutdown /r /f
}

function begin{
Write-Host "Windows has some updates. Windows will restart after the update."
Write-Host "Answer Y or N. If answer is N, update will start in 20 minutes."

$answer= Read-Host -Prompt "Y/N"


if ($answer -like "y"){
runUpdate
    }
elseif ($answer -like "n"){
Write-Host "Answer is no. Update will start in 20 minutes"
Start-Sleep -Seconds 12
runUpdate
    }
else {
Write-Host "Invalid answer."
begin
    }
}


begin
