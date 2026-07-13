# GoDaddy DNS for GitHub Pages (No Netlify)

Point **jdrfarm.com** directly to GitHub Pages. Every `git push` to `main` updates the live site.

---

## Part 1 — Enable GitHub Pages (one time)

1. Open: https://github.com/JDRFarm/jdrfarm-website/settings/pages
2. Under **Build and deployment** → **Source**: select **GitHub Actions**
3. Under **Custom domain**, enter: `jdrfarm.com` → **Save**
4. Wait for the workflow to run: https://github.com/JDRFarm/jdrfarm-website/actions

Your repo already has the deploy workflow and `CNAME` file.

---

## Part 2 — Update GoDaddy DNS

Open: https://dcc.godaddy.com/manage/jdrfarm.com/dns

### Delete old Netlify records

Remove these if present:

| Type  | Name | Old value (delete)     |
|-------|------|------------------------|
| A     | @    | `75.2.60.5`            |
| CNAME | www  | `jdrfarm.netlify.app`  |

### Add GitHub Pages records

Add **4 A records** for the root domain:

| Type | Name | Value             | TTL |
|------|------|-------------------|-----|
| A    | @    | 185.199.108.153   | 600 |
| A    | @    | 185.199.109.153   | 600 |
| A    | @    | 185.199.110.153   | 600 |
| A    | @    | 185.199.111.153   | 600 |

Add **1 CNAME record** for www:

| Type  | Name | Value              | TTL |
|-------|------|--------------------|-----|
| CNAME | www  | JDRFarm.github.io  | 600 |

Click **Save** after each record.

---

## Part 3 — Enable HTTPS (after DNS propagates)

1. Wait **1–2 hours** for DNS to propagate
2. Go back to: https://github.com/JDRFarm/jdrfarm-website/settings/pages
3. Check **Enforce HTTPS**

---

## How updates work

```
Edit files → git push to main → GitHub Actions deploys → jdrfarm.com updates (1–2 min)
```

No Netlify. No manual upload.

---

## Test URLs

| URL | Expected |
|-----|----------|
| https://JDRFarm.github.io/jdrfarm-website/ | Site (after Pages enabled) |
| https://jdrfarm.com | Site (after DNS propagates) |
| https://www.jdrfarm.com | Site (after DNS propagates) |

Check DNS: https://dnschecker.org/#A/jdrfarm.com
