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

Export-ModuleMember -Function Get-ProcessLocal
Export-ModuleMember -Function Get-ContentFile
