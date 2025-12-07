<p align="center">
  <img src="https://raw.githubusercontent.com/RichardBarron27/red-specter-offensive-framework/main/assets/red-specter-logo.png" alt="Red Specter Logo" width="200">
</p>

<br>

# 🛰️ Red Specter – AI Breach Monitor
![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20Kali-purple)
![Language](https://img.shields.io/badge/Language-Bash-blue)
![Status](https://img.shields.io/badge/Status-WIP-orange)
![License](https://img.shields.io/badge/License-TBD-lightgrey)

> Powered by Vigil — Offense-Driven Defense  
> Defensive log watcher for AI-driven data exposure prevention

**A lightweight Bash tool that continuously monitors an AI prompt log or text stream for
dangerous data leakage** — including credentials, keys, payment details, personal IDs, and
internal organisation identifiers.

Created by **Richard B (Red Specter)**

---

## 🧩 Why this tool?

AI prompts are often **stored in remote systems**.
A huge number of breaches have happened because:

- Developers pasted secrets into AI tools
- Logs containing sensitive data are piped into chatbots
- Staging/production credentials accidentally leak in debugging prompts

This tool provides a **local tripwire**:

> “If something sensitive enters the AI pipeline — alert immediately.”

---

## 🚀 Features

| Feature | Benefit |
|---|---|
| 🔍 Real-time monitoring | Watches files or stdin streams |
| 🧠 Pattern-based detection | Credentials, tokens, PII, IDs |
| 📝 Structured incident log | UTC timestamp + trigger + snippet |
| 🧪 Lab demonstration friendly | Show “hidden AI breaches” to clients/users |
| 🪶 Lightweight | Pure Bash, no external dependencies |

---

## 🛠 Installation

```bash
git clone https://github.com/RichardBarron27/redspecter-ai-breach-monitor.git
cd redspecter-ai-breach-monitor
chmod +x rs_ai_breach_monitor.sh
🔧 Usage
Monitor a log file that updates continuously
./rs_ai_breach_monitor.sh /var/log/ai_proxy.log

Pipe a live stream (best method)
tail -F /var/log/ai_proxy.log | ./rs_ai_breach_monitor.sh -

Scan an exported chat once
cat ai_chat_export.txt | ./rs_ai_breach_monitor.sh -

🧪 Quick demo
echo "Here is a test password: hunter2" | ./rs_ai_breach_monitor.sh -


You should see:

==== [AI BREACH MONITOR ALERT] ====
Time: 2025-12-06 08:13:30
Pattern: password
Line: Here is a test password: hunter2
===================================

🔎 Detected Patterns

Built-in monitored terms:

password, passwd

apikey, api_key, secret, token, bearer

Private key formats
e.g. BEGIN RSA PRIVATE KEY, BEGIN OPENSSH PRIVATE KEY

Payment card info
e.g. credit card, cvv

Personal identifiers
e.g. national insurance, ninumber, passport, ssn

Banking
e.g. sort code, iban, ifsc

Customer IDs

$ORG_NAME → defaults to REDSPECTER

Extend these inside the script or using config (in roadmap).

See: patterns.md

📝 Included Templates
File	Purpose
templates/ai_breach_log_template.md	Full incident record
templates/ai_safe_prompt_checklist.md	Prompt safety guardrails
templates/ai_breach_response_playbook.md	Defensive IR steps

These turn alerts into real action.

📂 Log Output

All alerts go to:

~/.redspecter_ai_breach_monitor.log


Format:

[2025-12-06T08:13:30Z] PATTERN="password" LINE="Here is a test password: hunter2"


Perfect for:

SIEM ingestion

Incident reports

Evidence Collector import

⚖️ Rules of Engagement (ROE)

Only use on logs you are authorised to analyse

Treat logs as sensitive — rotate exposed keys immediately

Follow client SoW and legal boundaries

Purple Team mindset: Offense-driven Defense

🧭 Roadmap

External pattern config (patterns.conf)

Severity flags per rule

Desktop notifications (notify-send)

HTML/Markdown incident report generator

Optional webhook/slack alerting

Evidence Collector integration

❤️ Support Red Specter

If these tools help you, you can support future development:

☕ Buy me a coffee: https://www.buymeacoffee.com/redspecter

💼 PayPal: https://paypal.me/richardbarron1747

Your support helps me keep improving Red Specter and building new tools. Thank you!

Vigil stands watch.

When your AI tools slip — we catch it first.
Stay Spectral. 👁‍🗨

Notice for Users: If you cloned this and found it useful, please consider starring the repo! Stars help with visibility and let me know which projects to maintain.
