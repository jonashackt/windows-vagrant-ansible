# Allow Network Access to Box
Set-NetConnectionProfile -Name "Network" -NetworkCategory Private
winrm quickconfig -q 