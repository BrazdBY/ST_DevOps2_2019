#Узнайте, какой язык установлен для UI Windows


$languege = Get-Variable -Name PSCulture
$languege 

""
"Альтернативный вариант"

$languege = Get-CimInstance -ClassName CIM_OperatingSystem

$languege.MUILanguages