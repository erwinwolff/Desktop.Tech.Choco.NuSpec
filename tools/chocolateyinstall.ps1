$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://desktoptech.azureedge.net/Setup.exe' 
$url64      = 'https://desktoptech.azureedge.net/Setup.exe' 

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64

  softwareName  = 'Desktop.Tech'

  checksum      = ''
  checksumType  = 'sha256' 
  checksum64    = ''
  checksumType64= 'sha256'

  silentArgs    = "--silent" 
  validExitCodes= @(0, 3010, 1641) 
}

Install-ChocolateyPackage @packageArgs