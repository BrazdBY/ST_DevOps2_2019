#5.	Просуммировать все числовые значения переменных текущего сеанса.

[int]$SummValue = 0
Get-Variable | where {$_.Value -ne $null} | ForEach-Object { if ( ($_.value).GetType().FullName -like "System.Int32") {$SummValue = $SummValue + $_.value}}
$SummValue



	









