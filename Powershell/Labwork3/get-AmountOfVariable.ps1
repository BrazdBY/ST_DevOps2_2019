#5.	Просуммировать все числовые значения переменных текущего сеанса.

[CmdletBinding(DefaultParameterSetName="All")] #использовать набор по-умолчанию. Если несуществующий, то будет работать без параметров даже если есть обязательные в других наборах.

<#

.SYNOPSIS
    Просуммировать все числовые значения переменных текущего сеанса.

.DESCRIPTION
    Данная функция позволяет посчитать сумму всех числовых переменных текущего сеанса.

.EXAMPLE
    #Get-GetListOfFiles   Данная команда выведет  сумму числовых переменных. 

#>

param (

)

[int]$SummValue = 0
Get-Variable | where {$_.Value -ne $null} | ForEach-Object { if ( (($_.value).GetType().FullName -eq "System.Int32") -or (($_.value).GetType().FullName -eq "System.Int64")) {$SummValue = $SummValue + $_.value}}

"Сумма всех числовых переменных равна: " + $SummValue
