################################################################################
#2.6.	Создать динамический жесткий диск
################################################################################


$vhdpath = "D:\VM\VHDs\Test.vhdx"
$vhdsize = 127GB
New-VHD -Path $vhdpath -Dynamic -SizeBytes $vhdsize | Mount-VHD -Passthru |Initialize-Disk -Passthru |New-Partition -AssignDriveLetter -UseMaximumSize |Format-Volume -FileSystem NTFS -Confirm:$false -Force