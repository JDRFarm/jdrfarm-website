@echo off
echo ========================================
echo Quick GitHub Update
echo ========================================
echo.
echo Opening GitHub to update script.js
echo.

start "" "https://github.com/JDRFarm/jdrfarm-website/edit/main/script.js"
timeout /t 2 >nul
start "" "https://github.com/JDRFarm/jdrfarm-website"

echo.
echo GitHub editor opened!
echo.
echo Quick steps:
echo 1. Find: async function confirmPayment()
echo 2. Replace with code from GITHUB_UPDATE_GUIDE.md
echo 3. Commit changes
echo 4. Netlify auto-deploys!
echo.
pause

