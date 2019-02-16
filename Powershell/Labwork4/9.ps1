#9.	Выводить сообщение при каждом запуске приложения MS Word.

[string]$AppProcName="WINWORD.exe"
[string]$StrQuery="select * from __instancecreationevent within 5 where targetinstance isa 'Win32_Process' AND targetinstance.name='$($AppProcName)'"
$StrQuery
Register-wmievent -Query "$($StrQuery)" -sourceIdentifier "ProcessStarted" -Action { Write-Output "I am watching you!" }