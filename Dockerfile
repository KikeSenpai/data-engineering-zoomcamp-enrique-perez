FROM python:3.9

RUN pip install pandas sqlalchemy psycopg2

WORKDIR /app
COPY ingestion.py ingestion.py

ENTRYPOINT [ "python", "ingestion.py" ]
