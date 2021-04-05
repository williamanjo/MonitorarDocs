### Definir Pasta para monitorar + Filtro de Arquivos + Subpastas true\false
    $watcher = New-Object System.IO.FileSystemWatcher
    $watcher.Path = "C:\Users\$env:UserName\Desktop\TamDAT"
    $watcher.Filter = "*.DAT"
    $watcher.IncludeSubdirectories = $false
    $watcher.EnableRaisingEvents = $true  

### Definir o que fazer depois que ocorrer um evento.
    $action = { $path = $Event.SourceEventArgs.FullPath
                $changeType = $Event.SourceEventArgs.ChangeType
				
				$nameDocNew = "$((Get-Date).tostring("dd-MM-yyyy hh.mm.ss")).txt"
                $dest = "C:\Users\$env:UserName\Documents\teste\$nameDocNew"
                
                ###C:\PS>split-path "C:\Users\$env:UserName\Documents\teste\log.txt" -leaf -resolve
                $logline = "$((Get-Date).tostring("dd-MM-yyyy")), $changeType, $path , $nameDocNew"
				Add-content "C:\Users\$env:UserName\Documents\teste\log.txt" -value $logline
				Copy-Item -Path $path -Destination $dest
              }    
### Define Quais Eventos Monitorar

    Register-ObjectEvent $watcher "Created" -Action $action
#   Register-ObjectEvent $watcher "Changed" -Action $action
#   Register-ObjectEvent $watcher "Deleted" -Action $action
#   Register-ObjectEvent $watcher "Renamed" -Action $action
    while ($true) {sleep 5}
	
