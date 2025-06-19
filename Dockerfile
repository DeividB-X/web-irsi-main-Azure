# Usa una imagen ligera de Python
FROM python:3.11-slim

# Evita archivos .pyc
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt ./

# Instala dependencias del sistema y el driver de SQL Server
RUN apt-get update && apt-get install -y \
    curl \
    gnupg2 \
    unixodbc \
    unixodbc-dev \
    gcc \
    g++ \
    build-essential

RUN curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft-prod.gpg \
 && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-prod.gpg] https://packages.microsoft.com/config/debian/11/prod bookworm main" > /etc/apt/sources.list.d/mssql-release.list \
 && apt-get update \
 && ACCEPT_EULA=Y apt-get install -y msodbcsql18 \
 && apt-get clean

 # Copia e instala las dependencias Python
RUN pip install --no-cache-dir -r requirements.txt

# Copia el resto del proyecto
COPY . .

# Comando para iniciar Flask (ajusta si usas otro archivo)
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "run:app"]
