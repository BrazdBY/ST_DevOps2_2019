#1.	Просмотреть содержимое ветви реeстра HKCU
Get-PSDrive HKCU 
cd hkCU:\

# выводим содержимое корня древа

Get-ChildItem . -Recurse -ErrorAction SilentlyContinue | Select-Object -Property Name # выводим рекурсивно все записи древа. При ограниченной учетной записи можно воспользоваться ключом  -ErrorAction SilentlyContinue 




