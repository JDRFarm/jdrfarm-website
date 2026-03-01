# Push GitHub Repo to Your Domain (Hostinger)

This guide gets your **jdrfarm-website** GitHub repo deploying to **jdrfarm.com** on Hostinger whenever you push.

---

## 1. Get FTP details from Hostinger

1. Log in at [hostinger.com](https://www.hostinger.com) → **hPanel**.
2. Go to **Files** → **FTP Accounts** (or **Advanced** → **FTP**).
3. Note or create an FTP account and write down:
   - **FTP host** – e.g. `ftp.jdrfarm.com` or the hostname Hostinger shows (e.g. `srv123.hostinger.com`).
   - **Username** – full FTP username (often `u123456789@jdrfarm.com` or similar).
   - **Password** – the FTP account password.
4. The **web root** for your domain is usually **`public_html`**. The workflow deploys into that folder.

---

## 2. Add secrets in GitHub

1. Open your **jdrfarm-website** repo on GitHub.
2. Go to **Settings** → **Secrets and variables** → **Actions**.
3. Click **New repository secret** and add these three secrets:

| Secret name                   | Value              |
|------------------------------|--------------------|
| `HOSTINGER_FTP_SERVER`       | Your FTP host      |
| `HOSTINGER_FTP_USERNAME`     | Your FTP username  |
| `HOSTINGER_FTP_PASSWORD`     | Your FTP password  |

---

## 3. Push to deploy

- **Automatic:** Push (or merge) to the **main** or **master** branch.  
  GitHub Actions runs the **Deploy to Hostinger** workflow and uploads the site to `public_html` on Hostinger.
- **Manual:** Repo → **Actions** → **Deploy to Hostinger** → **Run workflow** → **Run workflow**.

After a minute or two, check **https://jdrfarm.com** to see the updated site.

---

## 4. Make sure the domain is connected

If the domain isn’t showing your site yet:

- **DNS:** Point jdrfarm.com to Hostinger (nameservers or A record). See **FULLY-CONNECT-DOMAIN-CHECKLIST.md**.
- **SSL:** In hPanel → **Security** → **SSL**, install AutoSSL for jdrfarm.com. See **HOSTINGER-SSL-STEPS.md**.

---

## Summary

| Step | Where |
|------|--------|
| Get FTP host, username, password | Hostinger hPanel → Files → FTP Accounts |
| Add `HOSTINGER_FTP_SERVER`, `HOSTINGER_FTP_USERNAME`, `HOSTINGER_FTP_PASSWORD` | GitHub repo → Settings → Secrets and variables → Actions |
| Deploy | Push to `main`/`master` or run “Deploy to Hostinger” in Actions |

The workflow file is **`.github/workflows/deploy-hostinger.yml`**. It uses the same FTP deploy action as your GoDaddy workflow, targeting Hostinger’s `public_html`.
