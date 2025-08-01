#!/bin/bash

echo "🔨 Збірка кастомного n8n образу з Python..."

# Зупиняємо існуючий контейнер
echo "⏹️  Зупиняємо існуючий контейнер..."
docker stop n8n 2>/dev/null || true
docker rm n8n 2>/dev/null || true

# Збираємо новий образ
echo "🏗️  Збираємо Docker образ..."
docker build -t n8n-with-python .

# Запускаємо новий контейнер
echo "🚀 Запускаємо новий контейнер..."
docker run -d -it --rm \
  --name n8n \
  -p 80:5678 \
  -e N8N_SECURE_COOKIE=false \
  -e WEBHOOK_URL=https://n8n.es-tech.dev \
  -e N8N_METRICS=false \
  -e N8N_LOG_LEVEL=error \
  -e N8N_DIAGNOSTICS_ENABLED=false \
  -v n8n_data:/home/node/.n8n \
  n8n-with-python

echo "✅ Готово! n8n запущено з Python підтримкою"
echo "🌐 Доступний за адресою: https://n8n.es-tech.dev"
echo ""
echo "🔍 Перевірка встановлення Python:"
docker exec -it n8n python3 --version
echo ""
echo "📋 Python Code Node готовий до використання!"