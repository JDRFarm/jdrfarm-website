# Connect jdrfarm.com to GitHub — Do These Steps Now

Your GoDaddy DNS is **already pointing to Netlify**, but the site is not deployed yet.  
Follow **Option A** (fastest — no DNS changes needed).

---

## Option A: Netlify + GitHub (Recommended — DNS already set)

Your domain DNS is already correct:
- `jdrfarm.com` → `75.2.60.5` (Netlify)
- `www.jdrfarm.com` → `jdrfarm.netlify.app`

You only need to connect your GitHub repo in Netlify:

### Step 1 — Login to Netlify with GitHub
1. Go to: https://app.netlify.com
2. Click **Log in with GitHub**
3. Authorize Netlify

### Step 2 — Import your repo
1. Click **Add new site** → **Import an existing project**
2. Choose **GitHub**
3. Select repo: **JDRFarm/jdrfarm-website**
4. Build settings:
   - **Build command:** leave empty
   - **Publish directory:** `/` (root)
5. Click **Deploy site**

### Step 3 — Set site name to `jdrfarm`
1. Go to **Site configuration** → **General** → **Site details**
2. Change site name to: `jdrfarm`
3. This makes your URL: `jdrfarm.netlify.app` (matches your www DNS)

### Step 4 — Add custom domain
1. Go to **Domain management** → **Add a domain**
2. Enter: `jdrfarm.com`
3. Also add: `www.jdrfarm.com`
4. Netlify will verify DNS (already correct — should pass in minutes)

### Step 5 — Enable HTTPS
1. Go to **Domain management** → **HTTPS**
2. Click **Verify DNS configuration**
3. Wait 5–10 minutes for SSL certificate
4. Turn on **Force HTTPS**

**Done!** Every `git push` to `main` auto-updates jdrfarm.com.

---

## Option B: GitHub Pages (Alternative — requires DNS change)

Use this only if you prefer GitHub hosting instead of Netlify.

### Step 1 — Enable GitHub Pages
1. Go to: https://github.com/JDRFarm/jdrfarm-website/settings/pages
2. Under **Build and deployment** → **Source**: select **GitHub Actions**
3. Save

The workflow `.github/workflows/deploy-github-pages.yml` will deploy on every push.

### Step 2 — Add custom domain in GitHub
1. On the same Pages settings page
2. Under **Custom domain**, enter: `jdrfarm.com`
3. Click **Save**
4. Wait for DNS check

### Step 3 — Update GoDaddy DNS
Go to: https://dcc.godaddy.com/manage/jdrfarm.com/dns

**Delete** old Netlify records, then add:

| Type  | Name | Value               | TTL |
|-------|------|---------------------|-----|
| A     | @    | 185.199.108.153     | 600 |
| A     | @    | 185.199.109.153     | 600 |
| A     | @    | 185.199.110.153     | 600 |
| A     | @    | 185.199.111.153     | 600 |
| CNAME | www  | JDRFarm.github.io   | 600 |

### Step 4 — Enable HTTPS
1. Wait 1–2 hours for DNS propagation
2. Back in GitHub Pages settings, check **Enforce HTTPS**

---

## After setup — automatic updates

```
Edit files → git push to main → site updates in 1–2 minutes
```

No manual upload needed.

---

## Quick test

- Netlify: https://jdrfarm.netlify.app (after Step 2)
- Live domain: https://jdrfarm.com (after Steps 3–5)
- GitHub Pages: https://JDRFarm.github.io/jdrfarm-website (Option B only)
