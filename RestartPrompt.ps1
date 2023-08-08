Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName PresentationCore,PresentationFramework

Function RestartFunction{
shutdown /r /f /t 5
}

Function PromptBox{
$boxInput=[System.Windows.MessageBox]::Show("Windows has just updated and needs to restart to complete the update. Remember to save your work if you have not done so. Click Yes to restart now or No to delay the restart for 10 minutes.","Restart?","YesNo","question")
OnClickRun
}

function OnClickRun{

switch($boxInput){
"Yes"{
Write-Host "input is yes"
RestartFunction
     }
"No"{
Write-Host "input is no"
Start-Sleep -Seconds 600
PromptBox
    }
	}
           }

PromptBox