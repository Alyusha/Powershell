#Get File Path and Device list.
$File_Path = Split-Path -Parent $MyInvocation.MyCommand.Definition

$List_Of_Systems = Get-Content -Path ($File_Path + '\System_Names.txt')

#Create Status_Reports Folder.
new-item -path 'Status_Reports' -itemtype directory -force

#Points the script to the Status_Reports Folder.
$file_path = $File_path + '\Status_Reports'

#Builds Static Strings.
$Short_Date = (Get-Date).ToString("yyyyMMdd_HHmm")

$Failed_to_Connect_list_path = $File_Path + '\' + $Short_Date + '_Failed_Connections_StatusReport.txt'

#Parses the System List in a "Loop".
ForEach ($System in $List_Of_Systems) 
	{
    #Creates file name for each System in the System list.
	$System_Services_File_Path = $File_Path + '\' + $Short_Date + '_' + $System + '_StatusReport.txt'
    
    #Finds all running Services on each System in the System List. Prints that information into Status_Reports Folder.
	Try
		{
		Get-Service -ComputerName "$System" | Where-Object {$_.Status -EQ "Running"} | Out-File $System_Services_File_Path
        [Array]$Successful_Connections += $System
		}
    #Prints out any Systems that did had errors or were unable to complete the above.
	Catch
		{
		Write-Host "Failed to connect to: " -NoNewLine;Write-Host $System -ForeGroundColor Red
        remove-item $System_Services_File_Path
		[Array]$Failed_To_Connect_List += $System
		}
	}
#Publishes the "Failed_Connections_StatusReport". This is a list of any Systems that for whatever reason were not completed.
Out-File -FilePath $Failed_to_Connect_list_path -InputObject $Failed_To_Connect_List

#PowerShell ISE Debugging lines. PowerShell ISE does not clear Variables or Errors when a script has been completed. Caused headaches.
Remove-Variable * -ErrorAction SilentlyContinue
$error.Clear()
