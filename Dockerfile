# Use the official Python 3.11 slim image as the base
# Use a stable Python base image
FROM python:3.9-slim

# Set the working directory to /app
# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set work directory
WORKDIR /app

# Copy the requirements file into the container
# Copy dependencies
COPY requirements.txt .

# Install the Python dependencies
RUN pip install -r requirements.txt
# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire project into the container
# Copy project files
COPY . .

RUN python manage.py makemigrations

RUN python manage.py migrate

RUN python manage.py createsuperuser

# Collect static files
RUN python manage.py collectstatic --noinput

# Expose the port the Django app runs on
# Expose Django app port (used by nginx internally)
EXPOSE 8000

# Start the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
# Command to run the app
CMD ["gunicorn", "todo_api.wsgi:application", "--bind", "0.0.0.0:8000"]
