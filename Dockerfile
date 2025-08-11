# Dockerfile for Map Dashboard application
# Builds a container image with all dependencies and runs the production server
# Uses a slim Python base image to keep the final image small.

FROM python:3.10-slim

WORKDIR /app

# Install system dependencies required by some geospatial libraries
RUN apt-get update && apt-get install -y --no-install-recommends \
    g++ \
    libspatialindex-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy application source
COPY . .

EXPOSE 5001

# Run the production server by default
CMD ["python", "run_production.py"]
