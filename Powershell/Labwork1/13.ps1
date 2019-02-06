#Получить список обновлений системы

Get-HotFix


""
"Еще один способ"
$update = Get-WmiObject -Class win32_quickfixengineering
$update 


""
"И еще один способ для 2012 сервера"
Get-SilWindowsUpdate

