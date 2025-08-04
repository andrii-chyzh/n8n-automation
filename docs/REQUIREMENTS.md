# 📋 Вимоги для роботи проекту

Цей документ описує всі необхідні компоненти та вимоги для запуску проекту FIN Invoice Checking and Sorting.

## 🖥️ AWS Infrastructure

### EC2 Instance
- **Тип:** t3.large
- **CPU:** 2 vCPU
- **RAM:** 8 GB
- **Storage:** 100 GB gp3 (General Purpose SSD)
- **Вартість:** $60-80/місяць

### Додаткові AWS сервіси
- **EBS Volume:** 100 GB gp3 для зберігання даних
- **Security Groups:** Налаштування портів (80, 443, 22)
- **Elastic IP:** Фіксована IP адреса (опціонально)
- **CloudWatch:** Моніторинг ресурсів

## 🌐 Domain та SSL

### Domain Name
- **Тип:** Будь-який домен (.com, .dev, .io, тощо)
- **Вартість:** $5-10/рік (або $0 якщо є власний домен)
- **Призначення:** Доступ до n8n через HTTPS

### SSL Certificate
- **Тип:** Let's Encrypt (безкоштовно)
- **Автоматичне оновлення:** Кожні 90 днів

## 🔧 Software Requirements

### n8n.io
- **Версія:** 1.103.2 або новіша
- **Тип:** Self-hosted
- **Вартість:** $0 (open source)
- **Порти:** 5678 (за замовчуванням)

### Docker
- **Версія:** 20.10 або новіша
- **Тип:** Container runtime
- **Вартість:** $0

### Operating System
- **Тип:** Ubuntu 20.04 LTS або новіша
- **Архітектура:** x86_64
- **Вартість:** $0

## ☁️ Cloud Services

### Dropbox
- **Тип:** Personal або Business
- **Безкоштовний план:** 2 GB
- **Платний план:** $10/місяць (2 TB)
- **Призначення:** Зберігання XLSX файлів та результатів

### Gmail (Google Account)
- **Тип:** Будь-який Google акаунт
- **Вартість:** $0
- **Призначення:** Email повідомлення про завершення workflow

## 📊 Resource Requirements

### Memory Usage
- **n8n:** 2-4 GB
- **Docker:** 1-2 GB
- **OS:** 1-2 GB
- **Buffer:** 2-4 GB
- **Загалом:** 8 GB (мінімум)

### CPU Usage
- **n8n processing:** 1-2 vCPU
- **Docker:** 0.5-1 vCPU
- **OS:** 0.5 vCPU
- **Загалом:** 2 vCPU (мінімум)

### Storage Usage
- **n8n data:** 10-20 GB
- **Docker images:** 5-10 GB
- **Logs:** 5-10 GB
- **Temporary files:** 10-20 GB
- **OS:** 10-20 GB
- **Загалом:** 50-100 GB

## 💰 Вартість

### Щомісячні витрати:
- **AWS EC2 (t3.large):** $60-80
- **Domain:** $0.5-1 (розраховано на рік)
- **Dropbox (якщо потрібно більше 2GB):** $10
- **Gmail:** $0
- **n8n:** $0

### Загальна вартість:
- **Мінімальна:** $60-80/місяць
- **З розширеним Dropbox:** $70-90/місяць

## 🔒 Security Requirements

### Network Security
- **HTTPS:** Обов'язково
- **Firewall:** Налаштування Security Groups
- **SSH:** Тільки ключі (без паролів)

### Access Control
- **n8n credentials:** Безпечне зберігання
- **Dropbox OAuth2:** Налаштування в n8n
- **Gmail credentials:** Налаштування в n8n

## 📈 Scalability

### Auto Scaling
- **CloudWatch:** Моніторинг ресурсів
- **Alerts:** Повідомлення про високе навантаження
- **Backup:** EBS Snapshots

### Performance Optimization
- **Rate Limiting:** Вбудовано в workflow
- **Batch Processing:** Обробка файлів групами
- **Memory Management:** Оптимізація Docker

## 🚀 Deployment

### Prerequisites
1. AWS Account з кредитною карткою
2. Domain name (опціонально)
3. Dropbox акаунт
4. Google акаунт

### Setup Time
- **AWS налаштування:** 2-3 години
- **n8n встановлення:** 1-2 години
- **Workflow налаштування:** 1 година
- **Тестування:** 2-3 години

**Загальний час:** 6-9 годин

## 📝 Notes

- Всі ціни наведені для регіону us-east-1
- Вартість може змінюватися залежно від регіону
- Рекомендується почати з мінімальної конфігурації
- Можна масштабувати за потреби 