<#
####################################################################################################################################
#1.4	Подсчитать размер занимаемый файлами в папке (например C:\windows) за исключением файлов с заданным расширением(напрмер .tmp)
#####################################################################################################################################
#>

[CmdletBinding()]
    <#
    .SYNOPSIS
        Вывести содержимое файла в консоль.

    .DESCRIPTION
        Данная функция выводит текстовый файл в консоль

    .EXAMPLE
        #Get-GetOfFiles -Path C:\temp  Данная команда выведет в консоль размер содержимого папки   C:\temp

    .PARAMETER Path
         Путь к файлу (не обязательный параметр)

    .PARAMETER FileName
        Имя файла для вывода (обязательный параметр)
    
    #>
    
    param (
        [PARAMETER(Mandatory=$false, Position=0)][ValidateScript({Test-Path $_ })][String]$Path='C:\Windows'
    )
    
   

$MainFolderFullSize = Get-ChildItem $Path -Recurse -Exclude "*.tmp" -ErrorAction SilentlyContinue - -force  | Measure-Object -Property length -Sum 
$MainFolder + "total size = " + $MainFolderFullSize.Sum

