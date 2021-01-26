@echo off
:begin
cd/

:one
rem remove virus regedit values
reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run /v winddowsupdatecheck.exe /f > nul 2>nul
reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run /v winddowsupdater.exe /f > nul 2>nul
echo Deleted registry values...

rem kill running programs
taskkill /im AutoIt3.exe /f 2>nul
taskkill /im winddowsupdatecheck.exe /f 2>nul
taskkill /im winddowsupdater.exe /f 2>nul
taskkill /im streamer.exe /f 2>nul
taskkill /im wscript.exe /f 2>nul
echo Killed all programs...

rem remove virus directories on windows
rd c:\winddowsupdater /s /q 2>nul
rd c:\winddowsupdatecheck /s /q 2>nul
rd c:\streamerdata /s /q  2>nul
rd c:\streamer /s /q 2>nul
echo Virus directories deleted...
if errorlevel 0 echo Virus deleted from PC!



:main
echo.
echo.
echo.
rem input infected drive letter
set /p drive=which drive? - do not press c!
if "%drive%"=="c" goto cerror
if exist %drive%:\ ( echo Starting... ) else ( goto error)
cd %drive%:
echo Unhiding all files... 
attrib -h -s -r -a /s /d %drive%:*.*


echo Press enter to delete all links on this drive
pause

rem remove all .lnk files
echo Removing all links...
rmdir "%drive%:\system volume information" /s /q
del  %drive%:\*.lnk /s 



rem remove virus directories in infected drive
rmdir "%drive%:\winddowsupdater" /s /q 
rmdir "%drive%:\winddowsupdatecheck" /s /q 
rmdir "%drive%:\streamerdata" /s /q 
rmdir "%drive%:\streamer" /s /q 
del %drive%:\manuel.doc 


rem del streamer.exe
del  %drive%:\streamer.exe /s
rem FOR /d /r . %%d IN (streamerdata) DO @IF EXIST "%%d" rd /s /q "%%d"
echo Virus succesfully removed!
pause
goto begin

:error
echo Drive doesn't exist, please plug one in!
goto main

:cerror
echo cannot be run on c drive!
goto main 
