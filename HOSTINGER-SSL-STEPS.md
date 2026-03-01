# Fix "Your connection isn't private" (SSL) for jdrfarm.com on Hostinger

The SSL error **NET::ERR_CERT_COMMON_NAME_INVALID** can only be fixed **inside your Hostinger account**. Follow these steps there.

---

## 1. Point the domain to Hostinger

1. Log in at [hostinger.com](https://www.hostinger.com) → **hPanel**.
2. Go to **Domains** → select **jdrfarm.com**.
3. **If the domain is at Hostinger:** Use the nameservers shown (e.g. `ns1.dns-parking.com`, `ns2.dns-parking.com`).
4. **If the domain is at another registrar:** Either change nameservers to Hostinger’s, or add an **A record** for `jdrfarm.com` (and `www` if you use it) pointing to your Hostinger server IP. Remove any other A records for the same names.
5. Wait **up to 24 hours** for DNS to propagate.

---

## 2. Install or refresh SSL (AutoSSL)

1. In hPanel go to **Hosting** → your plan → **Manage**.
2. Open **Security** → **SSL** (or **SSL/TLS Status**).
3. Find **jdrfarm.com** and **www.jdrfarm.com** in the list.
4. Click **AutoSSL** (or **Install SSL**) for **both** and wait until it says installed.
5. If SSL was already installed but you still see the error: **Delete** the existing SSL for this domain, then run **AutoSSL** again.

---

## 3. Keep CAA records (if using Hostinger nameservers)

Do **not** delete the default **CAA** records in the DNS zone. That can block SSL from being issued.

---

## 4. Upload your website files

Upload the contents of the **jdrfarm-website** folder (including the new `.htaccess`) to your hosting **public_html** (or the folder assigned to jdrfarm.com). The `.htaccess` will force HTTPS and redirect www to non-www once SSL is working.

---

## 5. Test

- Wait 5–15 minutes after SSL shows as installed.
- Open **https://jdrfarm.com** in a **private/incognito** window.
- If it still shows the error, clear browser cache and try again.

---

**Summary:** The certificate is fixed only in Hostinger (domain pointing + AutoSSL for jdrfarm.com and www). This project’s `.htaccess` and canonical URL are set so the site behaves correctly after SSL is fixed.
