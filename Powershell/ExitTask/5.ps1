 
 
function Extract-fromZip-Rename {
  param (
    [parameter(Mandatory=$false)]$MyDirectory = "h:\tmp\Powershell",
    [parameter(Mandatory=$false)]$ArchiveFileName = "h:\tmp\archive.zip",
    [parameter(Mandatory=$false)]$ExtractPath = "h:\tmp\extract",
    [parameter(Mandatory=$false)]$WorkFolder = "h:\tmp\work"
  
  )
  
  Add-Type -assembly "system.io.compression.filesystem"
  try {
    
    if ( (Test-Path $ArchiveFileName) ){
      Remove-Item $ArchiveFileName -Force
    }  
    
      [IO.Compression.ZipFile]::CreateFromDirectory($MyDirectory, $ArchiveFileName)
        
  }
  catch {
      return Write-Host -ForegroundColor Red "Создание Архива. Ошибка: Не найдена директория или невозможна запись на диск."
  }


  
  try {
    [IO.Compression.ZipFile]::ExtractToDirectory($ArchiveFileName, $ExtractPath) 
  }
  catch {
    
    return Write-Host -ForegroundColor Red "Разорхивация архива. Ошибка: Не найдена директория, файл или невозможна запись на диск"
    
  }


  $MyFiles = Get-ChildItem -Path $ExtractPath -Recurse -force -File | Select-Object -Property FullName,  Name
  
  
  Foreach ($MyFile in $MyFiles) {
  
    #Копируем в рабочую папку 
    Copy-Item $MyFile.FullName -Destination $WorkFolder
    
    #Формируем полное имя файла с которорым работаем в рабочей директории
    [string]$OldName = $WorkFolder + "\\" + $MyFile.Name
    Write-Output "Старое имя $($oldName)"
    
    #Формируем новое имя для файла
    [string]$ParentDir=((Get-item $MyFile.FullName).Directory).Name
    write-output "Корневая директория $($ParentDir)"
    [string]$NewName =  ((Get-Date).Hour).ToString() + "_" + ((Get-Date).Minute).ToString() + "_" + ((Get-Date).Second).ToString() + "_" + ((Get-Date).Millisecond).ToString() + "_"  + $ParentDir.ToString() + "_" + ($MyFile.Name).ToString()
    Write-Output "Новое имя $($NewName)" 
    
    Rename-Item -Path $OldName -NewName $NewName -Force
    
      
  }

  #Считаем файлы и размер

  $Files = Get-ChildItem -Path $WorkFolder -Recurse -force -File | Select-Object -Property FullName,  Name

  [int]$count=0

  foreach ($file in $files) {
      $count +=1
  }

  $MainFolderFullSize = Get-ChildItem $WorkFolder -Recurse -ErrorAction SilentlyContinue -force  | Measure-Object -Property length -Sum 
  write-output ("total size = " + $MainFolderFullSize.Sum/1mb + " Mb")
  Write-Output ("total count file = " + $count)


  #get-help Rename-Item -full
}

Extract-fromZip-Rename