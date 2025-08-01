# Налаштування FIN Flow на AWS

Покрокова інструкція для налаштування FIN Flow на AWS сервері з self-hosted n8n.io.

## Передумови

- AWS EC2 інстанс з Ubuntu/Debian
- Docker встановлений
- Self hosted n8n.io запущений в Docker контейнері

## Крок 1: Підготовка сервера

### Підключення до сервера
```bash
ssh -i your-key.pem ubuntu@your-server-ip
sudo su
```

### Перевірка існуючого n8n
```bash
docker ps
# Переконайтеся, що n8n запущений
```

## Крок 2: Створення робочої директорії

```bash
mkdir -p /opt/n8n-setup
cd /opt/n8n-setup
```

## Крок 3: Створення файлів проекту

### Створення build-and-run.sh
```bash
cat > build-and-run.sh << 'EOF'
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
  -p 80:5678 \
  -e N8N_SECURE_COOKIE=false \
  -e WEBHOOK_URL=https://your_domain \
  -v n8n_data:/home/node/.n8n \
  n8n-custom

echo "✅ Готово! Self hosted n8n запущено"
echo "🌐 Доступний за адресою: https://your_domain"
echo ""
echo "📋 Code Node готовий до використання!"
EOF

chmod +x build-and-run.sh
```

### Створення Dockerfile
```bash
cat > Dockerfile << 'EOF'
FROM docker.n8n.io/n8nio/n8n:latest

USER node

RUN n8n --version
EOF
```

### Створення FIN Flow.json
```bash
# Скопіюйте вміст FIN Flow.json з проекту
# або створіть файл вручну через n8n UI
```

## Крок 4: Збірка та запуск n8n

### Запуск скрипта збірки
```bash
./build-and-run.sh
```

### Перевірка роботи
```bash
# Перевірте, що контейнер запущений
docker ps

# Перевірте логи
docker logs n8n --tail 20

# Перевірте доступність n8n
curl -I https://your_domain
```

## Крок 5: Налаштування Dropbox

### Створення Dropbox App
1. Перейдіть до [Dropbox Developer Console](https://www.dropbox.com/developers)
2. Створіть новий App
3. Налаштуйте OAuth2 credentials
4. Скопіюйте App Key та App Secret

### Створення папок на Dropbox
```bash
# Створіть наступні папки в корені Dropbox:
# /Excel_input - для вхідних XLSX файлів
# /Invoices - для пошуку інвойсів  
# /Parsing_excel_results - для результатів парсингу
# /Sorted_invoices_YYYY-MM-DD - створюється автоматично для відсортованих файлів
```

**📋 Детальна інструкція по налаштуванню папок:** [DROPBOX-SETUP.md](DROPBOX-SETUP.md)

## Крок 6: Імпорт воркфлоу в n8n

### Відкрийте n8n UI
```bash
# Перейдіть до n8n в браузері
https://your_domain
```

### Імпорт воркфлоу
1. Натисніть "Import from file"
2. Виберіть файл `FIN Flow.json`
3. Воркфлоу буде імпортовано з готовим кодом

### Налаштування credentials
1. Перейдіть до Settings > Credentials
2. Додайте новий Dropbox OAuth2 credential
3. Введіть App Key та App Secret
4. Авторизуйтеся через Dropbox

## Крок 7: Налаштування воркфлоу

### Перевірка нод
Воркфлоу містить наступні основні ноди:
- **Manual Trigger** - запуск воркфлоу
- **Get excel file name** - отримання списку файлів з `/Excel_input`
- **Download a excel file** - завантаження XLSX файлу
- **Parse XLSX** - парсинг даних
- **Search using FIN/ALT number** - пошук інвойсів в Dropbox
- **Filter only found ALT invoices** - фільтрація тільки знайдених інвойсів
- **Merge FIN and ALT data** - об'єднання результатів
- **Move invoice files to sorted folder** - переміщення знайдених файлів
- **Convert data to excel file** - конвертація в XLSX
- **Upload excel file with results** - завантаження результату в `/Parsing_excel_results`

### Налаштування Dropbox нод
Для кожної Dropbox ноди:
1. Виберіть створений credential
2. Перевірте шляхи до папок
3. Налаштуйте фільтри та параметри пошуку

## Крок 8: Тестування

### Підготовка тестових файлів
1. Розмістіть XLSX файл в папці `/Excel_input` на Dropbox
2. Розмістіть кілька інвойсів в папці `/Invoices` на Dropbox
3. Переконайтеся, що назви файлів містять FIN або альтернативні номери

### Запуск тесту
1. Активуйте воркфлоу в n8n UI
2. Натисніть "Execute workflow"
3. Перевірте результати в Execution Log

### Перевірка результатів
1. Перевірте папку `/Parsing_excel_results` на Dropbox
2. Знайдіть створений Excel файл з результатами
3. Перевірте папку `/Sorted_invoices_YYYY-MM-DD` - там будуть скопійовані знайдені файли
4. Перевірте правильність статусів OK/NOK

## Крок 9: Налаштування для production

## Troubleshooting

### Проблема: "Python Code node not found"
- Переконайтеся, що використовується n8n версії 1.103.2+
- Перевірте, що Python Code node доступний в списку нод

### Проблема: "No data rows found"
- Перевірте структуру XLSX файлу
- Переконайтеся, що дані не починаються з перших 5 рядків

### Проблема: "Invalid shared string index"
- Файл може мати пошкоджену структуру
- Спробуйте зберегти файл заново в Excel

### Проблема: Dropbox помилки
- Перевірте OAuth2 credentials
- Переконайтеся, що папки `/Excel_input`, `/Invoices`, `/Parsing_excel_results` існують
- Перевірте права доступу до файлів

### Проблема: Файли не копіюються
- Переконайтеся, що знайдені файли існують в `/Invoices`
- Перевірте правильність шляхів у `pathDisplay`

### Проблема: "Docker build failed"
- Перевірте доступ до інтернету
- Переконайтеся, що Docker встановлений
- Спробуйте очистити Docker cache: `docker system prune -a`

## Переваги цього підходу

✅ **Мінімалізм** - встановлює тільки Python3, без зайвих бібліотек  
✅ **Швидкість** - швидка збірка Docker образу  
✅ **Надійність** - використовує стандартну бібліотеку Python  
✅ **Безпека** - не використовує зовнішні сервіси  
✅ **Гнучкість** - легко модифікувати код  
✅ **Конфіденційність** - обробляє дані локально  
✅ **Автоматизація** - повний цикл від завантаження до експорту  

## Підтримка

Для питань та проблем:
1. Перевірте логи n8n: `docker logs n8n --tail 100`
2. Перевірте логи Docker: `docker logs n8n 2>&1 | grep -i error`
3. Додайте діагностичні print statements в Python код
4. Перевірте структуру XLSX файлу та Dropbox папок 