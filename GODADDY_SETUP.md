# 🌐 How to Publish GitHub Repo to GoDaddy

There are two ways to connect your GitHub repository to GoDaddy, depending on what services you have purchased.

---

## 🛑 First: Which Scenario Matches You?

### **Scenario A: You have GoDaddy Web Hosting**
*   **You bought:** A "Web Hosting" or "cPanel Hosting" plan from GoDaddy.
*   **Goal:** You want your website files (`index.html`, etc.) to live on GoDaddy's servers.
*   **Action:** Follow **Option 1** below.

### **Scenario B: You ONLY have a GoDaddy Domain**
*   **You bought:** Only the domain name (e.g., `jdrfarm.com`).
*   **Goal:** You want to host the site for free on GitHub (via GitHub Pages) but use your GoDaddy domain name.
*   **Action:** Follow **Option 2** below.

---

## Option 1: Deploy to GoDaddy Web Hosting (cPanel)

If you have a hosting plan, the best way to sync your GitHub repo is using the **"Git Version Control"** feature in cPanel.

### Step 1: Prepare your cPanel
1.  Log in to your **GoDaddy Account**.
2.  Go to **My Products** > **Web Hosting** > **Manage**.
3.  Click **cPanel Admin**.
4.  Scroll down to the **Files** section and look for **Git Version Control**. (If you don't see it, use the FTP method below).

### Step 2: Connect Repository
1.  In **Git Version Control**, click **Create**.
2.  **Clone URL:** Enter your GitHub repository URL (e.g., `https://github.com/yourusername/jdrfarm-website.git`).
    *   *Note: If your repo is private, you will need to set up an SSH key or use a Personal Access Token.*
3.  **Repository Path:** Leave as default or name it (e.g., `jdrfarm`).
4.  **Repository Name:** Name it `jdrfarm`.
5.  Click **Create**.

### Step 3: Deploy
1.  Once created, click **Manage**.
2.  Go to the **Pull or Deploy** tab.
3.  Click **Update from Remote** to pull the latest changes from GitHub.
4.  **Important:** You may need to copy the files from the repository folder to your `public_html` folder if cPanel doesn't do it automatically. Typically, people set up a `.cpanel.yml` file to automate this.

### Alternative: FTP Upload (Simplest)
1.  Open **File Manager** in cPanel.
2.  Navigate to `public_html`.
3.  Click **Upload**.
4.  Upload your files (`index.html`, `styles.css`, `script.js`, etc.) directly from your computer.

---

## Option 2: Use GitHub Pages with GoDaddy Domain (Free Hosting)

If you don't have paid hosting, this is the best option. GitHub hosts your site for free, and GoDaddy just points the name to it.

### Step 1: Enable GitHub Pages
1.  Go to your **GitHub Repository**.
2.  Click **Settings** > **Pages** (sidebar).
3.  Under **Build and deployment**:
    *   **Source:** `Deploy from a branch`
    *   **Branch:** `main` (or `master`) / `/ (root)`
4.  Click **Save**.
5.  Under **Custom domain**, enter your domain (e.g., `www.jdrfarm.com`).
6.  Click **Save**. GitHub will check for DNS records.

### Step 2: Configure GoDaddy DNS
1.  Log in to **GoDaddy**.
2.  Go to **Domain Portfolio** > Select your domain.
3.  Click **DNS** > **Manage Zones** (or "Edit DNS").
4.  **Update the A Record:**
    *   **Type:** `A`
    *   **Name:** `@`
    *   **Value:** `185.199.108.153` (GitHub's IP)
    *   *Note: You can add 4 A records for redundancy: 185.199.108.153, 185.199.109.153, 185.199.110.153, 185.199.111.153*
5.  **Update the CNAME Record:**
    *   **Type:** `CNAME`
    *   **Name:** `www`
    *   **Value:** `yourusername.github.io` (Replace with your actual GitHub username + .github.io)
6.  Save changes.

### Step 3: Verify
1.  Wait 15-60 minutes for DNS to propagate.
2.  Go back to **GitHub Settings > Pages**.
3.  Check the **"Enforce HTTPS"** box (it might take time to become available).
4.  Visit your domain!

---

## Option 3: Automated FTP Deployment (Advanced)

If you have GoDaddy Hosting and want automatic updates when you push to GitHub, you can use **GitHub Actions**.

1.  Create a file in your repo: `.github/workflows/deploy.yml`
2.  Add this content:

```yaml
name: Deploy to GoDaddy
on:
  push:
    branches:
      - main
jobs:
  web-deploy:
    name: 🎉 Deploy
    runs-on: ubuntu-latest
    steps:
    - name: 🚚 Get latest code
      uses: actions/checkout@v3

    - name: 📂 Sync files
      uses: SamKirkland/FTP-Deploy-Action@v4.3.4
      with:
        server: ${{ secrets.FTP_SERVER }}
        username: ${{ secrets.FTP_USERNAME }}
        password: ${{ secrets.FTP_PASSWORD }}
```

3.  Go to GitHub Repo **Settings** > **Secrets and variables** > **Actions**.
4.  Add 3 secrets from your GoDaddy FTP details: `FTP_SERVER`, `FTP_USERNAME`, `FTP_PASSWORD`.
