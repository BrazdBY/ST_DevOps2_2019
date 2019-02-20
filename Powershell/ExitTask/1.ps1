#######################################################################################################################
#1.	Вывести список событий-ошибок из системного лога, за последнюю неделю. Результат представить в виде файла XML.
#######################################################################################################################


$date = (Get-Date).AddDays(-7)
$date
try {
    Get-EventLog -Newest 100 -LogName System -entrytype Error -After $date | Export-Clixml -Path "c:\temp\systems_log.xml" -Force
    Write-Host "Data save to file" -ForegroundColor "Green" 
}
catch {
   Write-Host "Can't save to file" -ForegroundColor "Red" 
}







