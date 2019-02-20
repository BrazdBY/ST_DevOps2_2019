#################################################################################################################
#2.	Вывести список файлов *.log хранящихся в папке C:\Windows. Вывод организовать в виде таблицы 
#с обратной сортировкой по имени файла, при этом выводить полное имя файла, размер файла, время создания. 
#################################################################################################################


[string]$Path = "c:\windows"

Get-ChildItem  $Path -Recurse -Include "*.log" -ErrorAction SilentlyContinue -force | Sort-Object -Property FullName -Descending  | Format-Table -Property FullName, Length, CreationTime