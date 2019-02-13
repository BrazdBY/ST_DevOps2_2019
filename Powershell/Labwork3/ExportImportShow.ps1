<#
######################################################################################################################
1.5.	Создать один скрипт, объединив 3 задачи:
1.5.1.	Сохранить в CSV-файле информацию обо всех обновлениях безопасности ОС.
1.5.2.	Сохранить в XML-файле информацию о записях одной ветви реестра HKLM:\SOFTWARE\Microsoft.
1.5.3.	Загрузить данные из полученного в п.1.5.1 или п.1.5.2 файла и вывести в виде списка  разным разными цветами
######################################################################################################################
#>

[string]$RefBranche = "HKLM:\SOFTWARE\Microsoft"
[string]$FileCsv = "C:\temp\test.csv"
[string]$FileXml = "C:\temp\secUpdate.xml"

# Сохранить в XML-файле информацию о записях одной ветви реестра HKLM:\SOFTWARE\Microsoft.
Get-ChildItem  -Path $RefBranche | Select-Object -property Name | Export-Clixml -path $FileXML  

#Сохранить в CSV-файле информацию обо всех обновлениях безопасности ОС.
Get-Hotfix -Description "Security Update"| Export-Csv -Path $FileCsv

#Загрузить данные из полученного в п.1.5.1 или п.1.5.2 файла и вывести в виде списка  разным разными цветами
Import-Clixml -Path $FileXML | ForEach-Object {Write-Host $_.Name -ForegroundColor "Red"}

Import-Csv -Path $FileCsv  | ForEach-Object {Write-Host $_ -ForegroundColor "green"} 
