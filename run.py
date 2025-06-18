import os
from app import create_app

app = create_app()

if __name__ == "__main__":
    print("DATABASE_URL:", os.getenv("DATABASE_URL"))
    print("SECRET_KEY:", os.getenv("SECRET_KEY") is not None)
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port)
