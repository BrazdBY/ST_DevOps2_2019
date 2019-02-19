######################################################################################
# 2.1. Получить список коммандлетов работы с Hyper-V (Module Hyper-V)
######################################################################################

Get-Module -Name Hyper-V -ListAvailable

Get-WindowsOptionalFeature -Online -FeatureName *hyper-v* | select DisplayName, FeatureName
Get-WindowsFeature *hyper-v*
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Management-PowerShell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Tools-All
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All

Get-Command -Module hyper-v 


