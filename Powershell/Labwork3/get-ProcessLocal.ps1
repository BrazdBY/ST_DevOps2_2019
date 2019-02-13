#4.	Сохранить в текстовый файл на созданном диске список запущенных(!) служб 

Function Get-ProcessLocal {
    
    [CmdletBinding()]
    <#
    .SYNOPSIS
        Сохранить в текстовый файл на диске список запущенных(!) служб.
    .DESCRIPTION
        Данная функция cохраняет в текстовый файл список запущенных(!) служб
    .EXAMPLE
        #Get-ProcessLocal -Path C:\temp -fileName servises.txt  Данная команда сохранит в файле  C:\temp\services.txt  список запущенных(!) служб.
    
    .PARAMETER Path
        Путь к файлу, в который необходимо произвести сохранение. 
    .PARAMETER FileName
        Имя файла для сохранения (обязательный параметр)
    
    #>
    
    param (
        [PARAMETER(Mandatory=$true, Position=0)][ValidateScript({Test-Path $_ })][String]$Path=($env:HOMEDRIVE + $env:HOMEPATH),
        [PARAMETER(Mandatory=$true,Position=1)][String]$FileName="services.txt"
        
        )
        
   

$File = $Path + "\\" + $FileName

try {
    Get-Service  | where {$_.Status -like "Running" } | Out-File  -FilePath $File    
}
catch {
    "it doesn't work. Try again!"
}



}

Get-ProcessLocal 