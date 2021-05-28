$theway = Read-Host -Prompt "Where are these files located? They must be in the same Folder, and this file will output to that folder."
$PC1 = Read-Host -Prompt "What is the name of file 1? Default name will be the Hostname of the PC"
$PC2 = Read-Host -Prompt "What is the name of file 2? Default name will be the Hostname of the PC"
Compare-Object -ReferenceObject (Get-Content $theway\$PC1.txt) -DifferenceObject (Get-Content $theway\$PC2.txt) |out-file $theway\$PC1"___"$PC2" Difference Report".txt
