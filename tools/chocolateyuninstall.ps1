$ErrorActionPreference = 'Stop'; 
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'Desktop.Tech'  
  fileType      = 'EXE'
  silentArgs    = ""
  validExitCodes= @(0, 3010, 1605, 1614, 1641)
}

$uninstalled = $false
[array]$key = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']

if ($key.Count -eq 1) {
  $key | % { 
    $packageArgs['file'] = "$($_.UninstallString)"
    if ($packageArgs['fileType'] -eq 'MSI') {
      $packageArgs['silentArgs'] = "$($_.PSChildName) $($packageArgs['silentArgs'])"
      $packageArgs['file'] = ''
    }

	"Beginning uninstall"	
	try 
	{
		$InstallerPath="$Env:USERPROFILE\AppData\Local\Desktop"
		if(Test-Path $InstallerPath)
		{
			Remove-Item -Recurse -Force $InstallerPath
		}

		$InstallerPath="$Env:USERPROFILE\AppData\Roaming\DesktopOrganizer"
		if(Test-Path $InstallerPath)
		{
			Remove-Item -Recurse -Force $InstallerPath
		}
	}
	catch
	{
		"Could not delete directories for unknown reason"
	}
	"Ending uninstall"
	
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | % {Write-Warning "- $($_.DisplayName)"}
}
