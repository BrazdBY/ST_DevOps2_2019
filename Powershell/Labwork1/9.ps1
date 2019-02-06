#Просмотреть список методов и свойств объекта типа процесс
Get-Process | Get-Member | where {$_.MemberType -eq "Method" -or ( $_.MemberType -eq "Property")}

