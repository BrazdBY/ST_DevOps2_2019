#############################################################################################################
#4.	Для одной из виртуальных машин установить для прослушивания порт 42658. Проверить работоспособность PS Remoting
#############################################################################################################
[string]$host = "VM1-Pogulaev"
[string]$cred = "Administrator"

#Проверяем на каком порту работает протокол на удаленной машине:
Invoke-Command -ScriptBlock {Get-Item WSMan:\localhost\listener\listener*\port } -ComputerName $host -Credential $cred

#Производим замену порта для протокола на удаленной машине (VM1-Pogulaev).
Invoke-Command -ScriptBlock {Set-Item WSMan:\localhost\listener\listener*\port -Value 42658} -ComputerName $host1 -Credential $cred

#Производим подключение к VM1-Pogulaev на новый порт
Invoke-Command -ScriptBlock {Get-Item WSMan:\localhost\listener\listener*\port } -ComputerName $host -Port 42658 -Credential $cred 

#Визуальное подтверждение в картинке приложенной к материалам домашней работы task4_screen.png



