#2.	Создать, переименовать, удалить каталог на локальном диске

$Path_to_folder = "c:\temp\newfolder"
new-item -Path $Path_to_folder -Force -ItemType directory  

#rename folder Nefolder to MaxFolder
Rename-Item -Path $Path_to_folder -NewName MaxFolder -Force

#Delete directory from disk
Remove-Item -Path c:\temp\MaxFolder





