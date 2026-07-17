# Netlify Auto-Deploy for jdrfarm.com

This repo is configured for **automatic Netlify deployment** on every push to `main`.

## One-time setup in Netlify (do this once)

1. Open **https://app.netlify.com**
2. **Add new site** → **Import an existing project** → **GitHub**
3. Select **JDRFarm/jdrfarm-website**
4. Click **Deploy** (build settings are read from `netlify.toml` automatically)
5. After deploy, go to **Domain management** → add **jdrfarm.com** and **www.jdrfarm.com**
6. Update GoDaddy DNS to Netlify values (shown in Domain management)

## Build settings (already in repo)

| Setting | Value |
|---------|--------|
| Branch | `main` |
| Build command | *(empty)* |
| Publish directory | `.` |

Netlify reads these from **`netlify.toml`** — no manual UI setup needed.

## Auto-deploy workflow

```
Edit website files → git push to main → Netlify redeploys → jdrfarm.com updates
```

Usually takes **1–2 minutes** after each push.

## Verify auto-deploy is on

In Netlify: **Project configuration** → **Build & deploy** → **Continuous deployment**

- Repository: `JDRFarm/jdrfarm-website`
- Branch: `main`
- **Auto publishing**: ON

## Optional: GitHub Actions deploy

If you add these secrets in GitHub (**Settings → Secrets → Actions**):

- `NETLIFY_AUTH_TOKEN`
- `NETLIFY_SITE_ID`

Then `.github/workflows/netlify-deploy.yml` will also deploy on push.

Get token: Netlify → **User settings** → **Applications** → **Personal access tokens**  
Get site ID: Netlify → **Site configuration** → **General** → **Site details** → **Site ID**

## GoDaddy DNS for Netlify

| Type | Name | Value |
|------|------|--------|
| A | `@` | `75.2.60.5` |
| CNAME | `www` | `jdrfarm.netlify.app` |

Use the exact values Netlify shows for your site if different.

## Links

- Netlify dashboard: https://app.netlify.com
- GitHub repo: https://github.com/JDRFarm/jdrfarm-website
- GoDaddy DNS: https://dcc.godaddy.com/manage/jdrfarm.com/dns
