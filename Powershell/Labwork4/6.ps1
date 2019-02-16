# 6.	������� ��������� ����� �� ��������� ������. �� ������ � �����.

#Get-WmiObject Win32_LogicalDisk -ComputerName . | Select-Object -Property FreeSpace 

[int]$SummFreeSpaces=0

$FreeSpaces = Get-WmiObject win32_logicaldisk | Select-Object -Property Name, FreeSpace 
foreach ($Space in $FreeSpaces) {
    
    Write-Output ("�� ����� " + ($Space.Name) + " �������� - " + ($Space.FreeSpace/1Gb) + " Gb")
    $SummFreeSpaces += $Space.FreeSpace/1Gb
} 

Write-Output ("����� ���������� �����: " + $SummFreeSpaces + " Gb")