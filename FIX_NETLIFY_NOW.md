# Fix Netlify "Site Not Found" — 3 Steps

You see this error because **GoDaddy DNS points to Netlify**, but **no website is deployed on Netlify yet**.

Your DNS is already correct — you only need to connect GitHub in Netlify.

---

## Step 1 — Login to Netlify (1 minute)

1. Open: **https://app.netlify.com/start**
2. Click **Log in with GitHub**
3. Sign in as **JDRFarm**
4. Click **Authorize Netlify**

---

## Step 2 — Deploy from GitHub (2 minutes)

1. Click **GitHub**
2. Find and select: **JDRFarm/jdrfarm-website**
3. Settings:
   - Branch: **main**
   - Build command: **leave empty**
   - Publish directory: **/** (root)
4. Click **Deploy jdrfarm-website**
5. Wait 1–2 minutes until status shows **Published**

---

## Step 3 — Match your domain name (1 minute)

Your GoDaddy DNS expects the site name **jdrfarm**:

1. Go to **Site configuration** → **General** → **Site details**
2. Change site name to: **jdrfarm**
3. Confirm URL is: **https://jdrfarm.netlify.app**

Then add custom domain:

1. Go to **Domain management**
2. Click **Add a domain**
3. Enter: **jdrfarm.com**
4. Also add: **www.jdrfarm.com**

DNS is already set — verification should pass in a few minutes.

Enable HTTPS:

1. **Domain management** → **HTTPS**
2. Click **Verify DNS configuration**
3. Turn on **Force HTTPS**

---

## Test

| URL | Should show |
|-----|-------------|
| https://jdrfarm.netlify.app | Your website |
| https://jdrfarm.com | Your website |
| https://www.jdrfarm.com | Your website |

---

## Auto-updates after this

```
Edit code → git push to main → Netlify redeploys in 1–2 min → jdrfarm.com updates
```

No manual upload needed ever again.

---

## Still stuck?

- Netlify dashboard: https://app.netlify.com
- GitHub repo: https://github.com/JDRFarm/jdrfarm-website
- GoDaddy DNS (already correct): https://dcc.godaddy.com/manage/jdrfarm.com/dns
