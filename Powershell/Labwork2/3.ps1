#3.	Создать папку C:\M2T2_ФАМИЛИЯ. Создать диск ассоциированный с папкой C:\M2T2_ФАМИЛИЯ.


[string]$folder = "M2T2_Pogulaev"
new-item -Path "C:\" -Force -ItemType directory  -Name $folder

#create new assosiated disk
New-PSDrive -Name x -PSProvider FileSystem -Root ("C:\" + $folder)  -Description "Maps to my new folder." 

#show new disk
Get-PSDrive 







