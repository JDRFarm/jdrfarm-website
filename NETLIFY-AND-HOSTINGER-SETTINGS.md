# Deploy GitHub Repo to Your Domain Using Netlify + Hostinger

Use **Netlify** to host your site (connected to GitHub for auto-deploy) and **Hostinger** for your domain/DNS. Push to GitHub → Netlify deploys → your domain (e.g. jdrfarm.com) shows the site.

---

## Flow

```
GitHub (repo)  →  Netlify (builds & hosts)  ←  Your domain (DNS at Hostinger)
```

- **Netlify**: Connects to GitHub, deploys on every push, serves the site, provides SSL.
- **Hostinger**: Where your domain’s DNS lives. You add records there so jdrfarm.com points to Netlify.

---

# Part 1: Netlify settings

Where: **https://app.netlify.com** → your site (or create one).

---

## 1.1 Connect GitHub repo (Build & deploy)

| Setting | Value |
|--------|--------|
| **Path** | Site → **Site configuration** → **Build & deploy** → **Continuous deployment** |
| **Link repository** | Connect to GitHub → choose **jdrfarm-website** (or your repo name). |
| **Branch to deploy** | `main` (or `master` if that’s your default). |
| **Build command** | Leave **empty** (static site; your `netlify.toml` has `command = ""`). |
| **Publish directory** | `.` (root; same as `publish = "."` in netlify.toml). |
| **Deploy log visibility** | Default (or as you prefer). |

Your repo already has **netlify.toml**, so Netlify will use:

- Publish: root (`.`)
- No build step
- Redirects (www → non-www, HTTP → HTTPS) and headers

---

## 1.2 Domain management (custom domain)

| Setting | Value |
|--------|--------|
| **Path** | Site → **Domain management** (or **Domain settings**). |
| **Add custom domain** | Add **jdrfarm.com** and **www.jdrfarm.com**. |
| **DNS** | Choose **Use external DNS** (you’ll set records at Hostinger). |
| **HTTPS** | After DNS is correct, Netlify will issue SSL (Let’s Encrypt). Use **Verify DNS configuration** / **Renew certificate** if needed. |

After you add the domain, Netlify will show the exact **A** and **CNAME** targets. Use those if they differ from the examples below.

---

## 1.3 Netlify DNS targets (for use in Hostinger)

When using **external DNS** (Hostinger), you point your domain to Netlify like this:

| Type | Name / Host | Value / Points to | TTL |
|------|-------------|-------------------|-----|
| **A** | `@` (or apex/root) | `75.2.60.5` (Netlify load balancer) | 300 (5 min) or 3600 |
| **CNAME** | `www` | `your-site-name.netlify.app` | 300 or 3600 |

Replace **your-site-name** with your actual Netlify site name (e.g. from the `.netlify.app` URL).

---

## 1.4 Quick Netlify checklist

- [ ] Site created and connected to **jdrfarm-website** (GitHub).
- [ ] Branch: **main** (or **master**).
- [ ] Build command: **empty**; Publish directory: **.** (or leave default and rely on netlify.toml).
- [ ] Custom domains **jdrfarm.com** and **www.jdrfarm.com** added.
- [ ] Option “Use external DNS” selected (DNS managed at Hostinger).
- [ ] After DNS is set in Hostinger, **Verify DNS** / **Renew certificate** in Netlify so HTTPS is active.

---

# Part 2: Hostinger settings

Where: **https://hpanel.hostinger.com** (or Hostinger → **Domains** / **DNS**).

Use this if your domain **jdrfarm.com** is registered at Hostinger or if you manage its DNS at Hostinger.

---

## 2.1 Open DNS for jdrfarm.com

1. Log in to **Hostinger** → **hPanel**.
2. Go to **Domains** → select **jdrfarm.com**.
3. Open **DNS / DNS Zone** (or **Manage** → **DNS Records**).

---

## 2.2 Records to point the domain to Netlify

Add or update these so the domain points to Netlify:

| Type | Name / Host | Value / Points to | TTL |
|------|-------------|-------------------|-----|
| **A** | `@` | `75.2.60.5` | 14400 or 3600 |
| **CNAME** | `www` | `your-site-name.netlify.app` | 14400 or 3600 |

Notes:

- **Name `@`**: Usually “@” or “apex” or left blank; means “jdrfarm.com”.
- **Name `www`**: Means “www.jdrfarm.com”.
- Replace **your-site-name** with your real Netlify site subdomain (e.g. **jdrfarm** if the URL is **jdrfarm.netlify.app**).

Remove or don’t add conflicting records:

- No other **A** record for `@` pointing elsewhere.
- No other **CNAME** for `www` pointing elsewhere (e.g. to Hostinger or old hosting).

---

## 2.3 Optional: CAA (for SSL)

If Hostinger has **CAA** records that restrict which CAs can issue certs, ensure they allow Let’s Encrypt (Netlify uses it). If you’re unsure, you can leave existing CAA as-is and only add/change the A and CNAME above; often that’s enough.

---

## 2.4 If the domain is not at Hostinger (e.g. at GoDaddy)

Then you set the **same records** where the domain’s DNS is managed:

- **GoDaddy**: My Products → jdrfarm.com → **DNS** → add A and CNAME as in the table above.
- **Any registrar**: In the DNS/nameserver section, add the same **A** and **CNAME** records.

Hostinger is only needed for “settings” if you’re using Hostinger’s DNS for jdrfarm.com.

---

## 2.5 Hostinger checklist

- [ ] DNS Zone for **jdrfarm.com** open in hPanel.
- [ ] **A** record: `@` → `75.2.60.5`.
- [ ] **CNAME** record: `www` → `your-site-name.netlify.app`.
- [ ] No conflicting A/CNAME for `@` or `www`.
- [ ] Wait 5–60 minutes (up to 24–48 hours in rare cases), then check **https://jdrfarm.com** and **https://www.jdrfarm.com**.

---

# Summary table

| Where | What to set |
|-------|-------------|
| **Netlify** | Connect GitHub repo (jdrfarm-website), branch **main**, build empty, publish **.**, add domains **jdrfarm.com** + **www**, use external DNS. |
| **Hostinger** | DNS: **A** `@` → `75.2.60.5`, **CNAME** `www` → `your-site-name.netlify.app`. |
| **GitHub** | Push code; Netlify auto-deploys. No extra “Hostinger” deploy step. |

---

# After both are set

1. Push to **main** (or **master**) on GitHub.
2. Netlify deploys automatically (see **Deploys** in Netlify).
3. Open **https://jdrfarm.com** (and **https://www.jdrfarm.com**); both should show the site with HTTPS.

If the domain was previously pointed to Hostinger hosting (e.g. Website Builder), switching these DNS records to Netlify will make the domain show the Netlify (GitHub) site instead. Your **netlify.toml** already handles redirects and HTTPS.
