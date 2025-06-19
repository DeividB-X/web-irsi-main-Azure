FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Copia las dependencias
COPY requirements.txt ./

# Instala dependencias del sistema y el driver ODBC usando repo Ubuntu
RUN apt-get update && apt-get install -y \
      curl \
      gnupg2 \
      unixodbc \
      unixodbc-dev \
      gcc \
      g++ \
      build-essential

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
 && curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list \
 && apt-get update \
 && ACCEPT_EULA=Y apt-get install -y msodbcsql18 \
 && rm -rf /var/lib/apt/lists/*

# Instala paquetes Python
RUN pip install --no-cache-dir -r requirements.txt

# Copia tu app
COPY . .

# Comando de inicio
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "run:app"]
