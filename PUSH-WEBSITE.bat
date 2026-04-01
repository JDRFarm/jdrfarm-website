@echo off
cd /d "%~dp0"
echo Pushing jdrfarm-website to GitHub (Netlify will deploy to your domain)...
echo.
git add -A
git status
echo.
git commit -m "Website updates: products, prices, Pana-kizhangu Powder"
if errorlevel 1 (
  echo Nothing to commit, or commit failed. Trying push anyway...
)
git push
if errorlevel 1 (
  echo.
  echo FAILED: Install Git from https://git-scm.com/download/win or use GitHub Desktop.
  pause
  exit /b 1
)
echo.
echo Done. Open Netlify to confirm deploy in 1-2 minutes, then check https://jdrfarm.com
pause
