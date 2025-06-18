# Imagen base oficial de Python
FROM python:3.11-slim

# Variables de entorno necesarias
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Crear y usar directorio de trabajo
WORKDIR /app

# Copiar archivos del proyecto al contenedor
COPY . .

# Instalar dependencias del sistema necesarias para pyodbc y ODBC Driver 18
RUN apt-get update && apt-get install -y \
    curl \
    gnupg2 \
    unixodbc \
    unixodbc-dev \
    gcc \
    g++ \
    libssl-dev \
    libffi-dev \
    libpq-dev

# Agregar la clave pública de Microsoft (nuevo método)
RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/microsoft.gpg

# Agregar repositorio de Microsoft firmado
RUN echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/microsoft.gpg] https://packages.microsoft.com/debian/12/prod bookworm main" > /etc/apt/sources.list.d/mssql-release.list

# Instalar controlador msodbcsql18
RUN apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql18 && apt-get clean

# Instalar dependencias de Python
RUN pip install --