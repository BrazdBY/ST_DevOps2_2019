#4.	Сохранить в текстовый файл на созданном диске список запущенных(!) служб 

Function Get-ProcessLocal {
    
    [CmdletBinding()]
    <#
    .SYNOPSIS
        Сохранить в текстовый файл на созданном диске список запущенных(!) служб .
    .DESCRIPTION
        Данная функция выводит Сохраняет в текстовый файл на созданном диске список запущенных(!) служб
    .EXAMPLE
        #Get-ProcessLocal -Path C:\temp -fileName servises.txt  Данная команда сохранит в файле  C:\temp\services.txt  список запущенных(!) служб.
    
    .PARAMETER Path
        Строка, которую необходимо вывести (обязательный параметр)
    .PARAMETER FileName
        Имя файла для сохранения (обязательный параметр)
    
    #>
    
    param (
        [PARAMETER(Mandatory=$false, Position=0)][ValidateScript({Test-Path $_ })][String]$Path=($env:HOMEDRIVE + $env:HOMEPATH),
        [PARAMETER(Mandatory=$false,Position=1)][String]$FileName="services.txt"
        
        )
        
   

$File = $Path + "\\" + $FileName
Get-Service  | where {$_.Status -like "Running" } | Out-File  -FilePath $File


}

Get-ProcessLocal 