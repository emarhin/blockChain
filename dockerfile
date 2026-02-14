FROM python:3.11-slim

# Upgrade pip
RUN pip install --upgrade pip

WORKDIR /app

# Copy dependencies
COPY requirements.txt ./

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy all project files
COPY . .

# Expose port (Railway will use $PORT)
EXPOSE 8000

# Default CMD (for blockchain app; can be overridden for client)
CMD ["gunicorn", "--bind", "0.0.0.0:$PORT", "blockchain.app:app"]
