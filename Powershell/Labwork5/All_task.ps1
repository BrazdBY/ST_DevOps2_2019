#############################################################################################################
#1.	При помощи WMI перезагрузить все виртуальные машины.
#############################################################################################################

#т.к. машины не в домене, то добавляем удаленные машины в список доверенных хостов управляющей машины.

Set-Item WSMan:\localhost\Client\TrustedHosts -Value "vm1-pogulaev, vm2-pogulaev, vm3-pogulaev"


#После можно отправлять комманду на перезагрузку хоста
Invoke-Command -ScriptBlock {Restart-Computer -Force} -ComputerName vm1-pogulaev -Credential
Invoke-Command -ScriptBlock {Restart-Computer -Force} -ComputerName vm2-pogulaev -Credential
Invoke-Command -ScriptBlock {Restart-Computer -Force} -ComputerName vm3-pogulaev -Credential
#############################################################################################################
#2.	При помощи WMI просмотреть список запущенных служб на удаленном компьютере. 
#############################################################################################################

#Смотрим список служб на VM1-Pogulaev
Invoke-Command -ScriptBlock {Get-Service |  Where-Object{$_.Status -eq "running"}} -ComputerName vm1-pogulaev -Credential administrator


#############################################################################################################
#3.	Настроить PowerShell Remoting, для управления всеми виртуальными машинами с хостовой.
#############################################################################################################

#Обеспечиваем работу PSRemoting на всех машинах участвующих во взаимодействии (управляющей и управляемых)
Enable-PSRemoting -Force

#Установить подключение с удаленным хостом с хостовой машиной
Enter-PSSession -ComputerName VM1-Pogulaev -Credential administrator

#Разорвать подключение
Exit-PSSession 


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



#############################################################################################################
#5.	Создать конфигурацию сессии с целью ограничения использования всех команд, кроме просмотра содержимого дисков.
#############################################################################################################

#Смотрим существующие конфигурации сессии Get-PSSessionConfiguration
Get-PSSessionConfiguration

#при необходимости создаем отдельную группу для удаленного управления на компьютере управляемом и добавляем данную группу (пользователя)
#в список объектов, которым разрешен удаленный доступ через графическую остнастку. при этом обязательно добавляемый объект должен иметь права на запуск (envoke).

Set-PSSessionConfiguration microsoft.powershell -ShowSecurityDescriptorUI



[string]$cred = Get-Credential "Administrator"
#Создаем файл конфигурации новой сессии
New-PSSessionConfigurationFile -Path "C:\temp\DiskViewSession.pssc" -VisibleCmdlets Get-ChildItem 

#протестируем конфигурацию
Test-PSSessionConfigurationFile C:\temp\DiskViewSession.pssc

#Регистрируем новую конфигурацию
Register-PSSessionConfiguration -Name DiskViewSession -Path  "C:\temp\DiskViewSession.pssc" -RunAsCredential $cred -ShowSecurityDescriptorUI

#Пробуем подклюиться под пользователем SpecUser 
$session = New-PSSession -ComputerName VM2-Pogulaev -ConfigurationName DiskViewSession -RunAsCredential VM2-Pogulaev\SpecUser
Invoke-Command -Session $Session -ScriptBlock {Get-ChildItem c:\ }

<#
PS C:\Users\Administrator> Invoke-Command -Session $Session -ScriptBlock {get-childitem c:\}

    Directory: C:\
Mode                LastWriteTime     Length Name                                  PSComputerName
----                -------------     ------ ----                                  --------------
d----          2/9/2019   1:31 PM            PerfLogs                              VM2-Pogulaev
d-r--          2/9/2019   2:05 PM            Program Files                         VM2-Pogulaev
d----          2/9/2019   2:06 PM            Program Files (x86)                   VM2-Pogulaev
d----         2/17/2019   6:50 AM            temp                                  VM2-Pogulaev
d----          2/9/2019   2:02 PM            tmp                                   VM2-Pogulaev
d-r--         1/31/2019   5:47 PM            Users                                 VM2-Pogulaev
d----         2/17/2019   7:52 AM            VM2-Pogulaev                          VM2-Pogulaev
d----          2/9/2019   2:12 PM            Windows                               VM2-Pogulaev
#>


#Пытаемся запустить другую комманду и получаем отказ
Invoke-Command -Session $Session -ScriptBlock {Get-Service }

<#
PS C:\Users\Administrator> Invoke-Command -Session $Session -ScriptBlock {get-service }
The term 'Get-Service' is not recognized as the name of a cmdlet, function, script file, or operable program. Check
the spelling of the name, or if a path was included, verify that the path is correct and try again.
    + CategoryInfo          : ObjectNotFound: (Get-Service:String) [], CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException
    + PSComputerName        : VM2-Pogulaev
#>


#Записываем результаты всех файлов в общий файл
Get-content * -Exclude *.png | Set-Content All_task.ps1
