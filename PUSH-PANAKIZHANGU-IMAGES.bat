@echo off
cd /d "D:\AI\web\jdrfarm-website"
echo Pushing Pana-kizhangu and Pana-kizhangu Powder images to GitHub...
echo.
git add image/panakizhangu.png image/panakizhangu-powder.png
git status
echo.
git commit -m "Add Pana-kizhangu and Pana-kizhangu Powder product images"
git push
echo.
echo Done. Wait 1-2 min for Netlify to deploy, then refresh your domain.
pause
