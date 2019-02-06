#Получите текущее время и дату


$date = Get-date 
$date.DateTime
$date.ToShortDateString() + " " + $date.ToShortTimeString()