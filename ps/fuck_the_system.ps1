$wsh = New-Object -ComObject WScript.Shell
$wsh.SendKeys('{NUMLOCK}')

for(;;) {
    try {
        $wsh = New-Object -ComObject WScript.Shell
        $wsh.SendKeys('{NUMLOCK}')
    }
    catch {

    }
    #every seconds
    Start-Sleep 300
}
