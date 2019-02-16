# 8.	Создать файл-сценарий вывода списка установленных программных продуктов в виде таблицы с полями Имя и Версия.

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

