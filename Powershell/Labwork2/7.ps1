#7.	Вывести список названий и занятую виртуальную память (в Mb) каждого процесса, разделённые знаком тире, 
#при этом если процесс занимает более 100Mb – выводить информацию красным цветом, иначе зелёным.
Get-Process | ForEach-Object {if ($_.VM -gt "104857600") {write-host -ForegroundColor Red $_.ProcessName " - " $_.VM} else {write-host -ForegroundColor Green $_.ProcessName " - " $_.VM}} 