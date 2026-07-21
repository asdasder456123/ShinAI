#!/bin/bash

echo "🔧 Fixing ShinAI dependencies..."

# إضافة المكتبات المطلوبة لو مش موجودة
grep -qxF "chromadb" requirements.txt || echo "chromadb" >> requirements.txt
grep -qxF "sentence-transformers" requirements.txt || echo "sentence-transformers" >> requirements.txt
grep -qxF "tgcrypto" requirements.txt || echo "tgcrypto" >> requirements.txt

# تشغيل Telegram
if [ -f config.yaml ]; then
    sed -i 's/enabled: false/enabled: true/' config.yaml
fi

echo "✅ Done"

git add requirements.txt config.yaml
git commit -m "Auto fix ShinAI dependencies and config" || true
git push origin main

echo "🚀 Uploaded to GitHub. Railway will rebuild automatically."
