#!/bin/bash

echo "🔧 Fixing Telegram env loading..."

mkdir -p scripts

python3 - <<'PY'
from pathlib import Path

p = Path("shin_ai/core/client.py")

if p.exists():
    s = p.read_text()

    s = s.replace(
        'api_id="YOUR_API_ID"',
        'api_id=int(__import__("os").getenv("API_ID","0"))'
    )

    s = s.replace(
        'api_hash="YOUR_API_HASH"',
        'api_hash=__import__("os").getenv("API_HASH","")'
    )

    p.write_text(s)
    print("✅ client.py fixed")
else:
    print("❌ client.py not found")
PY

git add .
git commit -m "Auto fix telegram env variables"
git push origin main

echo "🚀 Done. Railway will rebuild."
