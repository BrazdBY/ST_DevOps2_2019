#Просмотреть содержимое диска.  


    
    [CmdletBinding()]
        <#
        .SYNOPSIS
            Просмотреть содержимое диска.
        .DESCRIPTION
            Данная функция позволяет просмотреть содержимое диска и вывести в консоль
        .EXAMPLE
            #Get-GetListOfFiles -Disk C  Данная команда выведет  содержимое диска C:\ 
        
        .PARAMETER Disk
            Символьное обозначение диска. 
        .PARAMETER Recurse
            Наличие параметра обеспечивает отображение не только содержимое корневой папки, но и всего диска рекурсивно. (не обязательный параметр)
        
        #>
    
    param (
        [PARAMETER(Mandatory=$false, Position=0)][ValidateNotNullOrEmpty()][String]$Disk,
        [PARAMETER(Mandatory=$false,Position=1)][switch]$Recurse
        
        )
        
    
    try {
        if ($recursive){
            Get-ChildItem -Path  ($Disk + ":\") -Recurse
        }
        else {
            Get-ChildItem -Path  ($Disk + ":\")
        }
        
    }
    
    catch {
        "it doesn't work. Try again!"
    }





#Get-ListOfFiles