# Imagen base oficial de Python
FROM python:3.11-slim

# Instalar dependencias del sistema necesarias para pyodbc y el driver ODBC 18
RUN apt-get update && apt-get install -y \
    curl \
    gnupg2 \
    unixodbc \
    unixodbc-dev \
    gcc \
    g++ \
    libssl-dev \
    libffi-dev \
    libpq-dev \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/12/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql18 \
    && apt-get clean

# Crear directorio de trabajo
WORKDIR /app

# Copiar todos los archivos del proyecto al contenedor
COPY . .

# Instalar dependencias Python
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Variables de entorno para producción
ENV FLASK_APP=run.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_ENV=production

# Puerto de exposición (Render usa 5000 por defecto)
EXPOSE 5000

# Comando para iniciar la aplicación Flask
CMD ["python", "run.py"]