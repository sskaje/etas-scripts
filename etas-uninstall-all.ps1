echo "# ETAS product uninstaller by sskaje"
echo ""
echo "This script uninstall all ETAS products by msiexec, use at your own risk"
echo ""

while (1 -eq 1) {
    echo "> Scanning installed ETAS products"
    $Packages = Get-WmiObject -Class win32_product |Where-Object {$_.Vendor -eq 'ETAS GmbH'} 

    echo "> Found products" $Packages.Count ""

    if ($Packages.Count -gt 0) {
        echo "> Trying to uninstall"
        foreach ($package in $Packages) {
            $package | Select-Object IdentifyingNumber,Name

            msiexec.exe /x $package.IdentifyingNumber /qn 
            Start-Sleep -Seconds 1
        }

        echo "> Waiting for the next loop"

        Start-Sleep -Seconds 10
    } else {
        break
    }

}

echo "[!] All packages uninstalled"

