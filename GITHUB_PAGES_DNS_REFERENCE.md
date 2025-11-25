# 📋 GitHub Pages DNS Quick Reference

Quick copy-paste reference for GoDaddy DNS configuration.

---

## 🎯 GitHub Pages IP Addresses

Use these **FOUR** A records:

```
185.199.108.153
185.199.109.153
185.199.110.153
185.199.111.153
```

---

## 📊 Complete DNS Configuration

### For jdrfarm.com on GoDaddy

| Type  | Name | Value | TTL | Notes |
|-------|------|-------|-----|-------|
| A     | @    | 185.199.108.153 | 600 | GitHub Pages IP #1 |
| A     | @    | 185.199.109.153 | 600 | GitHub Pages IP #2 |
| A     | @    | 185.199.110.153 | 600 | GitHub Pages IP #3 |
| A     | @    | 185.199.111.153 | 600 | GitHub Pages IP #4 |
| CNAME | www  | YOUR_USERNAME.github.io | 600 | Replace with your GitHub username |

**Important:** Replace `YOUR_USERNAME` with your actual GitHub username!

---

## 📝 Step-by-Step GoDaddy Entry

### A Records (Add 4 times)

**Record 1:**
```
Type: A
Name: @
Value: 185.199.108.153
TTL: 600
```

**Record 2:**
```
Type: A
Name: @
Value: 185.199.109.153
TTL: 600
```

**Record 3:**
```
Type: A
Name: @
Value: 185.199.110.153
TTL: 600
```

**Record 4:**
```
Type: A
Name: @
Value: 185.199.111.153
TTL: 600
```

### CNAME Record (Add 1 time)

```
Type: CNAME
Name: www
Value: [YOUR_GITHUB_USERNAME].github.io
TTL: 600
```

**Example:** If username is `johnsmith`, value is: `johnsmith.github.io`

---

## 🔍 How to Find Your GitHub Username

### Method 1: GitHub Website
1. Go to: https://github.com
2. Click your profile picture (top right)
3. Your username is shown below your name
4. Or look at URL: `https://github.com/YOUR_USERNAME`

### Method 2: From Repository URL
- Repository URL: `https://github.com/USERNAME/repository-name`
- First part after github.com is your username

---

## ✅ Verification Checklist

After adding DNS records:

- [ ] All 4 A records added with @ as name
- [ ] CNAME record added with www as name
- [ ] CNAME value uses YOUR GitHub username (not literal "YOUR_USERNAME")
- [ ] All TTL values set to 600
- [ ] Saved all changes in GoDaddy
- [ ] Waited 1-2 hours for DNS propagation

---

## 🧪 Test Your DNS

### Use DNS Checker

1. Go to: https://dnschecker.org
2. Enter: `jdrfarm.com`
3. Type: Select `A`
4. Click search
5. Should see: 185.199.108.153 (or other GitHub IPs)

### Use Command Line

**Windows (Command Prompt):**
```cmd
nslookup jdrfarm.com
```

**Mac/Linux (Terminal):**
```bash
dig jdrfarm.com
```

**Expected result:**
Should show GitHub Pages IP addresses (185.199.108.153, etc.)

---

## ⚠️ Common Mistakes

### ❌ Wrong CNAME Value

**Wrong:**
```
www → jdrfarm.com
www → github.io
www → YOUR_USERNAME.github.io (literal text)
```

**Correct:**
```
www → youractualusername.github.io
```

### ❌ Forgot to Add All 4 A Records

- You need ALL FOUR A records
- Not just one
- GitHub uses all 4 for redundancy and performance

### ❌ Wrong Name for A Records

**Wrong:**
```
Name: jdrfarm.com
Name: www
Name: (empty)
```

**Correct:**
```
Name: @
```

### ❌ Added CNAME Instead of A for Root

**Wrong:**
```
Type: CNAME
Name: @
Value: anything
```

**Correct:**
```
Type: A (not CNAME!)
Name: @
Value: GitHub IP address
```

**Note:** Root domain (@) cannot use CNAME, must use A records!

---

## 🔄 If You Need to Change Later

### Switching from GoDaddy to GitHub Pages

1. **Delete old A records:**
   - Delete any A records pointing to GoDaddy IPs
   - Usually: 160.153.x.x or similar

2. **Add GitHub A records:**
   - Add all 4 GitHub IPs as shown above

3. **Update CNAME record:**
   - Change www to point to: yourusername.github.io

### Switching Back to GoDaddy (if needed)

1. **Delete GitHub A records:**
   - Delete all 4 GitHub IPs

2. **Add GoDaddy A record:**
   - Contact GoDaddy support for correct IP
   - Usually provided in hosting control panel

---

## 📞 Support

### GitHub Pages Documentation
- **Custom Domains:** https://docs.github.com/pages/configuring-a-custom-domain-for-your-github-pages-site
- **Troubleshooting:** https://docs.github.com/pages/configuring-a-custom-domain-for-your-github-pages-site/troubleshooting-custom-domains-and-github-pages

### GoDaddy Support
- **DNS Help:** https://www.godaddy.com/help/manage-dns-680
- **Phone:** 1-480-505-8877
- **Chat:** Login to GoDaddy account

---

## 💾 Save This Information

**Recommended:** Take a screenshot or print this page for future reference.

**Your DNS Configuration Date:** ________________

**GitHub Username:** ________________

**Domain:** jdrfarm.com

**Status:**
- [ ] DNS configured
- [ ] DNS propagated
- [ ] Site live
- [ ] HTTPS working

---

## 🎯 Quick Copy-Paste

### For GoDaddy DNS Interface

**Copy these values one at a time:**

```
185.199.108.153
185.199.109.153
185.199.110.153
185.199.111.153
```

**For CNAME (remember to replace USERNAME):**
```
[YOUR_USERNAME].github.io
```

---

**Back to main guide:** [`GITHUB_PAGES_SETUP.md`](GITHUB_PAGES_SETUP.md)
