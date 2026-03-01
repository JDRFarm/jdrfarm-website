# Simple Fix for jdrfarm.com (Beginner-Friendly)

You have a website (jdrfarm.com) and a "connection not private" / SSL error. You don't need to understand everything – just do one of the options below.

---

## Option A: Ask Hostinger to Fix It (Easiest – Recommended)

You don't have to fix it yourself. Hostinger can do it for you.

1. **Log in to Hostinger**  
   Go to: https://www.hostinger.com and sign in.

2. **Open support**  
   Click **"Ask"** (top right) or the **chat/support** icon (often bottom-right).

3. **Send this message** (copy and paste):

   ```
   Hi, my website jdrfarm.com shows "Your connection isn't private" and 
   NET::ERR_CERT_COMMON_NAME_INVALID. The domain is on GoDaddy and I have 
   already set the nameservers. Please help me fix the SSL so https://jdrfarm.com 
   works. Thank you.
   ```

4. **Wait for their reply**  
   They will either fix it from their side or tell you exactly what to click (step by step). You can ask them to explain in simple words – they are used to helping beginners.

---

## Option B: Do Two Things Yourself (If You Want to Try)

Only do this if you want to try fixing it yourself. Otherwise use Option A.

### Thing 1: Make sure GoDaddy points to Hostinger

1. Log in to **GoDaddy** (godaddy.com).
2. Go to **My Products** → find **jdrfarm.com** → click **DNS** or **Manage DNS**.
3. Find **Nameservers** → click **Change**.
4. Choose **Custom** and enter these two (one per line):
   - `ns1.dns-parking.com`
   - `ns2.dns-parking.com`
5. Click **Save**.

### Thing 2: Wait and ask Hostinger to check

1. **Wait 24 hours** (do nothing – just wait).
2. Log in to **Hostinger** → **Websites** → find **jdrfarm.com**.
3. If it still says "Domain is not working", click **"Check guide"** and follow the short steps there.
4. Or open **Ask** / chat and say: "Domain still not working for jdrfarm.com, please help."

---

## What You Don't Need to Do

- You don't need to learn website design to fix SSL.
- You don't need to find a "Manage" or "SSL" button – for your type of hosting, SSL turns on automatically once the domain is set up correctly.
- You don't need to change any code or files on your computer for this.

---

## Summary

- **Easiest:** Use **Option A** – contact Hostinger support with the message above. They will fix it or guide you in very simple steps.
- **If you want to try yourself:** Use **Option B** – set the two nameservers in GoDaddy, wait 24 hours, then ask Hostinger if it still doesn’t work.

You’re not supposed to understand everything. Getting help from Hostinger is normal and the quickest way to fix it.
