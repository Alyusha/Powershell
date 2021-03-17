
#Gets Path of Script
$path = split-path -parent $MyInvocation.MyCommand.Definition

#Formats Date for Logs
$date = Get-Date -Format yyyyMMdd_HHmm

#Opens the Desired List from a Text file located in the same folder as this script
$list = get-content $path\PC_Names.txt

#Blank Array. @() is the Array.
$failures=@("These Devices were not found or had errors.")

#################################################################################################################

#Start of "Loop" to process every item in this Txt file. These are not Objects.
    ForEach ($device in $list) 
      
#Bracket1 is needed here
{
$Injection = get-service -computername "$device" | Where-Object {$_.Status -EQ "Running"} | out-file $path\$date"_Status Report"_$device.txt
#Start of If Statements. -eq, -like, +=
        If ($device -like {"int*"}) 
    {
#Performs the Sub above.
   $injection     
    }
      
    If ($device -notlike "int*") 
    {  
    
    #This is how I built the String that gets displayed after the error.
    $failures+=$device

    remove-item $path\$date"_Status Report"_$device.txt
    
    write-host $failures
    }
    #Debug text
    #write-host $Device

#Bracket1 ends here
}   



$failures | out-file $path\$date"_Status Report"_Failed_Retrivals.txt

#################################################################################################################

#get-service -ComputerName int-WS2| Where-Object {$_.Status -EQ "Running"} | out-file $path\$date"_Status Report"_$env:COMPUTERNAME.txt

