#!/bin/bash
# Security Multi-Agent System - Linux/macOS Deployment Script
# Enhanced with security scanning and hardening

set -euo pipefail

# Configuration
# Colors for output
# (Removed unused PROJECT_NAME, IMAGE_NAME, COMPOSE_PROJECT_NAME, RED, GREEN, YELLOW, BLUE, NC)

# Emojis
SUCCESS="✅"
ERROR="❌"
WARNING="⚠️"
INFO="ℹ️"

echo
echo "============================================================"
echo "🛡️ Security Multi-Agent System - Secure Deployment"
echo "============================================================"
echo

# Function to display usage
usage() {
    echo "Usage: $0 [command]"
    echo
    echo "Available commands:"
    echo "  deploy       - Deploy production stack with security scan"
    echo "  dev          - Deploy development environment"
    echo "  scan         - Run security scan only"
    echo "  scale        - Scale services"
    echo "  backup       - Backup database"
    echo "  restore      - Restore database"
    echo "  logs         - View logs"
    echo "  monitor      - Open monitoring dashboards"
    echo "  stop         - Stop all services"
    echo "  clean        - Clean up containers and volumes"
    echo "  health       - Check service health"
    echo "  update       - Update images and restart"
    echo
    exit 1
}

# Function to check prerequisites
check_prerequisites() {
    echo -e "${INFO} Checking prerequisites..."
    
    command -v docker >/dev/null 2>&1 || {
        echo -e "${ERROR} Docker not found. Please install Docker."
        exit 1
    }
    
    command -v docker-compose >/dev/null 2>&1 || {
        echo -e "${ERROR} Docker Compose not found. Please install Docker Compose."
        exit 1
    }
    
    if [ ! -f ".env" ]; then
        if [ -f ".env.example" ]; then
            echo -e "${WARNING} .env file not found. Copying from .env.example..."
            cp .env.example .env
            echo -e "${WARNING} Please edit .env file with your API keys before proceeding."
            read -r -p "Press Enter to continue after editing .env file..."
        else
            echo -e "${ERROR} .env.example file not found. Please create environment configuration."
            exit 1
        fi
    fi
    
    echo -e "${SUCCESS} Prerequisites check passed"
            read -r -p "Press Enter to continue after editing .env file..."
}

# Function to run security scan
run_security_scan() {
    if [ -f "security-scan.sh" ]; then
        echo -e "${INFO} Running security scan..."
        chmod +x security-scan.sh
        if ./security-scan.sh; then
            echo -e "${SUCCESS} Security scan passed"
            return 0
        else
            echo -e "${ERROR} Security scan detected issues"
            return 1
        fi
    else
        echo -e "${WARNING} Security scan script not found, skipping..."
        return 0
    fi
}

# Function to show access information
show_access_info() {
    echo "🌐 Access Information:"
    echo "====================="
    echo
    echo "📊 Dashboard:     http://localhost:8501"
    echo "🔌 API Docs:      http://localhost:8000/docs"
    echo "📈 Grafana:       http://localhost:3000 (admin/admin)"
    echo "📊 Prometheus:    http://localhost:9090"
    echo
    echo "🔐 Default credentials:"
    echo "  Grafana: admin/admin (change on first login)"
    echo "  Database: postgres/secure_password (from .env)"
    echo
    echo "💡 Tips:"
    echo "  - Check logs: $0 logs [service]"
    echo "  - Scale services: $0 scale"
    echo "  - Monitor health: $0 health"
    echo "  - Create backup: $0 backup"
    echo
}

# Function to open URL (cross-platform)
open_url() {
    if command -v open >/dev/null 2>&1; then
        open "$1"  # macOS
    elif command -v xdg-open >/dev/null 2>&1; then
        xdg-open "$1"  # Linux
    else
        echo "Please open $1 in your browser"
    fi
}

# Main deployment function
deploy() {
    echo -e "${INFO} Deploying production stack with security scanning..."
    echo
    
    # Run security scan first
    if ! run_security_scan; then
        echo -e "${ERROR} Security scan failed. Deployment aborted."
        exit 1
    fi
    
    echo -e "${INFO} Starting production deployment..."
    docker-compose pull
    docker-compose up -d
    
    echo
    echo -e "${SUCCESS} Production deployment completed!"
    echo
    show_access_info
}

# Development deployment
deploy_dev() {
    echo -e "${INFO} Deploying development environment..."
    echo
    
    docker-compose -f docker-compose.dev.yml pull
    docker-compose -f docker-compose.dev.yml up -d
    
    echo
    echo -e "${SUCCESS} Development environment deployed!"
    echo
    echo "📊 Development Services:"
    echo "  Dashboard: http://localhost:8501"
    echo "  API Docs: http://localhost:8000/docs"
    echo "  Jupyter: http://localhost:8888"
    echo "  pgAdmin: http://localhost:5050"
    echo "  Redis Commander: http://localhost:8081"
    echo
}

