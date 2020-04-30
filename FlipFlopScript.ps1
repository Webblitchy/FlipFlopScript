# The flipflop script

#Requires -RunAsAdministrator

function getMiceIDs {
    $ids = @()
    $mice = Get-CimInstance win32_PointingDevice | Where Description -match 'hid'
    foreach ($mouse in $mice) {
        $ids += $mouse.PNPDeviceID
    }
    return $ids
}

function getNewMouse ($oldMice) {
    $currentMice = getMiceIDs
    $newMice = @()
    foreach ($currentMouse in $currentMice){
        if (!($oldMice.Contains($currentMouse))){
            $newMice += $currentMouse
        }
    }

    if ($newMice.Length -eq 0) {
        Write-Host "There is no new mouse connected"
        return "error"
    }
    elseif ($newMice.Length -gt 1) {
        Write-Host "There is more than one new mouse connected at a time"
        return "error"
    }
    else {
        return $newMice[0].split("\")[1] # to get only mouse from "hid\MOUSE\PORT"
    }
}


# Choose direction
do {
    $direction = Read-Host -Prompt "`nSelect scroll direction : `n[0] Windows default: You scroll down, you go down`n[1] Natural Scroll: like a touch-screen `n0 or 1 "
} while ($direction -ne 0 -and $direction -ne 1)

# Get all mice:
Read-Host -Prompt "`nDisconnect the mouse you want to modify `n-> Press ENTER when it is done"
$before = getMiceIDs


# Create all the entries in the registery
Read-Host -Prompt "Plug and unplug the new mouse in all the USB ports you will use for this mouse
(else the scroll direction won't be changed for all ports) `n-> Press ENTER when it is done"


# Get only the new mouse connected
Read-Host -Prompt "Now connect the mouse on any port and keep it plugged`n-> Press ENTER when it is done"

$newMouse = getNewMouse ($before)

if ($newMouse -eq "error") {
    "Error : exiting program`n"
    return
}


# Change scroll for all usb ports :
$allPorts = (ls "HKLM:\SYSTEM\CurrentControlSet\Enum\HID\$newMouse").PSPath

foreach ($port in $allPorts) {
    Set-ItemProperty -Path "$port\Device Parameters" -Name FlipFlopWheel -Value $direction # 0 = default, 1 = natural/Mac
}

Write-Host "`nDone ! Please unplug and replug the mouse to see changes`n"

