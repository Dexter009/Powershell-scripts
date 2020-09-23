$services = get-wmiobject -query 'select * from win32_service'
foreach ($service in $services) {
    $path=$service.Pathname
    $path
    if (-not( test-path $path -ea silentlycontinue)) {
        if ($Service.Pathname -match "(\""([^\""]+)\"")|((^[^\s]+)\s)|(^[^\s]+$)") {
            $path = $matches[0] –replace """",""
        }
    }
    $ServiceName = $service.Displayname
    $rights = get-acl $path
    Write "$ServiceName : Writable service"
    foreach ($item in $rights.access){    
        if ($item.FileSystemRights.tostring() -match "Modify|Full|Change") {
            Write ("   "+$item.IdentityReference.value + " : "+$item.AccessControlType.tostring() + " : "+$item.FileSystemRights.tostring())
        }        
    }
    Write "`r`n"
    
    }
