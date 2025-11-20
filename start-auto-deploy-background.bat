@echo off
title Auto-Deploy to GitHub (Background)
echo ========================================
echo Starting Automatic GitHub Deployment
echo (Running in background)
echo ========================================
echo.
echo The file watcher is now running.
echo It will automatically commit and push
echo changes to GitHub whenever you save files.
echo.
echo To stop it, close this window or
echo run: stop-auto-deploy.bat
echo.

cd /d "%~dp0"
start "Auto-Deploy Watcher" /min powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File "%~dp0auto-deploy.ps1"

echo.
echo Auto-deploy watcher started in background!
echo Check the taskbar for the minimized window.
echo.
pause

