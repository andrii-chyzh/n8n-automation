#!/bin/bash

echo "🔨 Збірка n8n образу..."

# Зупиняємо існуючий контейнер
echo "⏹️  Зупиняємо існуючий контейнер..."
docker stop n8n 2>/dev/null || true
docker rm n8n 2>/dev/null || true

# Збираємо новий образ
echo "🏗️  Збираємо Docker образ..."
docker build -t n8n-custom .

# Запускаємо новий контейнер
echo "🚀 Запускаємо новий контейнер..."
docker run -d -it --rm \
  --name n8n \
  --memory=6g \
  --memory-swap=8g \
  -p 80:5678 \
  -e N8N_SECURE_COOKIE=false \
  -e WEBHOOK_URL=https://your_domain \
  -e N8N_METRICS=false \
  -e N8N_LOG_LEVEL=error \
  -e N8N_DIAGNOSTICS_ENABLED=false \
  -v n8n_data:/home/node/.n8n \
  n8n-custom

echo "✅ Готово! n8n запущено"
echo "�� Доступний за адресою: https://your_domain"