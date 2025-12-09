@echo off
echo ========================================
echo Auto Deploy to GitHub
echo ========================================
echo.

cd /d "%~dp0"

echo Checking for Git...
where git >nul 2>&1
if %errorlevel% equ 0 (
    echo Found Git! Deploying...
    echo.
    git add index.html script.js
    git commit -m "Update branding from JDR Farm to JDR"
    git push origin main
    if %errorlevel% equ 0 (
        echo.
        echo ========================================
        echo SUCCESS! Deployed to GitHub
        echo ========================================
        echo.
        echo Repository: https://github.com/JDRFarm/jdrfarm-website
        echo Live site: https://jdrfarm.com
        echo.
        pause
        exit /b 0
    ) else (
        git push origin master
        if %errorlevel% equ 0 (
            echo.
            echo ========================================
            echo SUCCESS! Deployed to GitHub
            echo ========================================
            echo.
            pause
            exit /b 0
        )
    )
)

echo Git not found. Opening GitHub web interface...
echo.

start https://github.com/JDRFarm/jdrfarm-website/edit/main/index.html
timeout /t 2 /nobreak >nul
start https://github.com/JDRFarm/jdrfarm-website/edit/main/script.js

echo.
echo GitHub editors opened!
echo Please copy your local files and commit.
echo.
pause

