FROM docker.n8n.io/n8nio/n8n:latest

# Встановлюємо тільки Python3 (без pip та зайвих бібліотек)
USER root
RUN apk update && apk add --no-cache \
    python3 \
    && rm -rf /var/cache/apk/*

# Переключаємося назад на користувача node
USER node

# Перевіряємо встановлення Python
RUN python3 --version