@echo off
REM Function to delete registry values
:deleteRegistry
reg delete %1 /v %2 /f > nul 2>nul
exit /b

REM Function to kill processes
:killProcesses
taskkill /im %1 /f 2>nul
exit /b

REM Function to remove directories
:removeDirectories
rd /s /q %1 2>nul
exit /b

REM Function to remove malware files and directories
:removeMalware
call :deleteRegistry
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run
winddowsupdatecheck.exe
call :deleteRegistry
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run
winddowsupdater.exe
call :killProcesses AutoIt3.exe
call :killProcesses winddowsupdatecheck.exe
call :killProcesses winddowsupdater.exe
call :killProcesses streamer.exe
call :killProcesses wscript.exe
call :removeDirectories c:\winddowsupdater
call :removeDirectories c:\winddowsupdatecheck
call :removeDirectories c:\streamerdata
call :removeDirectories c:\streamer
exit /b

REM Main script
:begin
cd/
:main
echo.
echo.
echo.

REM Input drive letter
set /p drive=Enter the drive letter:
if not exist %drive%:\ (
    echo Drive doesn't exist, please plug one in!
    goto main
)

echo Starting...
cd /d %drive%:
echo Unhiding all files...
attrib -h -s -r -a /s /d %drive%:*.*

echo Press enter to delete all links on this drive
pause

echo Removing all links...
rmdir /s /q "%drive%:\system volume information" 2>nul
del /s /q "%drive%:\*.lnk" 2>nul

REM Delete malware files and directories
call :removeMalware

echo Virus successfully removed!
pause
goto begin
