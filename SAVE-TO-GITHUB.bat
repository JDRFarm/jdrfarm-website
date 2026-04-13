@echo off
title Push JDR Farm site to GitHub
cd /d "%~dp0"

set "GIT_EXE="
if exist "C:\Program Files\Git\bin\git.exe" set "GIT_EXE=C:\Program Files\Git\bin\git.exe"
if exist "C:\Program Files\Git\cmd\git.exe" set "GIT_EXE=C:\Program Files\Git\cmd\git.exe"
if exist "%LOCALAPPDATA%\GitHubDesktop\resources\app\git\cmd\git.exe" set "GIT_EXE=%LOCALAPPDATA%\GitHubDesktop\resources\app\git\cmd\git.exe"

if not defined GIT_EXE (
    echo Git was not found. Install Git for Windows or GitHub Desktop, then run this again.
    echo https://git-scm.com/download/win
    start https://git-scm.com/download/win
    pause
    exit /b 1
)

echo Using: %GIT_EXE%
echo.

"%GIT_EXE%" add index.html script.js styles.css deploy-to-netlify.ps1 SAVE-TO-GITHUB.bat
"%GIT_EXE%" status
echo.
"%GIT_EXE%" commit -m "WhatsApp order: open chat with full order details and address"
if errorlevel 1 (
    echo Nothing to commit or commit failed. If there are no changes, you are already saved.
    pause
    exit /b 0
)

"%GIT_EXE%" push origin main
if errorlevel 1 (
    echo.
    echo Push failed. Try: git pull origin main --rebase
    echo Then run this script again.
    pause
    exit /b 1
)

echo.
echo Done. Check: https://github.com/JDRFarm/jdrfarm-website
start https://github.com/JDRFarm/jdrfarm-website
pause
