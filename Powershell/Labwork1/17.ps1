#17.	Выведите дату и время, когда был запущен процесс «explorer». Получите какой это день недели. 

$explorerStartTime = (get-process -ProcessName 'explorer').StartTime #Получаем объект с процессами и вызаваем метод показывающий время старта
"Дата запуска процесса с именем explorer - " + $explorerStartTime

"Это был - " + $explorerStartTime.dayOfWeek #Выводим день недели