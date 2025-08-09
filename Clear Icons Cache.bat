@echo off
rem [ SETTINGS ]==========================================================
set AppName=Clear Icons Cache
::set AppAuthor=Kristian Tsenov
::set AppVersion=v2025.04.06
::set AppWeb=ktsenov.com
rem ======================================================================

rem [ REGISTER ]==========================================================
title %AppName%
rem ======================================================================

rem [ MAIN ]==============================================================
:: Clear icons cache
ie4uinit.exe -ClearIconCache

:: Force kill File Explorer
taskkill /f /im explorer.exe

:: Delete icon cache database
del /A /Q "%localappdata%\IconCache.db"
del /A /Q /F "%localappdata%\Microsoft\Windows\Explorer\iconcache*"

:: Start File Explorer
start explorer.exe
start .

:: Show notification for clearing icon cache
timeout 3
call :fn_popup "Clear Icons Cache.exe" "Icon cache was cleared successfuly!" "Info"

:: Force exit
exit
rem ======================================================================

rem [ FUNCTIONS ]==========================================================
:: *** Function PopUP v1.0 - Show notification popup ***
:: Usage: call :fn_popup "Title" "Message" "Icon" "Time to show in seconds (Default: 0-Unlimited[OK button needs to be pressed])"
:: Icon Types: None, Error, Question, Warning, Info
:fn_popup
if "%~1" == "" (set PopupTitle="Default Title") else (set PopupTitle=%1)
if "%~2" == "" (set PopupMessage="Default Message") else (set PopupMessage=%2)
if "%~3" == "" (set PopupIcon=0)
if "%~3" == "None" (set PopupIcon=0)
if "%~3" == "Error" (set PopupIcon=10)
if "%~3" == "Question" (set PopupIcon=20)
if "%~3" == "Warning" (set PopupIcon=30)
if "%~3" == "Info" (set PopupIcon=40)
if "%~4" == "" (set PopupTime=0) else (set PopupTime=%4)
powershell -Command "(New-Object -ComObject Wscript.Shell).Popup('%PopupMessage%', %PopupTime%, '%PopupTitle%', 0x%PopupIcon%)"
exit /B
rem ======================================================================