# GoDaddy DNS for GitHub Pages (No Netlify) — Detailed Steps

Point **jdrfarm.com** directly to GitHub. Every `git push` to `main` updates the live site automatically.

---

# STEP 1 — Enable GitHub Pages (Detailed)

## 1.1 Open your GitHub repository

1. Open your web browser (Chrome, Edge, etc.)
2. Go to: **https://github.com**
3. **Sign in** with your GitHub account (**JDRFarm**)
4. Click your **profile picture** (top-right corner)
5. Click **Your repositories**
6. Click the repository named: **jdrfarm-website**

   **Direct link:** https://github.com/JDRFarm/jdrfarm-website

---

## 1.2 Open Pages settings

1. At the top of the repository page, you will see tabs:
   - Code | Issues | Pull requests | Actions | Projects | Wiki | Security | **Settings**
2. Click **Settings** (last tab on the right)
3. On the **left sidebar**, scroll down
4. Click **Pages** (under "Code and automation" section)

   **Direct link:** https://github.com/JDRFarm/jdrfarm-website/settings/pages

---

## 1.3 Set deployment source to GitHub Actions

1. On the Pages settings page, find the section: **Build and deployment**
2. Under **Source**, you will see a dropdown (may say "Deploy from a branch" or "GitHub Actions")
3. Click the **Source** dropdown
4. Select: **GitHub Actions**

   > This tells GitHub to use the workflow file already in your repo (`.github/workflows/deploy-github-pages.yml`) to deploy your site automatically when you push code.

---

## 1.4 Add your custom domain

1. Scroll down to the section: **Custom domain**
2. You will see a text box (may be empty)
3. Type exactly: **jdrfarm.com**
4. Click the **Save** button next to the text box

   > GitHub will show "DNS check in progress" or "DNS not configured" — that is normal until you complete Step 2 (GoDaddy DNS).

---

## 1.5 Trigger the first deployment

1. Open the **Actions** tab at the top of your repository
2. You should see a workflow named: **Deploy to GitHub Pages**
3. If it is not running yet:
   - Go to **Actions** tab
   - Click **Deploy to GitHub Pages** on the left
   - Click **Run workflow** button (right side)
   - Select branch: **main**
   - Click green **Run workflow** button
4. Wait 1–2 minutes until you see a **green checkmark** ✓

   **Direct link:** https://github.com/JDRFarm/jdrfarm-website/actions

---

## 1.6 Verify GitHub Pages is working

1. Go back to **Settings** → **Pages**
2. You should see a message like:
   - "Your site is live at **https://jdrfarm.github.io/jdrfarm-website/**"
3. Click that link — your website should open (may take 2–3 minutes first time)

   **Do NOT enable "Enforce HTTPS" yet** — wait until Step 2 DNS is done (Step 3).

---

# STEP 2 — Update GoDaddy DNS (Detailed)

## 2.1 Login to GoDaddy

1. Open: **https://www.godaddy.com**
2. Click **Sign In** (top-right)
3. Enter your GoDaddy username and password
4. Click **Sign In**

---

## 2.2 Open DNS management for jdrfarm.com

**Method A — Direct link (fastest):**
1. Go to: **https://dcc.godaddy.com/manage/jdrfarm.com/dns**

**Method B — Through My Products:**
1. Go to: **https://account.godaddy.com/products**
2. Find **Domains** section
3. Find **jdrfarm.com** in the list
4. Click the **DNS** button (or three dots ⋮ → **Manage DNS**)

You should now see a page titled **DNS Management** with a table of records.

---

## 2.3 Delete OLD Netlify records

Look at the table of DNS records. Find and **delete** these:

### Delete Record 1 — Netlify A record
| What to find | Action |
|--------------|--------|
| Type: **A** | Click the **pencil/edit** or **trash/delete** icon |
| Name: **@** | |
| Value: **75.2.60.5** | Click **Delete** or **Remove** → Confirm |

### Delete Record 2 — Netlify CNAME record
| What to find | Action |
|--------------|--------|
| Type: **CNAME** | Click the **trash/delete** icon |
| Name: **www** | |
| Value: **jdrfarm.netlify.app** | Click **Delete** → Confirm |

> If you see other A records for `@` pointing to different IPs (like GoDaddy hosting), delete those too — you only want the 4 GitHub IPs below.

---

## 2.4 Add NEW GitHub Pages records

Click the **Add** button (or **Add New Record**) for each record below.

### A Record 1
```
Type:  A
Name:  @
Value: 185.199.108.153
TTL:   600 seconds (or 1 Hour — use lowest available)
```
Click **Save**

### A Record 2
```
Type:  A
Name:  @
Value: 185.199.109.153
TTL:   600 seconds
```
Click **Save**

### A Record 3
```
Type:  A
Name:  @
Value: 185.199.110.153
TTL:   600 seconds
```
Click **Save**

### A Record 4
```
Type:  A
Name:  @
Value: 185.199.111.153
TTL:   600 seconds
```
Click **Save**

### CNAME Record (for www)
```
Type:  CNAME
Name:  www
Value: JDRFarm.github.io
TTL:   600 seconds
```
Click **Save**

> **Important:** Type `JDRFarm.github.io` exactly — your GitHub username is **JDRFarm** (capital J, D, R, F).

---

## 2.5 Verify your DNS table looks correct

After all changes, your DNS table should include:

| Type  | Name | Value               |
|-------|------|---------------------|
| A     | @    | 185.199.108.153     |
| A     | @    | 185.199.109.153     |
| A     | @    | 185.199.110.153     |
| A     | @    | 185.199.111.153     |
| CNAME | www  | JDRFarm.github.io   |

You may also have other records (MX for email, TXT, etc.) — **leave those alone**.

---

# STEP 3 — Enable HTTPS (After 1–2 Hours)

DNS changes take time to spread worldwide.

1. Wait **1–2 hours** (sometimes up to 24 hours)
2. Go to: https://github.com/JDRFarm/jdrfarm-website/settings/pages
3. Under **Custom domain**, wait until GitHub shows: **"DNS check successful"**
4. Check the box: **Enforce HTTPS**
5. Click **Save**

---

# How automatic updates work

```
You edit files on your computer
    ↓
git push to main branch on GitHub
    ↓
GitHub Actions runs "Deploy to GitHub Pages" (1–2 min)
    ↓
https://jdrfarm.com shows your updated site
```

No Netlify. No manual upload. No FTP.

---

# Test your site

| When | URL to test |
|------|-------------|
| After Step 1 | https://JDRFarm.github.io/jdrfarm-website/ |
| After Step 2 (1–2 hrs) | https://jdrfarm.com |
| After Step 2 (1–2 hrs) | https://www.jdrfarm.com |

Check DNS propagation: https://dnschecker.org/#A/jdrfarm.com  
(Should show `185.199.108.153` or similar GitHub IP)

---

# Common problems

**"Page not found" on GitHub settings**
→ Sign in to GitHub first. Make sure you are logged in as **JDRFarm**.

**GoDaddy won't let me add 4 A records with same Name @**
→ GoDaddy allows multiple A records with the same name. Add them one at a time.

**GitHub shows "DNS not configured"**
→ Complete Step 2 first, then wait 1–2 hours.

**Site works on github.io URL but not jdrfarm.com**
→ DNS not propagated yet. Wait longer or check dnschecker.org.

**CNAME value wrong**
→ Must be `JDRFarm.github.io` — NOT `jdrfarm.com` and NOT `github.io` alone.
