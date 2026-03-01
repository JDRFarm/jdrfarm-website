# Point jdrfarm.com (GoDaddy) to Hostinger – Step by Step

Do this **while logged into GoDaddy**. This will fix "Domain is not working" and allow SSL to work.

---

## Before you start: get Hostinger nameservers

1. In **Hostinger**, go to **Websites** → find **jdrfarm.com**.
2. Click **"Check guide"** under the red "Domain is not working" message.
3. On the guide page, **copy the two nameserver addresses** Hostinger shows (e.g. `ns1.dns-parking.com` and `ns2.dns-parking.com`, or similar – use whatever the guide shows).
4. Keep them ready for the GoDaddy steps below.

---

## In GoDaddy – change nameservers

### Step 1: Open your domains
- You are already logged in at **godaddy.com**.
- Click **"My Products"** (top right or in the account menu).
- Under **Domains**, find **jdrfarm.com**.

### Step 2: Open DNS for jdrfarm.com
- Click **"DNS"** next to **jdrfarm.com** (or click the domain, then **Manage DNS** / **DNS**).
- You should see the **DNS Management** page for jdrfarm.com.

### Step 3: Change nameservers
- Scroll to the **"Nameservers"** section.
- Click **"Change"** (or **"Manage"** next to Nameservers).

### Step 4: Use custom nameservers
- Choose **"Custom"** (or **"I'll use my own nameservers"** / **"Enter my own nameservers (advanced)"**).
- You will see two (or more) nameserver fields.
- **Delete** any existing values in those fields.
- **Enter the two nameservers from Hostinger's Check guide:**
  - Nameserver 1: (paste first one from Hostinger, e.g. `ns1.dns-parking.com`)
  - Nameserver 2: (paste second one from Hostinger, e.g. `ns2.dns-parking.com`)
- If Hostinger gave only two, leave any extra GoDaddy fields **empty** or remove them.

### Step 5: Save
- Click **"Save"** (or **"Update"**).
- If GoDaddy asks **"I consent to update name servers"**, check the box and confirm.
- If it sends a verification email, open it and confirm.

---

## After saving

- **Wait up to 24 hours** (often 1–4 hours) for DNS to update.
- In Hostinger, the red **"Domain is not working"** should disappear.
- **SSL will turn on automatically** for jdrfarm.com; then **https://jdrfarm.com** should load without the "connection isn't private" error.

---

## Quick reference – common Hostinger nameservers

If the Hostinger "Check guide" does not show nameservers clearly, try these (Hostinger often uses):

| # | Nameserver        |
|---|-------------------|
| 1 | ns1.dns-parking.com |
| 2 | ns2.dns-parking.com |

**Best:** Always use the two nameservers shown in Hostinger’s **Check guide** for your plan.
