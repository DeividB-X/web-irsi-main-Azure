import os
from sqlalchemy import create_engine
from sqlalchemy.exc import SQLAlchemyError

# Asegúrate de que la variable de entorno esté bien cargada antes de ejecutar esto.
db_url = os.getenv('DATABASE_URL')

print("Intentando conectar con:", db_url)

try:
    engine = create_engine(db_url)
    with engine.connect() as conn:
        result = conn.execute("SELECT 1")
        print("✅ Conexión exitosa:", result.scalar())
except SQLAlchemyError as e:
    print("❌ Error al conectar:", e)

