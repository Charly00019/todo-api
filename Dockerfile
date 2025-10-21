# Use a stable Python base image
FROM python:3.9-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set work directory
WORKDIR /app

# Copy dependencies
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Collect static files
RUN python manage.py collectstatic --noinput

# Expose Django app port (used by nginx internally)
EXPOSE 8000

# Command to run the app
CMD ["gunicorn", "todo_api.wsgi:application", "--bind", "0.0.0.0:8000"]
