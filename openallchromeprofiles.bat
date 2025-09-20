@echo off
setlocal enabledelayedexpansion

echo Opening all Chrome profiles with https://wplace.live...
echo.

REM Set Chrome executable path (adjust if Chrome is installed elsewhere)
set CHROME_PATH="C:\Program Files\Google\Chrome\Application\chrome.exe"
if not exist %CHROME_PATH% (
    set CHROME_PATH="C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
)

REM Check if Chrome is installed
if not exist %CHROME_PATH% (
    echo Chrome not found in default locations!
    echo Please update the CHROME_PATH variable in this script.
    pause
    exit /b
)

REM Chrome user data directory
set USER_DATA_DIR=%LOCALAPPDATA%\Google\Chrome\User Data

REM Check if Chrome user data directory exists
if not exist "%USER_DATA_DIR%" (
    echo Chrome user data directory not found!
    echo Expected location: %USER_DATA_DIR%
    pause
    exit /b
)

REM Initialize counter
set count=0

REM Website to open in each profile
set WEBSITE=https://wplace.live

REM Open Default profile
if exist "%USER_DATA_DIR%\Default" (
    echo Opening Default profile with %WEBSITE%...
    start "" %CHROME_PATH% --profile-directory="Default" "%WEBSITE%"
    set /a count+=1
    timeout /t 2 /nobreak >nul
)

REM Open numbered profiles (Profile 1, Profile 2, etc.)
for /d %%d in ("%USER_DATA_DIR%\Profile *") do (
    set "profile_name=%%~nxd"
    echo Opening profile: !profile_name! with %WEBSITE%...
    start "" %CHROME_PATH% --profile-directory="!profile_name!" "%WEBSITE%"
    set /a count+=1
    timeout /t 2 /nobreak >nul
)

REM Display results
echo.
if !count! gtr 0 (
    echo Successfully opened !count! Chrome profile(s) with https://wplace.live!
) else (
    echo No Chrome profiles found.
)

echo.
echo Press any key to exit...
pause >nul
