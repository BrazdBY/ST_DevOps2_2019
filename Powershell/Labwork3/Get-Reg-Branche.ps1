
[CmdletBinding()]
<#
    .SYNOPSIS
        Вывод содержимого ветви реестра в консоль.
    .DESCRIPTION
        Данная функция выводит одержимое одной из ветвей реестра в консоль PowerShell
    .EXAMPLE
        #Get-Reg-Branche -REG HKLM - Данная команда выведет в консоль ветвь реестра HKLM 
    
    .PARAMETER REG
        Ветвь реестра, которую необходимо вывести (обязательный параметр)
    
    #>
Param (
  [parameter(   Mandatory=$true,
                Position=1,
                ValueFromPipeline=$true,
                ParameterSetName="REG",
                HelpMessage="Enter name of REG Branche")]
  
                #[ValidateScript({($_ -eq "HKLM1") -or ($_ -eq "HKCU2") })]
                #[ValidateSet("HKLM3", "HKCU4")]
                [ValidateNotNull()]
                [string]$Reg_branche,

                [parameter(   Mandatory=$true,
                Position=1,
                ValueFromPipeline=$true,
                ParameterSetName="REG",
                HelpMessage="Enter name of REG Branche")]
                [string]$temer="true"             
  
)

#1.	Просмотреть содержимое ветви реeстра HKCU
Get-PSDrive $Reg_branche 

#Get-ChildItem . | ft - # выводим содержимое корня древа

Get-ChildItem ($Reg_branche + ":\") -Recurse -ErrorAction SilentlyContinue # выводим рекурсивно все записи древа. При ограниченной учетной записи можно воспользоваться ключом  -ErrorAction SilentlyContinue 





