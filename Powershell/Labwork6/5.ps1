####################################################################################################
#1.5.	Удалить шару из п.1.4
####################################################################################################

Write-Output ("We have those shares:")
Get-WMIObject Win32_Share


$Shares = Get-WMIObject Win32_Share | Where {$_.Name -eq "mynewshare"}

Foreach ($Share in $Shares) {
   $Share.Delete()
}
Write-Output ""
Write-Output ("Share found and removed. And now we have:") 

 Get-WMIObject Win32_Share