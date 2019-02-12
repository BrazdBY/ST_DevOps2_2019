#4.	Сохранить в текстовый файл на созданном диске список запущенных(!) служб 


    function Get-ProcessLocal {    
        [CmdletBinding()]
        
        <#
                .SYNOPSIS
                    Сохранить в текстовый файл на созданном диске список запущенных(!) служб
    
                .DESCRIPTION
                    Данная функция позволяет сохранить в текстовый файл на созданном диске список запущенных(!) служб
    
                .EXAMPLE
                    Get-ProcessLocal -file mycompservices.txt -path c:\tmp - Данная команда сохранит в файл c:\tmp\mycompservices.txt и выведет на экран все работающие службы. 
                
                .PARAMETER path 
                    Путь к файлу который необходимо сохранить
                
                .PARAMETER f 
                    Наименование файла, в который произведется запись информации
        
        #>
        
        Param (
          [parameter(Mandatory=$false,
           Position=1,
            ValueFromPipeline=$true,
             ParameterSetName="Setfile",
              HelpMessage="Enter name of REG Branche")]
              [Alias("f")]
              [ValidateNotNull()]
              [string]$file="services.txt",
    
          [parameter(Mandatory=$true, ValueFromPipeline=$true)]
          [Alias("path")]
          [ValidateScript({Test-Path($_)})]
          #[ValidateNotNull()]
          [string]$PathToDir=($Env:HOMEDRIVE + $env:HOMEPATH + "aaaaaaaaaaa")
        )
    
        $FullPathToFile= ($PathToDir + "\\" + $file)
        Get-Service  | where {$_.Status -like "Running" } | Out-File  -FilePath $FullPathToFile
    
        #Просмотреть содержимое диска. Вывести содержимое файла в консоль PS.
    
        Get-ChildItem -Path $PathToDir
        $a = Get-Content $FullPathToFile
            foreach ($i in $a)
            {$i}
    
    }
    

Export-ModuleMember -Function Get-ProcessLocal