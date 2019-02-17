#############################################################################################################
#1.	При помощи WMI перезагрузить все виртуальные машины.
#############################################################################################################

#т.к. машины не в домене, то добавляем удаленные машины в список доверенных хостов управляющей машины.

Set-Item WSMan:\localhost\Client\TrustedHosts -Value "vm1-pogulaev, vm2-pogulaev, vm3-pogulaev"


#После можно отправлять комманду на перезагрузку хоста
Invoke-Command -ScriptBlock {Restart-Computer -Force} -ComputerName vm1-pogulaev -Credential
Invoke-Command -ScriptBlock {Restart-Computer -Force} -ComputerName vm2-pogulaev -Credential
Invoke-Command -ScriptBlock {Restart-Computer -Force} -ComputerName vm3-pogulaev -Credential