# Docker Deployment Guide

This guide provides comprehensive instructions for deploying the Security Multi-Agent System using Docker and Docker Compose.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
- [Development Setup](#development-setup)
- [Production Deployment](#production-deployment)
- [Monitoring and Logging](#monitoring-and-logging)
- [Scaling and Load Balancing](#scaling-and-load-balancing)
- [Security Considerations](#security-considerations)
- [Troubleshooting](#troubleshooting)

## Prerequisites

### System Requirements

- **Docker Engine**: 20.10+ 
- **Docker Compose**: 2.0+
- **System Resources**:
  - Minimum: 4GB RAM, 2 CPU cores, 10GB disk space
  - Recommended: 8GB RAM, 4 CPU cores, 50GB disk space
  - Production: 16GB RAM, 8 CPU cores, 100GB disk space

### API Keys Required

Before starting, obtain API keys for the following services:

- **VirusTotal API**: [Get key](https://www.virustotal.com/gui/join-us)
- **AbuseIPDB API**: [Get key](https://www.abuseipdb.com/register)
- **IPInfo Token**: [Get key](https://ipinfo.io/signup)
- **Google Gemini API**: [Get key](https://makersuite.google.com/app/apikey)

## Quick Start

### 1. Clone and Setup

```bash
# Clone the repository
git clone https://github.com/yourusername/security-multi-agent.git
cd security-multi-agent

# Copy environment template
cp .env.example .env

# Edit .env file with your API keys
nano .env
```

### 2. Start Services

```bash
# Start all services
docker-compose up -d

# Check service status
docker-compose ps

# View logs
docker-compose logs -f
```

### 3. Access Applications

- **Dashboard**: http://localhost:8501
- **API Documentation**: http://localhost:8000/docs
- **Grafana Monitoring**: http://localhost:3000 (admin/admin)
- **Prometheus Metrics**: http://localhost:9090

## Configuration

### Environment Variables

The system uses environment variables for configuration. Key variables include:

```bash
# Core API Keys
VT_API_KEY=your_virustotal_api_key
ABUSEIPDB_API_KEY=your_abuseipdb_api_key
IPINFO_TOKEN=your_ipinfo_token
GEMINI_API_KEY=your_gemini_api_key

# Application Settings
APP_ENV=production
LOG_LEVEL=INFO
SECRET_KEY=your_secret_key

# Database Configuration
DATABASE_URL=sqlite:///./data/security_agents.db

# Alert Configuration
EMAIL_USER=your_email@domain.com
EMAIL_PASS=your_app_password
SLACK_WEBHOOK=your_slack_webhook_url
```

### Volume Mounts

The following directories are persisted:

- `./data` - Database and application data
- `./logs` - Application logs
- `./reports` - Generated reports
- `./config` - Configuration files

## Development Setup

### Using Development Compose

```bash
# Start development environment
docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d

# Access development tools
docker-compose exec dev-tools bash

# Run tests
docker-compose exec api pytest

# Access Jupyter notebook
# Navigate to http://localhost:8888 (token: dev-token)
```

### Live Code Reloading

In development mode:
- API automatically reloads on code changes
- Dashboard reloads on template changes
- Source code is mounted as volume

### Development Tools

- **Jupyter Lab**: http://localhost:8888
- **Hot Reloading**: Enabled for API and Dashboard
- **Debug Port**: 5678 (Python debugger)
- **Dev Database**: PostgreSQL on port 5432

## Production Deployment

### 1. Prepare Production Environment

```bash
# Set production environment
export APP_ENV=production

# Generate secure secret key
openssl rand -hex 32

# Configure SSL certificates (if using HTTPS)
mkdir -p ssl
# Place cert.pem and key.pem in ssl/ directory
```

### 2. Production-Ready Compose

```bash
# Start production stack
docker-compose -f docker-compose.yml up -d

# Scale workers
docker-compose up -d --scale worker=3

# Check health
docker-compose exec api curl http://localhost:8000/health
```

### 3. SSL/TLS Configuration

To enable HTTPS:

1. Obtain SSL certificates
2. Place certificates in `./ssl/` directory
3. Uncomment HTTPS section in `nginx.conf`
4. Update `docker-compose.yml` to expose port 443

### 4. Backup Strategy

```bash
# Backup data volumes
docker run --rm -v security-multi-agent_grafana_data:/data -v $(pwd):/backup alpine tar czf /backup/grafana-backup.tar.gz -C /data .

# Backup database
docker-compose exec api python -c "import shutil; shutil.copy('/app/data/security_agents.db', '/app/reports/backup.db')"
```

## Monitoring and Logging

### Prometheus Metrics

Access metrics at:
- **Prometheus**: http://localhost:9090
- **Grafana**: http://localhost:3000

### Available Metrics

- API response times and error rates
- Agent processing statistics
- System resource usage
- Security threat detection counts
- External API usage and rate limits

### Log Aggregation

Logs are available via:

```bash
# All services
docker-compose logs

# Specific service
docker-compose logs api

# Follow logs
docker-compose logs -f --tail=100
```

### Grafana Dashboards

Pre-configured dashboards include:
- System Overview
- API Performance
- Agent Processing
- Security Threats
- Infrastructure Monitoring

## Scaling and Load Balancing

### Horizontal Scaling

```bash
# Scale API instances
docker-compose up -d --scale api=3

# Scale workers
docker-compose up -d --scale worker=5

# Scale dashboard (if needed)
docker-compose up -d --scale dashboard=2
```

### Load Balancer Configuration

Nginx is configured with:
- Round-robin load balancing
- Health checks
- Rate limiting
- SSL termination (when configured)

### Resource Limits

Each service has defined resource limits:
- **API**: 2 CPU, 2GB RAM
- **Dashboard**: 1 CPU, 1GB RAM
- **Worker**: 1.5 CPU, 1.5GB RAM
- **Redis**: 0.5 CPU, 512MB RAM

## Security Considerations

### Container Security

- All services run as non-root users
- Read-only root filesystems where possible
- Minimal base images (Alpine Linux)
- Regular security updates

### Network Security

- Services communicate via internal Docker network
- Only necessary ports exposed
- Rate limiting configured
- Security headers enabled

### Secrets Management

```bash
# Use Docker secrets for sensitive data
echo "your_secret_key" | docker secret create secret_key -

# Update compose file to use secrets
# secrets:
#   secret_key:
#     external: true
```

### SSL/TLS Best Practices

- Use TLS 1.2+ only
- Strong cipher suites
- HSTS headers
- Certificate pinning

## Troubleshooting

### Common Issues

#### Service Won't Start

```bash
# Check logs
docker-compose logs [service_name]

# Check resource usage
docker stats

# Restart specific service
docker-compose restart [service_name]
```

#### API Connection Errors

```bash
# Check API health
curl http://localhost:8000/health

# Check network connectivity
docker-compose exec dashboard curl http://api:8000/health

# Verify environment variables
docker-compose exec api env | grep API_KEY
```

#### Database Issues

```bash
# Check database file permissions
ls -la data/

# Reset database
docker-compose down
rm -f data/security_agents.db
docker-compose up -d
```

#### Memory Issues

```bash
# Check memory usage
docker stats --no-stream

# Increase Docker memory limit
# Docker Desktop: Settings > Resources > Memory

# Add swap if needed (Linux)
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```

### Performance Tuning

#### API Performance

```yaml
# In docker-compose.yml, add to API service:
environment:
  - WORKERS=4
  - WORKER_CONNECTIONS=1000
  - KEEPALIVE=2
```

#### Database Optimization

```bash
# For SQLite
docker-compose exec api sqlite3 /app/data/security_agents.db "PRAGMA optimize;"

# Consider PostgreSQL for production
# Update DATABASE_URL in .env
```

#### Redis Optimization

```yaml
# In docker-compose.yml, update Redis command:
command: redis-server --maxmemory 1gb --maxmemory-policy allkeys-lru --save 900 1
```

### Debugging

#### Enable Debug Mode

```bash
# Set debug environment
export LOG_LEVEL=DEBUG
export APP_ENV=development

# Restart services
docker-compose restart
```

#### Access Container Shell

```bash
# API container
docker-compose exec api bash

# Dashboard container
docker-compose exec dashboard bash

# Redis CLI
docker-compose exec redis redis-cli
```

#### Network Debugging

```bash
# Test internal connectivity
docker-compose exec api ping redis
docker-compose exec dashboard curl http://api:8000/health

# Check exposed ports
docker-compose port api 8000
```

### Health Checks

All services include health checks. Check status:

```bash
# View health status
docker-compose ps

# Manual health check
curl http://localhost:8000/health
curl http://localhost:8501/_stcore/health
```

## Support

For additional support:

1. Check the [main README](README.md)
2. Review [API documentation](http://localhost:8000/docs)
3. Open an issue on GitHub
4. Contact: support@yourdomain.com

## References

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Reference](https://docs.docker.com/compose/)
- [Nginx Configuration Guide](https://nginx.org/en/docs/)
- [Prometheus Documentation](https://prometheus.io/docs/)
- [Grafana Documentation](https://grafana.com/docs/)
