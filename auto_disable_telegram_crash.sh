#!/bin/bash

echo "🔧 Fixing Telegram API_ID crash..."

python3 - <<'PY'
from pathlib import Path

p = Path("shin_ai/config.py")
s = p.read_text()

old = 'TELEGRAM_API_ID = int(__import__("os").getenv("API_ID", _cfg.platform.telegram_api_id or 0))'

new = '''import os

_raw_api_id = os.getenv("API_ID") or _cfg.platform.telegram_api_id or "0"

try:
    TELEGRAM_API_ID = int(_raw_api_id)
except ValueError:
    TELEGRAM_API_ID = 0'''

if old in s:
    s = s.replace(old, new)
    p.write_text(s)
    print("✅ config.py fixed")
else:
    print("⚠️ Target line not found (maybe already fixed)")
PY

git add shin_ai/config.py
git commit -m "Auto disable telegram crash"
git push

echo "🚀 Done. Railway will rebuild."
