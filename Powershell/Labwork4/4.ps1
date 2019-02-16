#Вывести информацию о биосе 
Get-WmiObject -Class Win32_Bios | Format-List -Property

#Вывести информацию о наше об операционной системе

#About operation system
Get-WmiObject -List *OperatingSystem*

Get-WmiObject -class Win32_OperatingSystem | format-list -property *




