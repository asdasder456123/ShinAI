#!/bin/bash

echo "🔧 Fixing ShinAI missing environment..."

mkdir -p data

if [ ! -f data/gemini_keys.json ]; then
cat > data/gemini_keys.json <<JSON
{
  "GEMINI_API_KEY1": "PUT_YOUR_GEMINI_KEY_HERE"
}
JSON
echo "✅ Created gemini_keys.json"
fi

git add .
git commit -m "Auto create missing Gemini config" || true
git push

echo "🚀 Done. Railway will rebuild."
