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

<#
###################################################################################################################
#>
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

<#
######################################################################################################################
#>
Function Get-ListOfFiles {
 
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


}


<#
######################################1.2####################################################################################
#>

Function Get-GetListOfFiles {

#1.2.	Просуммировать все числовые значения переменных среды Windows. (Параметры не нужны)

[CmdletBinding(DefaultParameterSetName="All")] #использовать набор по-умолчанию. Если несуществующий, то будет работать без параметров даже если есть обязательные в других наборах.

<#
.SYNOPSIS
    Просуммировать все числовые значения переменных текущего сеанса.
.DESCRIPTION
    Данная функция позволяет посчитать сумму всех числовых переменных текущего сеанса.
.EXAMPLE
    #Get-GetListOfFiles   Данная команда выведет  сумму числовых переменных. 

#>

param (

)

[int]$SummValue = 0
Get-Variable | where {$_.Value -ne $null} | ForEach-Object { if ( (($_.value).GetType().FullName -eq "System.Int32") -or (($_.value).GetType().FullName -eq "System.Int64")) {$SummValue = $SummValue + $_.value}}

"Сумма всех числовых переменных равна: " + $SummValue
}

<#
############################################### 1.3 ######################################################################################################
#>

function Get-Top10ProcBusy {

    #1.3.	Вывести список из 10 процессов занимающих дольше всего процессор. Результат записывать в файл

    [CmdletBinding()]
    <#
    .SYNOPSIS
        Вывести список из 10 процессов занимающих дольше всего процессор. Результат записывать в файл.

    .DESCRIPTION
        Данная функция позволяет вывести список из 10 процессов занимающих дольше всего процессор. Результат записывать в указанный файл. Разместить данный функционал как задачу.

    .EXAMPLE
        #Get-Top10ProcBusy -FileName servises.txt -Path C:\temp   Данная команда сохранит в файле  C:\temp\services.txt  список запущенных(!) служб.

    .EXAMPLE
        #Get-Top10ProcBusy.ps1  -CredUser 'cotonto\alex' -Path 'h:\SVN\ST_DevOps2_2019\Powershell\Labwork3' -FileName 'Get-Top10ProcBusy.ps1'
        Данная команда регистрирует задачу и на сбор данных через каждые 10 минут. Запись данных пишется в файл по умолчанию с:\temp\services2.txt

    .PARAMETER Path
        Путь к файлу, в который необходимо произвести сохранение. (Обязательный для создания таска).

    .PARAMETER FileName
        Имя файла для сохранения данных или наименование скрипта (обязательный параметр при создании таска)

    .PARAMETER CredUser
        Имя пользователя в формате domain\username

    .PARAMETER NameTask
        Наименование задачи для публикации

    #>

    param (
        
            [PARAMETER(Mandatory=$false,Position=0,ParameterSetName='ProcBusy')]
            [PARAMETER(Mandatory=$true, Position=0, ParameterSetName='MakeTask')]
            [String]$FileName,

            [PARAMETER(Mandatory=$false, Position=1, ParameterSetName='ProcBusy')]
            [PARAMETER(Mandatory=$true, Position=1, ParameterSetName='MakeTask')]
            [ValidateScript({Test-Path $_ })][String]$Path,

            [PARAMETER(Mandatory=$true, Position=2,ParameterSetName='MakeTask')]
            [String]$CredUser=".\administrator",

            [PARAMETER(Mandatory=$true, Position=3,ParameterSetName='MakeTask')]
            [String]$NameTask="Test_task_pogulaev"
            
            
        )

        #проверяем параметры
        

        if ($PSCmdlet.ParameterSetName -eq "MakeTask") 
        {
            if ((( $Path ) -and (Test-Path $Path)) -or (!$file))
            {
                $File = $Path + "\" + $FileName               
            }
            else {
                "somethign wrong" 
                
            }

            $t = New-JobTrigger -Daily -At 4:30PM -DaysInterval 10
            $cred = Get-Credential $CredUser
            $o = New-ScheduledJobOption -RunElevated
            Register-ScheduledJob -Name $NameTask -FilePath $file -Trigger $t -Credential $cred -ScheduledJobOption $o
        }
        
        if ($PSCmdlet.ParameterSetName -eq "ProcBusy")
        {
            if ((( $Path ) -and (Test-Path $Path)) -and ($file))
            {
                $File = $Path + "\" + $FileName               
            }
            else {
                
                $path = 'C:\temp'
                $FileName = "services2.txt" 
                $File = $path + '\' +  $FileName
            }
        
            
            try {
                
                Get-Process  | Sort-object -Property cpu -Descending  | Select-Object -first 6 | Format-Table  -Property ProcessName, TotalProcessorTime | Out-File -FilePath $File    
            }
            catch {

                "something's not quite right."
            }
        }

}

Export-ModuleMember -Function Get-ProcessLocal
Export-ModuleMember -Function Get-ContentFile
Export-ModuleMember -Function Get-ListOfFiles
Export-ModuleMember -Function Get-GetListOfFiles
Export-ModuleMember -Function Get-Top10ProcBusy