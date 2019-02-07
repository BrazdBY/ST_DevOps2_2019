#1.	Просмотреть содержимое ветви реeстра HKCU
Get-PSDrive HKCU 
cd hkCU:\
Get-ChildItem . # выводим содержимое корня древа

Get-ChildItem . -Recurse -ErrorAction SilentlyContinue # выводим рекурсивно все записи древа. При ограниченной учетной записи можно воспользоваться ключом  -ErrorAction SilentlyContinue 




