@echo off
:: Check if the script is already elevated
:: If not elevated, request elevation and set a flag to prevent looping

if "%ADMIN_ELEVATED%" NEQ "1" (
    :: Attempt to perform a task that requires admin privileges to check if already elevated
    >nul 2>&1 "%SystemRoot%\system32\cacls.exe %SystemRoot%\system32\config\system"
    
    :: If not elevated, restart with admin rights
    if '%errorlevel%' NEQ '0' (
        echo Requesting Administrator permissions...
        set "ADMIN_ELEVATED=1"
        powershell -Command "Start-Process '%~f0' -Verb RunAs -ArgumentList 'ADMIN_ELEVATED=1'"
        exit /b
    )
)

:: If already running as administrator, proceed to call the child script
echo Running link.bat with Administrator privileges...
call "%~dp0link.bat"
pause
