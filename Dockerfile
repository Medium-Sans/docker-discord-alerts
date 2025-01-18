# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

# Create and switch to non-root user for security
RUN groupadd -r dockeruser && useradd -r -g dockeruser dockeruser

# Set the working directory in the container
WORKDIR /app

# Copy only requirements first to leverage Docker cache
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Set ownership to non-root user
RUN chown -R dockeruser:dockeruser /app

# Switch to non-root user
USER dockeruser

# Command to run the application
CMD ["python", "main.py"]
