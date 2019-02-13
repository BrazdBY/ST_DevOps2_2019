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
    Данная команда регистрирует задачу на сбор данных через каждые 10 минут. Запись данных пишеться в файл по умолчанию с:\temp\services2.txt

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
