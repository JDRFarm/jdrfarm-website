@echo off
echo ========================================
echo Final Automatic GitHub Update
echo ========================================
echo.

cd jdrfarm-website

REM Try GitHub Desktop Git
set GIT_PATH=%LOCALAPPDATA%\GitHubDesktop\resources\app\git\cmd\git.exe

if exist "%GIT_PATH%" (
    echo Using GitHub Desktop Git...
    echo.
    echo Staging script.js...
    "%GIT_PATH%" add script.js
    echo.
    echo Committing...
    "%GIT_PATH%" commit -m "Update contact info to 9150150932 and info@jdrfarm.com, add WhatsApp order notification"
    echo.
    echo Pushing to GitHub...
    "%GIT_PATH%" push origin main
    if errorlevel 1 (
        "%GIT_PATH%" push origin master
    )
    if not errorlevel 1 (
        echo.
        echo ========================================
        echo SUCCESS! Updated on GitHub
        echo ========================================
        echo.
        echo Netlify is auto-deploying now!
        echo Check: https://app.netlify.com
        echo.
        start https://app.netlify.com
        pause
        exit /b 0
    )
)

REM If push failed, open GitHub editor
echo.
echo Opening GitHub editor for update...
echo.
start "" "https://github.com/JDRFarm/jdrfarm-website/edit/main/script.js"
timeout /t 2 >nul
start "" notepad.exe "CODE_TO_PASTE.txt"

echo.
echo GitHub editor and code file opened!
echo Copy code from Notepad and paste in GitHub.
echo.
pause

