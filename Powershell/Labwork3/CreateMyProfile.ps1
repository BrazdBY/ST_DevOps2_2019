#Узнаем, есть ли профиль 
if (!(Test-Path $profile)) 
{
    #Создаем если нет
    New-Item -ItemType file -Path $profile -force
} 

(Get-Host).UI.RawUI.ForegroundColor = 'green'
(Get-Host).UI.RawUI.BackgroundColor = 'black'

#Устанавливаем диск (директорию) по-умолчанию
Set-Location C:\

Set-Alias Pamagi Get-Help 
Get-Alias | ForEach-Object {if ($_.Name -eq "Pamagi") {write-host $_.Name -ForegroundColor Red $_.CommandType} else {write-host $_.Name -ForegroundColor green $_.CommandType }} | Format-Table -AutoSize
Get-Module 

