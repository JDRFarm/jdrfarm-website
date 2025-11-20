# 🚀 Automatic GitHub Deployment Setup

This setup automatically commits and pushes your changes to GitHub whenever you save files!

## ✅ Quick Start

### Option 1: Run in Foreground (Recommended for First Time)
1. Double-click: **`start-auto-deploy.bat`**
2. The watcher will start and show you all activity
3. Make any change to your files (save index.html, etc.)
4. Watch it automatically commit and push!

### Option 2: Run in Background (Always On)
1. Double-click: **`start-auto-deploy-background.bat`**
2. The watcher runs in the background
3. It will automatically deploy whenever you save files
4. To stop: Run **`stop-auto-deploy.bat`**

## 📋 How It Works

1. **File Watcher** monitors your repository folder
2. When you **save any file**, it detects the change
3. **Automatically commits** with a timestamp message
4. **Automatically pushes** to GitHub
5. Your live site updates in 1-2 minutes! ✨

## 🎯 What Gets Watched

- ✅ All files in the repository folder
- ✅ Subdirectories (image/, logo/, etc.)
- ✅ New files, modified files, deleted files
- ❌ Ignores .git folder and temporary files

## ⚙️ Configuration

### Change Commit Message Format
Edit `auto-deploy.ps1` and modify this line:
```powershell
$commitMessage = "Auto-deploy: $changeType - $fileName at $([DateTime]::Now.ToString('yyyy-MM-dd HH:mm:ss'))"
```

### Change Debounce Time (Wait Time)
Edit `auto-deploy.ps1` and modify this line (3000 = 3 seconds):
```powershell
$script:debounceTimer = New-Object System.Timers.Timer(3000)
```

## 🛠️ Requirements

- **Git** or **GitHub Desktop** installed
- Repository connected to GitHub
- PowerShell execution policy allows scripts (bypassed in batch files)

## 📝 Example Workflow

1. **Start the watcher:**
   ```
   Double-click: start-auto-deploy-background.bat
   ```

2. **Edit your website:**
   - Open `index.html` in your editor
   - Make changes
   - Save the file (Ctrl+S)

3. **Automatic deployment:**
   - Watcher detects change
   - Commits: "Auto-deploy: Changed - index.html at 2025-01-18 14:30:45"
   - Pushes to GitHub
   - Your site updates automatically! 🎉

## 🆘 Troubleshooting

### "Git not found"
- Install Git: https://git-scm.com/download/win
- Or install GitHub Desktop (includes Git)

### "Push failed"
- Check your GitHub authentication
- Verify repository is connected: `git remote -v`
- You may need to push manually via GitHub Desktop first time

### "Nothing happens when I save"
- Make sure the watcher is running (check taskbar)
- Check if file is in the repository folder
- Verify Git is working: Open GitHub Desktop and check repository

### "Too many commits"
- Increase debounce time in `auto-deploy.ps1`
- The script waits 3 seconds to batch multiple changes

## 🎉 Benefits

- ✅ **Zero manual steps** - Just save and it deploys!
- ✅ **Always up-to-date** - Your GitHub repo stays synced
- ✅ **Automatic site updates** - GitHub Pages/Netlify auto-deploys
- ✅ **Peace of mind** - Never forget to push changes

## 🔄 Stopping the Watcher

- **Foreground mode:** Press Ctrl+C in the window
- **Background mode:** Run `stop-auto-deploy.bat`
- Or close the PowerShell window from taskbar

## 📌 Notes

- The watcher only commits when files actually change
- It ignores duplicate events (same file saved multiple times quickly)
- Commit messages include timestamp for easy tracking
- All changes are automatically staged and committed

---

**Enjoy automatic deployments! 🚀**

