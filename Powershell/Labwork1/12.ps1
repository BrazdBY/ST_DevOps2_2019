﻿#12.	Получить список всех сервисов, данные об определённом сервисе
$service = Get-Service 
$service

# данные об определённом процессе
""
"Берем  процесс первый из списка работающих на компьютере"

Get-Process -Id $proces[0].Id

