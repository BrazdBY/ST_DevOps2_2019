#18.	Откройте любой документ в MS Word (не важно как) и закройте его с помощью PowerShell
$WordApp = New-Object -ComObject Word.Application #Запускаем приложение
$WordApp.Visible = $true #делаем видимым приложение (по-умолчанию работает в фоне)
$DocWord = $WordApp.Documents.Add() #создаем новый документ сохраняем в отдельном объекте для простоты доступа

$SelectWordApp = $WordApp.Selection #Делаем активным приложение
$SelectWordApp.TypeText("Hello, Powershell") #Вносим в него текст

$File = "C:\Temp\wordfile_tmp.doc" #Определяем файл для сохранения
$DocWord.SaveAs([ref]$File) #производим сохранение

$DocWord.Close(); #Закрываем документ
Remove-Item "$File" #Удаляем файл
$WordApp.Quit(); #Закрываем приложение

