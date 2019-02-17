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