FROM python:3.9-slim
WORKDIR /app
# Install requirements
COPY requirements.txt .
RUN pip install -r requirements.txt --no-cache-dir
COPY service/ ./service/
# Create non-root user
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]
