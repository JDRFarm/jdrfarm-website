@echo off
cd /d "D:\AI\web\jdrfarm-website"
echo Adding all changes...
git add image/ index.html
echo.
git status
echo.
set /p confirm="Commit and push? (y/n): "
if /i "%confirm%" neq "y" exit /b 0
git commit -m "Update product images (groundnut oil, panakizhangu, panakizhangu powder) and groundnut oil prices/quantities"
git push
echo.
echo Done. Netlify will deploy to your domain shortly.
pause
