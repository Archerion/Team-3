C:\UDK\UDK-2012-07\Binaries\Win32\UDK.com make
IF errorlevel 1 GOTO :ERROR_EXIT
C:\UDK\UDK-2012-07\Binaries\Win32\UDK.exe MagicalTestMap.udk?game=MagicalFPSGame.MagicalGameInfo -log
GOTO :GOOD_EXIT
:ERROR_EXIT
pause
exit /b %ERRORLEVEL%
:GOOD_EXIT