#Вывести список всех пространств имен классов WMI

Get-WMIObject -namespace "root" -class "__Namespace" | Select Name