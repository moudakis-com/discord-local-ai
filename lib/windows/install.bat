@echo off
setlocal enabledelayedexpansion

REM Get current script directory
set SCRIPT_DIR=%~dp0
cd /d %SCRIPT_DIR%
cd ..\..\..
set "APP_DIR=%CD%"

REM Check for Python
where python >nul 2>&1
if errorlevel 1 (
    echo Python is not installed. Please install Python 3.x and add it to your PATH.
    exit /b 1
)

REM Create virtual environment
echo Creating virtual environment...
python -m venv "%APP_DIR%\.venv"

REM Activate virtual environment
call "%APP_DIR%\.venv\Scripts\activate.bat"

REM Install requirements
echo Installing Python requirements...
pip install -r "%APP_DIR%\lib\homie\requirements.txt"

REM Set up .env
if not exist "%APP_DIR%\lib\homie\.env" (
    set DISCORD_BOT_TOKEN=%DISCORD_BOT_TOKEN%
    if "%DISCORD_BOT_TOKEN%"=="" (
        set /p DISCORD_BOT_TOKEN=Enter your DISCORD_BOT_TOKEN:
    )
    echo DISCORD_BOT_TOKEN=%DISCORD_BOT_TOKEN% > "%APP_DIR%\lib\homie\.env"
)

REM Launch the bot
echo Launching bot...
python "%APP_DIR%\lib\homie\homie.py"

endlocal