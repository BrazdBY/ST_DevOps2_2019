#12.	Удалить созданный диск и папку С:\M2T2_ФАМИЛИЯ

#show exist drives
""
write-host -ForegroundColor Green "Show exist drives"
Get-PSDrive
[string]$folder = "M2T2_Pogulaev"
new-item -Path "C:\" -Force -ItemType directory  -Name $folder

#create new assosiated disk
New-PSDrive -Name x -PSProvider FileSystem -Root ("C:\" + $folder)  -Description "Maps to my new folder." 
cd x:\

""
write-host -ForegroundColor Green "Show exist drives"
Get-PSDrive
Remove-Item * -force
cd C:\
remove-item $folder

Remove-PSDrive -Name x 

"show exist drives"
Get-PSDrive




