# Safe Prompt Checklist

Use this before submitting prompts to AI tools:

---

## Do not include:

- Passwords
- API keys or tokens
- Private keys (SSH/PEM)
- Full payment card numbers or CVV
- Passport / National Insurance / SSN numbers
- Internal URLs with credentials
- Production hostnames or DB names

---

## Replace with:

- Fake data
- Masked values (`****`)
- Generic labels (`CLIENT_A`, `PROJECT_X`)

---

## Final self-check:

If this prompt leaked publicly tomorrow…

Would I be in trouble?

If yes → Do NOT send.
