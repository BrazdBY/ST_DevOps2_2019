#Получить список команд работы с объектами
Get-Command -Name *object* | WHERE {$_.Name -cnotlike "*.exe" } 