$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://mirror.desktoptech.io/Setup.exe' 

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'Desktop.Tech'

  checksum      = '7BD92537DA15CA09C0CAFB60699621160648F99E88EAD78F592E42188E1181EF'
  checksumType  = 'sha256' 

  silentArgs    = "--silent" 
  validExitCodes= @(0, 3010, 1641) 
}

Install-ChocolateyPackage @packageArgs