#9.	Сохранить в CSV-файле информацию о записях одной ветви реестра HKLM:\SOFTWARE\Microsoft.

Get-PSDrive HKLM 
cd HKLM:\SOFTWARE\Microsoft
Get-ChildItem .  | Select-Object -property Name | Export-Csv -path C:\M2T2_Pogulaev\test.csv - # выводим содержимое корня древа

