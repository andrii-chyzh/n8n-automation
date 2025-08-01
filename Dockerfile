FROM docker.n8n.io/n8nio/n8n:latest

# n8n Python Code Node використовує Pyodide (WebAssembly Python)
# і не потребує встановлення Python на сервері
# Всі Python операції виконуються в браузері

USER node

# Перевіряємо, що n8n працює
RUN n8n --version