@echo off

del *.nupkg
choco pack
choco install Desktop-Tech.0.10.0.nupkg -dv -s . --force
