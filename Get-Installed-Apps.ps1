$theway = Read-Host -Prompt "Where would you like this saved?"
get-package | Select-Object Name,version | Format-Table –AutoSize | out-file $theway\$env:COMPUTERNAME.txt
$ErrorActionPreference = "Stop"