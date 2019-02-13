[CmdletBinding()]
Param (
  [parameter(Mandatory=$false, HelpMessage="Enter name of REG Branche")]
  [string]$Reg_branche = "HKCU"

  
)
#1.	Просмотреть содержимое ветви реeстра HKCU
Get-PSDrive $Reg_branche 

Get-ChildItem $Reg_branche + "." | ft - # выводим содержимое корня древа

Get-ChildItem . -Recurse -ErrorAction SilentlyContinue | Select-Object -Property Name # выводим рекурсивно все записи древа. При ограниченной учетной записи можно воспользоваться ключом  -ErrorAction SilentlyContinue 




