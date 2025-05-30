@echo off
setlocal

REM Navigate to root project directory
set SCRIPT_DIR=%~dp0
cd /d %SCRIPT_DIR%
cd ..\..\..
set "APP_DIR=%CD%"

REM Delete Task Scheduler job if it exists
echo Removing Task Scheduler job if present...
schtasks /query /tn "DiscordLocalAIBot" >nul 2>&1
if %errorlevel%==0 (
    schtasks /delete /tn "DiscordLocalAIBot" /f
)

REM Delete virtual environment
echo Deleting virtual environment...
rmdir /s /q "%APP_DIR%\.venv"

REM Delete .env file
echo Deleting .env...
del /f /q "%APP_DIR%\lib\homie\.env"

REM Delete bot logs
echo Deleting log files...
del /f /q "%APP_DIR%\logs\*"

REM Delete database
echo Deleting database...
del /f /q "%APP_DIR%\db\preferences.db"

echo ✅ Uninstall complete.

endlocal