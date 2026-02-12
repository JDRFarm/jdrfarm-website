@echo off
echo ========================================
echo Push Latest Changes to GitHub
echo ========================================
echo.
echo Changes to push:
echo - Updated phone number: 9150150932 -^> 9150830025
echo - Fixed CNAME merge conflict
echo - Updated WhatsApp links
echo.
echo ========================================
echo Opening GitHub Desktop...
echo ========================================
echo.

REM Try to find GitHub Desktop
if exist "%LOCALAPPDATA%\GitHubDesktop\GitHubDesktop.exe" (
    start "" "%LOCALAPPDATA%\GitHubDesktop\GitHubDesktop.exe"
    echo GitHub Desktop opened!
    echo.
    echo Please follow these steps:
    echo 1. Select repository: jdrfarm-website
    echo 2. You should see these files in "Changes":
    echo    - index.html (modified)
    echo    - CNAME (modified)
    echo 3. Commit message:
    echo    "Update phone number to 9150830025 and fix CNAME"
    echo 4. Click "Commit to main"
    echo 5. Click "Push origin" (top right)
    echo 6. Wait for push to complete
    echo.
    echo Netlify will auto-deploy after push!
) else (
    echo GitHub Desktop not found.
    echo.
    echo Please install GitHub Desktop:
    echo https://desktop.github.com
    echo.
)

echo.
echo Opening GitHub web interface as alternative...
start https://github.com/JDRFarm/jdrfarm-website
timeout /t 2
start https://github.com/JDRFarm/jdrfarm-website/edit/main/index.html
timeout /t 1
start https://github.com/JDRFarm/jdrfarm-website/edit/main/CNAME

echo.
echo ========================================
echo Files ready to push:
echo ========================================
echo - index.html (phone number updated)
echo - CNAME (merge conflict fixed)
echo.
echo You can also push via GitHub website:
echo 1. Go to: https://github.com/JDRFarm/jdrfarm-website
echo 2. Edit index.html and CNAME
echo 3. Copy content from local files
echo 4. Commit with message: "Update phone number to 9150830025 and fix CNAME"
echo.
pause

