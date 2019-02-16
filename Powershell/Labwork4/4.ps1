#Вывести информацию об операционной системе

#About operation system
#Get-WmiObject -List *OperatingSystem*

#Get-WmiObject -class Win32_OperatingSystem | format-list -property *

Get-WmiObject -class Win32_OperatingSystem | Select-Object Caption, BuildNumber, MUILanguages, PSComputerName, Status, `
             FreeSpaceInPagingFiles, FreeVirtualMemory, CSName, NumberOfUsers, OSArchitecture




