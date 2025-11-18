# This script will give the list of installed softwares on the computer
# and ask user to ask which application he wants to get details
# about installed date.

# To clear screen and get all installed software and ask user for the date
Clear-Host
$Keys = Get-ChildItem HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall
$D= "(YYYYMMDD)"
# Input Date which user want to get the installed software data.
Write-Host "Enter the date $D to check the software installed" -f red -b black
$inputData= Read-Host 

# Sort softwares according to the alphabatical order of display name.
$Items = $keys |foreach-object {Get-ItemProperty $_.PsPath} |
Select-Object DisplayName, InstallDate |
Sort-Object DisplayName

#Check for softwares installed on user input date

# Save the filtered software list into a variable called result
# Check for software data where there is a install date and filter it is same with the user input data.

$result= $Items | Where-Object {$_.InstallDate -and $_.InstallDate -eq $inputdata }
  if(-not $result){                                               #If no software installed on user input data.
        Write-Host " No software installed on $inputData" 
        Write-Host " Do you want to see full software list? Y/N"  # If no software found it will ask user to want full software list.
        $listanswer =Read-Host
        if($listanswer -ieq 'Y'){
            $Items | Format-Table -AutoSize			  # If answer is yes, Display All software list.	
            }
        elseif($listanswer -ieq 'N'){
            break }						  # If No, exit 
   
        else{
             Write-Host " Wrong Input" -f DarkRed -b Gray}}	  # If input wrong data, Shows wrong data.
        
  else{                                                	 	  # if it found a software installed on the user input date.
        Write-Host "Do you want to save this result in a .txt File? Y/N" -f red -b black
        $answer = Read-Host					  # Get User input for write it to text file.

# Create a directory Result and check if its exist. if exist- save the file, if not create a directory and save

        $folderPath ="C:\Result"                   
        if (!(Test-Path -Path $folderPath)) {			  # Check for folder path given exist or not
            New-Item -Path $folderPath -ItemType Directory | Out-Null }		# If the directory doesn't exist- Create a new directory
        if($answer -ieq 'Y'){
            $result | Format-Table -AutoSize > C:\Result\Result_$inputData.txt	# Save filtered data into Text file with name as user input date
            Write-Host "Printing to C:\Result\" -f green -b black
            notepad c:\Result\Result_$inputData.txt				# Open notepad with saved txt file.
            }
        elseif($answer -ieq 'N'){						# If user doesn't want to save it on file, it will show in terminal.
             $result | Format-Table -AutoSize}
   
        else{
             Write-Host " Wrong Input" -f DarkRed -b Gray}			# If input wrong data, Shows wrong data.

    }
    


