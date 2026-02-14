FROM python:3.11-slim

# Install pipenv
RUN pip install --upgrade pip && pip install pipenv

WORKDIR /app

# Copy Pipfile and lock file
COPY Pipfile Pipfile.lock ./

# Install dependencies globally
RUN pipenv install --system --deploy --ignore-pipfile

# Copy all project files
COPY . .

# Expose port (Railway uses $PORT)
EXPOSE 8000

# Default CMD (for blockchain app; can be overridden for client)
CMD ["gunicorn", "--bind", "0.0.0.0:$PORT", "blockchain.app:app"]
