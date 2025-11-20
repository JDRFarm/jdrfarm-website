@echo off
echo ========================================
echo Stopping Auto-Deploy Watcher
echo ========================================
echo.

taskkill /FI "WINDOWTITLE eq Auto-Deploy Watcher*" /T /F 2>nul
taskkill /FI "IMAGENAME eq powershell.exe" /FI "WINDOWTITLE eq Auto-Deploy*" /T /F 2>nul

echo Auto-deploy watcher stopped.
echo.
pause

