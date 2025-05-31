# CUDA-enabled base image
FROM nvidia/cuda:12.3.2-runtime-ubuntu22.04

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y \
        git \
        curl \
        wget \
        ca-certificates \
        python3 \
        python3-pip \
        python3-venv && \
    rm -rf /var/lib/apt/lists/*

# Optional: symlink python3 to python
RUN ln -s /usr/bin/python3 /usr/bin/python

# Install Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

# Add Ollama to PATH (assumes /root/.ollama/bin or similar)
ENV PATH="/root/.ollama/bin:$PATH"

# Preload model or verify install
RUN ollama run llama3.2 --help || true

# Copy Python dependencies
COPY lib/homie/requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy bot code
COPY lib/homie ./lib/homie

# Create mount points
RUN mkdir -p /app/logs /app/db

# Start Ollama + the bot
CMD ["sh", "-c", "ollama serve & sleep 3 && python lib/homie/homie.py"]