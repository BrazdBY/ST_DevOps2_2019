#Узнаем, есть ли профиль 
if (!(Test-Path $profile)) 
{
    #Создаем если нет
    New-Item -ItemType file -Path $profile -force
} 

# Изменяем настройки окна
(Get-Host).UI.RawUI.ForegroundColor="Green";
(Get-Host).UI.RawUI.backgroundColor="Black";
(Get-Host).UI.RawUI.CursorSize=10;
(Get-Host).UI.RawUI.WindowTitle="WorldCount Console";

# Очищаем экран
cls

# Выводим приветствие
echo " ";
echo "Hello, My friend!";
echo " ";
echo " ";

# Устанавливаем начальный каталог
$MyRoot = "C:\temp\";
CD $MyRoot;

# Вид предложения ввода
function prompt
{
    "[BrainShtorm:] " + $(get-location) + "> "
}

#Устанавливаем алиасы
Set-Alias Pamagi Get-Help 

#Установливаем константы 
Set-Variable testConst -option Constant -value 100

cls


#Заодно смотрим установленные модули
Get-Module

<#
Параметры для применения записывам в файлы: 
Microsoft.PowerShellISE_profile.ps1
Microsoft.PowerShell_profile.ps1

Применение файлов можно увидеть в картинке

#>
