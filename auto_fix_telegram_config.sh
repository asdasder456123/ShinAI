#!/bin/bash

echo "🔧 Fixing Telegram config loader..."

python3 - <<'PY'
from pathlib import Path

p = Path("shin_ai/config.py")

if p.exists():
    s = p.read_text()

    s = s.replace(
        "TELEGRAM_API_ID = _cfg.platform.telegram_api_id",
        'TELEGRAM_API_ID = int(__import__("os").getenv("API_ID", _cfg.platform.telegram_api_id or 0))'
    )

    s = s.replace(
        "TELEGRAM_API_HASH = _cfg.platform.telegram_api_hash",
        'TELEGRAM_API_HASH = __import__("os").getenv("API_HASH", _cfg.platform.telegram_api_hash or "")'
    )

    p.write_text(s)
    print("✅ config.py fixed")
else:
    print("❌ config.py not found")
PY

git add shin_ai/config.py
git commit -m "Fix telegram env variables loading"
git push origin main

echo "🚀 Uploaded. Railway rebuild now."
