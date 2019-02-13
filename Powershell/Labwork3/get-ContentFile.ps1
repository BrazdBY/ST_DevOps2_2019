#4.	Вывести содержимое файла в консоль PS 

Function Get-ContentFile {
    
    [CmdletBinding()]
    <#
    .SYNOPSIS
        Вывести содержимое файла в консоль .
    .DESCRIPTION
        Данная функция выводит текстовый файл в консоль
    .EXAMPLE
        #Get-ContentFile -Path C:\temp -fileName servises.txt  Данная команда выведет в консоль содержимое файла  C:\temp\services.txt  
    
    .PARAMETER Path
         Путь к файлу (не обязательный параметр)

    .PARAMETER FileName
        Имя файла для вывода (обязательный параметр)
    
    #>
    
    param (
        [PARAMETER(Mandatory=$false, Position=0)][ValidateScript({Test-Path $_ })][String]$Path=($env:HOMEDRIVE + $env:HOMEPATH),
        [PARAMETER(Mandatory=$true,Position=1)][ValidateNotNullOrEmpty()][String]$FileName="services.txt"
        
        )
        
   

    if  ($Path -isnot $null) 
    {
        $File = ($Path + "\\" + $FileName)
        
    } else {
        $File = $FileName
    }

#Вывести содержимое файла в консоль PS.

$a = Get-Content -Path $File
	foreach ($i in $a)
	{$i}
}

Get-ProcessLocal 