# DNS Settings: Deploy GitHub via Netlify to Your GoDaddy Domain

**Important:** If your domain (e.g. jdrfarm.com) is **registered at GoDaddy**, you set DNS **in GoDaddy**, not in Hostinger. Hostinger is not involved for a GoDaddy domain.

---

## Flow

```
GitHub (repo)  →  Netlify (hosts the site)  ←  GoDaddy domain (DNS set in GoDaddy)
```

---

## DNS to Set in GoDaddy

Where: **https://account.godaddy.com** → **My Products** → **Domains** → **jdrfarm.com** → **DNS** (or **Manage DNS**).

Add or update these two records so **jdrfarm.com** and **www.jdrfarm.com** point to Netlify:

| Type   | Name | Value / Points to                    | TTL   |
|--------|------|---------------------------------------|-------|
| **A**  | `@`  | `75.2.60.5`                           | 600   |
| **CNAME** | `www` | **your-site-name.netlify.app**     | 600   |

- **A record `@`**: Makes **jdrfarm.com** (root) point to Netlify’s load balancer.
- **CNAME `www`**: Makes **www.jdrfarm.com** point to your Netlify site. Replace **your-site-name** with your real Netlify subdomain (e.g. if your site is **jdrfarm.netlify.app**, use **jdrfarm.netlify.app**).

### In GoDaddy step-by-step

1. Remove any existing **A** records for **@** (or edit the value to `75.2.60.5`).
2. **Add** (or edit) **A** record: Name **@**, Value **75.2.60.5**, TTL **600**.
3. **Add** (or edit) **CNAME** record: Name **www**, Value **your-site-name.netlify.app**, TTL **600**.
4. Save. Wait 15–60 minutes (up to 24–48 hours in rare cases) for DNS to propagate.

---

## Netlify side (before/after)

1. In **Netlify**: Site → **Domain management** → add **jdrfarm.com** and **www.jdrfarm.com** → choose **“Use external DNS”** (DNS at GoDaddy).
2. After GoDaddy DNS is set: In Netlify, **Verify DNS configuration** and enable **HTTPS**.

---

## When is Hostinger used?

- **Hostinger** DNS is only used if your domain’s DNS is managed **at Hostinger** (e.g. domain registered there or nameservers pointed to Hostinger).
- For a **GoDaddy domain**, DNS is always set in **GoDaddy**; no DNS settings are needed in Hostinger.

---

## Summary

| Question | Answer |
|----------|--------|
| Where do I set DNS for a GoDaddy domain? | **GoDaddy** (My Products → Domains → jdrfarm.com → DNS). |
| Do I set anything in Hostinger for a GoDaddy domain? | **No.** Hostinger is not used for GoDaddy domain DNS. |
| What A record in GoDaddy? | **A** → Name **@**, Value **75.2.60.5**. |
| What CNAME in GoDaddy? | **CNAME** → Name **www**, Value **your-site-name.netlify.app**. |
