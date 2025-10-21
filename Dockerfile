# Use a stable Python base image
FROM python:3.9-slim

# Prevents Python from writing pyc files and enables unbuffered output
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install gunicorn

# Copy the Django project
COPY . .

# Collect static files
RUN python manage.py collectstatic --noinput

# Expose internal Django app port
EXPOSE 8000

# Start Django with Gunicorn
CMD ["gunicorn", "todo-api.wsgi:application", "--bind", "0.0.0.0:8000"]
