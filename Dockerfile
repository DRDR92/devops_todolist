ARG PYTHON_VERSION=3.10

# ---------- BUILD STAGE ----------
FROM python:${PYTHON_VERSION} AS builder

ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install --prefix=/install -r requirements.txt

COPY . .


# ---------- RUN STAGE ----------
FROM python:${PYTHON_VERSION}-slim

ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Устанавливаем MySQL Server
RUN apt-get update && \
    apt-get install -y default-mysql-server && \
    rm -rf /var/lib/apt/lists/*

# Копируем зависимости
COPY --from=builder /install /usr/local

# Копируем код
COPY . .


EXPOSE 8080

ENTRYPOINT ["python", "app.py"]
