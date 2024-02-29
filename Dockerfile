FROM python:3.9-slim

RUN apt-get update && \
    apt-get install -y git curl cron libmagic-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt /requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY entrypoint.sh /entrypoint.sh
COPY backup.sh /backup.sh
COPY backup_script.py /backup_script.py

RUN chmod +x /entrypoint.sh /backup.sh

ENTRYPOINT ["/entrypoint.sh"]
