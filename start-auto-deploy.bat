@echo off
title Auto-Deploy to GitHub
echo ========================================
echo Starting Automatic GitHub Deployment
echo ========================================
echo.
echo This will watch for file changes and
echo automatically commit and push to GitHub.
echo.
echo Press Ctrl+C to stop the watcher.
echo.
pause

cd /d "%~dp0"
powershell.exe -ExecutionPolicy Bypass -File "%~dp0auto-deploy.ps1"

pause

