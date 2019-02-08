#8.	Подсчитать размер занимаемый файлами в папке C:\windows (и во всех подпапках) за исключением файлов *.tmp


$MainFolder = "C:\Windows" 
$MainFolderFullSize = Get-ChildItem $MainFolder -Recurse -Exclude "*.tmp" -ErrorAction SilentlyContinue | Measure-Object -Property length -Sum 
$MainFolder + "total size = " + $MainFolderFullSize.Sum