# Scale services
scale() {
    echo -e "${INFO} Scaling services..."
    echo
    
    read -r -p "Enter number of worker instances (default 3): " WORKERS
    WORKERS=${WORKERS:-3}
    
    read -r -p "Enter number of API instances (default 2): " API_INSTANCES
    API_INSTANCES=${API_INSTANCES:-2}
    
    docker-compose up -d --scale worker="$WORKERS" --scale api="$API_INSTANCES"
    
    read -r -p "Enter number of worker instances (default 3): " WORKERS
    WORKERS=${WORKERS:-3}
    
    read -r -p "Enter number of API instances (default 2): " API_INSTANCES
    API_INSTANCES=${API_INSTANCES:-2}
    
    docker-compose up -d --scale worker="$WORKERS" --scale api="$API_INSTANCES"
    
    mkdir -p backups
    BACKUP_NAME="backup_$(date +%Y%m%d_%H%M%S)"
    
    if docker-compose exec -T db pg_dump -U postgres -d security_agents > "backups/${BACKUP_NAME}.sql"; then
        echo -e "${SUCCESS} Database backup created: backups/${BACKUP_NAME}.sql"
    else
        echo -e "${ERROR} Backup failed"
    fi
}

# Restore database
restore() {
    echo -e "${INFO} Restoring database..."
    echo
    
    if [ ! -d "backups" ] || [ -z "$(ls -A backups/*.sql 2>/dev/null)" ]; then
        echo -e "${ERROR} No backup files found in backups/ directory"
        return
    fi
    
    echo "Available backups:"
    ls -la backups/*.sql
    echo
    
    read -r -p "Enter backup filename (from backups/ directory): " BACKUP_FILE
    
    if [ ! -f "backups/$BACKUP_FILE" ]; then
        echo -e "${ERROR} Backup file not found: backups/$BACKUP_FILE"
        return
    fi
    
    echo -e "${WARNING} This will overwrite the current database. Continue? (y/N)"
    read -r -p "Enter backup filename (from backups/ directory): " BACKUP_FILE
    
    if [ ! -f "backups/$BACKUP_FILE" ]; then
        echo -e "${ERROR} Backup file not found: backups/$BACKUP_FILE"
        return
    fi

    if docker-compose exec -T db psql -U postgres -d security_agents < "backups/$BACKUP_FILE"; then
        echo -e "${SUCCESS} Database restored from: backups/$BACKUP_FILE"
    else
        echo -e "${ERROR} Restore failed"
    fi
}

# View logs
view_logs() {
    echo -e "${INFO} Viewing logs..."
    if [ -n "${2:-}" ]; then
        docker-compose logs -f --tail=100 "$2"
    else
        docker-compose logs -f --tail=100
    fi
}

# Open monitoring dashboards
monitor() {
    echo -e "${INFO} Opening monitoring dashboards..."
    echo
    open_url "http://localhost:3000"  # Grafana
    open_url "http://localhost:9090"  # Prometheus
    echo -e "${SUCCESS} Opened Grafana (localhost:3000) and Prometheus (localhost:9090)"
}

# Stop all services
stop() {
    echo -e "${INFO} Stopping all services..."
    docker-compose down
    echo -e "${SUCCESS} All services stopped"
}

# Clean up
clean() {
    echo -e "${WARNING} This will remove all containers, volumes, and data. Continue? (y/N)"
    read -r CONFIRM
    if [[ ! $CONFIRM =~ ^[Yy]$ ]]; then
        return
    fi
    
    echo -e "${INFO} Cleaning up..."
    docker-compose down -v --remove-orphans
    docker system prune -f
    echo -e "${SUCCESS} Cleanup completed"
}

# Check service health
health() {
    echo -e "${INFO} Checking service health..."
    echo
    
    docker-compose ps
    
    echo
    echo -e "${INFO} Testing service endpoints..."
    
    # Test API health
    if curl -f http://localhost:8000/health >/dev/null 2>&1; then
        echo -e "${SUCCESS} API: http://localhost:8000 - Healthy"
    else
        echo -e "${ERROR} API: http://localhost:8000 - Unhealthy"
    fi
    
    # Test Dashboard
    if curl -f http://localhost:8501 >/dev/null 2>&1; then
        echo -e "${SUCCESS} Dashboard: http://localhost:8501 - Healthy"
    else
        echo -e "${ERROR} Dashboard: http://localhost:8501 - Unhealthy"
    fi
    
    # Test Grafana
    if curl -f http://localhost:3000 >/dev/null 2>&1; then
        echo -e "${SUCCESS} Grafana: http://localhost:3000 - Healthy"
    else
        echo -e "${ERROR} Grafana: http://localhost:3000 - Unhealthy"
    fi
}

# Update images and restart
update() {
    echo -e "${INFO} Updating images and restarting services..."
    echo
    
    docker-compose pull
    docker-compose up -d
    
    echo -e "${SUCCESS} Update completed"
}

# Main script
if [ $# -eq 0 ]; then
    usage
fi

check_prerequisites

case "${1:-}" in
    deploy)
        deploy
        ;;
    dev)
        deploy_dev
        ;;
    scan)
        run_security_scan
        ;;
    scale)
        scale
        ;;
    backup)
        backup
        ;;
    restore)
        restore
        ;;
    logs)
        view_logs "$@"
        ;;
    monitor)
        monitor
        ;;
    stop)
        stop
        ;;
    clean)
        clean
        ;;
    health)
        health
        ;;
    update)
        update
        ;;
    *)
        echo -e "${ERROR} Unknown command: $1"
        usage
        ;;
esac

echo
echo "🏁 Deployment script completed"
echo
