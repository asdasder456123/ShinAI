#!/bin/bash

echo "🔧 Preparing Gemini auto config..."

mkdir -p data

# إنشاء ملف تجريبي لو مش موجود (بدون مفاتيح حقيقية)
if [ ! -f data/gemini_keys.json ]; then
cat > data/gemini_keys.json <<'JSON'
{
  "GEMINI_API_KEY1": "YOUR_GEMINI_KEY_HERE"
}
JSON
fi

# منع رفع المفاتيح الحقيقية على GitHub
grep -qxF "data/gemini_keys.json" .gitignore 2>/dev/null || echo "data/gemini_keys.json" >> .gitignore

git add .gitignore data/gemini_keys.json
git commit -m "Add Gemini config structure" || true
git push origin main

echo "✅ Done. Add your Gemini key in Railway Variables."
