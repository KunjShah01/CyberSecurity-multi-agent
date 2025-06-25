# Multi-stage Docker build for Security Multi-Agent System
# Stage 1: Build dependencies and compile requirements
FROM ubuntu:22.04 as builder

# Set build arguments
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION=1.0.0

# Add metadata labels
LABEL org.opencontainers.image.title="Security Multi-Agent System"
LABEL org.opencontainers.image.description="AI-powered cybersecurity threat intelligence platform"
LABEL org.opencontainers.image.version=${VERSION}
LABEL org.opencontainers.image.created=${BUILD_DATE}
LABEL org.opencontainers.image.revision=${VCS_REF}
LABEL org.opencontainers.image.source="https://github.com/yourusername/security-multi-agent"
LABEL org.opencontainers.image.vendor="Security Multi-Agent Team"
LABEL org.opencontainers.image.licenses="MIT"

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Update system and install security updates
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    python3.11 \
    python3.11-dev \
    python3.11-venv \
    python3-pip \
    build-essential \
    curl \
    git \
    ca-certificates \
    openssl \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/*

# Set working directory
WORKDIR /app

# Copy requirements files
COPY requirements.txt requirements-dev.txt ./

# Create virtual environment and install dependencies
RUN python3.11 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Upgrade pip and install wheel
RUN pip install --no-cache-dir --upgrade pip wheel setuptools

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Stage 2: Production image with enhanced security
FROM ubuntu:22.04 as production

# Set build arguments
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION=1.0.0

# Add metadata labels
LABEL org.opencontainers.image.title="Security Multi-Agent System"
LABEL org.opencontainers.image.description="AI-powered cybersecurity threat intelligence platform"
LABEL org.opencontainers.image.version=${VERSION}
LABEL org.opencontainers.image.created=${BUILD_DATE}
LABEL org.opencontainers.image.revision=${VCS_REF}
LABEL org.opencontainers.image.source="https://github.com/yourusername/security-multi-agent"
LABEL org.opencontainers.image.vendor="Security Multi-Agent Team"
LABEL org.opencontainers.image.licenses="MIT"

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install runtime dependencies with security updates
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    python3.11 \
    python3.11-venv \
    curl \
    ca-certificates \
    sqlite3 \
    openssl \
    dumb-init \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/*

# Create non-root user for security with minimal privileges
RUN groupadd -r security --gid=1000 && \
    useradd -r -g security --uid=1000 --home-dir=/app --shell=/bin/bash security && \
    mkdir -p /app && \
    chown security:security /app

# Set working directory
WORKDIR /app

# Copy virtual environment from builder stage
COPY --from=builder --chown=security:security /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Copy application code with proper ownership
COPY --chown=security:security . .

# Create necessary directories with proper permissions
RUN mkdir -p /app/data /app/logs /app/reports /app/config /app/tmp && \
    chown -R security:security /app && \
    chmod -R 750 /app

# Set secure environment variables
ENV PYTHONPATH=/app
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONHASHSEED=random
ENV PIP_NO_CACHE_DIR=1
ENV PIP_DISABLE_PIP_VERSION_CHECK=1

# Remove potential security risks
RUN find /app -type f -name "*.pyc" -delete && \
    find /app -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true

# Switch to non-root user
USER security

# Health check with proper timeout
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD curl -f http://localhost:8000/health || exit 1

# Expose ports
EXPOSE 8000 8501

# Use dumb-init as entrypoint for proper signal handling
ENTRYPOINT ["dumb-init", "--"]

# Default command (can be overridden)
CMD ["python3.11", "-m", "uvicorn", "fastapi_app.main:app", "--host", "0.0.0.0", "--port", "8000"]

# Development stage with additional tools
FROM production as development

# Switch back to root to install dev dependencies
USER root

# Install development dependencies and tools
RUN pip install --no-cache-dir -r requirements-dev.txt && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    vim \
    htop \
    procps \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/*

# Switch back to security user
USER security

# Override command for development with reload
CMD ["python3.11", "-m", "uvicorn", "fastapi_app.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
