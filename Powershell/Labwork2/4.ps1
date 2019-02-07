#4.	Сохранить в текстовый файл на созданном диске список запущенных(!) служб 


[string]$folder = "X:"
Get-Service  | where {$_.Status -like "Running" } | Out-File  -FilePath "x:\services.txt"

#Просмотреть содержимое диска. Вывести содержимое файла в консоль PS.

Get-PSDrive -Name x | Get-ChildItem .







