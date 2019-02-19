#######################################################################
#2.5.	Создать новую виртуальную машину
#######################################################################


$VMName = "VM4-Pogulev"

$VM = @{
  Name = $VMName 
  MemoryStartupBytes = 2147483648
  Generation = 1
  NewVHDPath = "D:\VM\$VMName\$VMName.vhdx"
  NewVHDSizeBytes = 53687091200
  BootDevice = "VHD"
  Path = "D:\VM\$VMName"
  SwitchName = (Get-VMSwitch).Name
}

New-VM @VM