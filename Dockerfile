FROM python:3.11.9

WORKDIR /app

COPY . .

RUN pip install --no-cache-dir \
    fastapi==0.115.0 \
    uvicorn==0.30.6 \
    sqlalchemy==2.0.36 \
    psycopg2-binary==2.9.9 \
    pytest==8.3.2 \
    requests==2.32.3

CMD ["python", "main.py"]