#######################################################################################################
#Вывести список всех классов 
#######################################################################################################
Get-WmiObject -List


#######################################################################################################
#Вывести список всех пространств имен классов WMI
#######################################################################################################
Get-WMIObject -namespace "root" -class "__Namespace" | Select Name

#######################################################################################################
#Вывести список классов работы с принтером 
#######################################################################################################
Get-WmiObject -List *print*

#######################################################################################################
#Вывести информацию об операционной системе
#######################################################################################################
#About operation system
#Get-WmiObject -List *OperatingSystem*
#Get-WmiObject -class Win32_OperatingSystem | format-list -property *

Get-WmiObject -class Win32_OperatingSystem | Select-Object Caption, BuildNumber, MUILanguages, PSComputerName, Status, `
             FreeSpaceInPagingFiles, FreeVirtualMemory, CSName, NumberOfUsers, OSArchitecture



#######################################################################################################
#Вывести информацию о биосе 
#######################################################################################################
Get-WmiObject -Class Win32_Bios 




#######################################################################################################
# 6.	Вывести свободное место на локальных дисках. На каждом и сумму.
#######################################################################################################
#Get-WmiObject Win32_LogicalDisk -ComputerName . | Select-Object -Property FreeSpace 

[int]$SummFreeSpaces=0

$FreeSpaces = Get-WmiObject win32_logicaldisk | Select-Object -Property Name, FreeSpace 
foreach ($Space in $FreeSpaces) {
    
    Write-Output ("На диске " + ($Space.Name) + " свободно - " + ($Space.FreeSpace/1Gb) + " Gb")
    $SummFreeSpaces += $Space.FreeSpace/1Gb
} 

Write-Output ("Всего свободного места: " + $SummFreeSpaces + " Gb")

#######################################################################################################
# 7.	Написать сценарий, выводящий суммарное время пингования компьютера (например 10.0.0.1) в сети.
#######################################################################################################
Function Get-PingTimeResponse { 
        
    [CmdletBinding()]

    <#
    .SYNOPSIS
        Посчитать сумарное время к удаленному компьютеру (Ping на Powershell).

    .DESCRIPTION
        Данная функция позволяет вывести время пингования  IP адреса в консоль.

    .EXAMPLE
        #Get-PingTimeResponse -IpAddress 8.8.8.8 -CountTry 4 Данная команда выведет  результат 4 попыток  пингования хоста 8.8.8.8 

    .PARAMETER IpAddress
        Адрес компьютера в сети (IPv4). 

    .PARAMETER CountTry
        Количество попыток. (не обязательный параметр)

    #>

    param (
            [PARAMETER(Mandatory=$true, Position=0)]
            [ValidateNotNullOrEmpty()]
            [ValidateScript({$_ -match [IPAddress]$_ })]
            [String]$IpAddress="8.8.8.8",
            
            [PARAMETER(Mandatory=$false,Position=1)]
            [ValidateNotNullOrEmpty()]
            [ValidatePattern ("[0-9]")]
            [int]$CountTry=4
    )

    [int]$SumResponseTime = 0
    Write-Output ""
    Write-Output ("Обмен пакетами с " + $IpAddress + " Количество попыток - " + $CountTry + ":" )
    
    for ($i=1; $i -le $CountTry;$i++){
        $Ping = Get-WmiObject -Class Win32_PingStatus -Filter ("Address= '" + $IpAddress + "'") -ComputerName . | Select-Object -Property Address,ResponseTime,StatusCode,ResponseTimeToLive
    
        if ($ping.StatusCode -eq "0"){
            $SumResponseTime += $ping.ResponseTime;
            Write-Output ("Ответ от  $($IpAddress) Время запроса= $($Ping.ResponseTime)ms TTL=$($Ping.ResponseTimeToLive)")
            
        }
    }
    
    Write-Output ("Общее время затраченное на процесс пингования -  $($SumResponseTime)")

    

}
Get-PingTimeResponse

#######################################################################################################
# 8.	Создать файл-сценарий вывода списка установленных программных продуктов в виде таблицы с полями Имя и Версия.
#######################################################################################################
Function Get-ProgrammInstalled { 
        
    [CmdletBinding()]

    <#
    .SYNOPSIS
    Вывести список установленных программных продуктов в виде таблицы с полями Имя и Версия.

    .DESCRIPTION
        Данная функция позволяет вывести список установленных программных продуктов в виде таблицы с полями Имя и Версия.

    .EXAMPLE
        #Get-ProgrammInstalled  Данная команда выведет  установленные на локальном компьютере программные продукты. 
    
    #>

    param (
            
    )

    Get-WmiObject -class win32_product | Select-Object Name, Version

}

Get-ProgrammInstalled

#######################################################################################################
#9.	Выводить сообщение при каждом запуске приложения MS Word.
#######################################################################################################

[string]$AppProcName="WINWORD.exe"
[string]$StrQuery="select * from __instancecreationevent within 5 where targetinstance isa 'Win32_Process' AND targetinstance.name='$($AppProcName)'"
$StrQuery
Register-wmievent -Query "$($StrQuery)" -sourceIdentifier "ProcessStarted" -Action { Write-Output "I am watching you!" }
