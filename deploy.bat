@echo off
REM Security Multi-Agent System - Windows Deployment Script
REM Enhanced with security scanning and hardening

setlocal EnableDelayedExpansion

REM Configuration
set PROJECT_NAME=security-multi-agent
set IMAGE_NAME=security-agents/multi-agent
set COMPOSE_PROJECT_NAME=security-agents

REM Colors (limited in Windows cmd)
set "SUCCESS=✅"
set "ERROR=❌"
set "WARNING=⚠️"
set "INFO=ℹ️"

echo.
echo ============================================================
echo 🛡️ Security Multi-Agent System - Secure Deployment
echo ============================================================
echo.

if "%1"=="" (
    echo Usage: %0 [command]
    echo.
    echo Available commands:
    echo   deploy       - Deploy production stack with security scan
    echo   dev          - Deploy development environment
    echo   scan         - Run security scan only
    echo   scale        - Scale services
    echo   backup       - Backup database
    echo   restore      - Restore database
    echo   logs         - View logs
    echo   monitor      - Open monitoring dashboards
    echo   stop         - Stop all services
    echo   clean        - Clean up containers and volumes
    echo   health       - Check service health
    echo   update       - Update images and restart
    echo.
    exit /b 1
)

REM Check prerequisites
echo %INFO% Checking prerequisites...

where docker >nul 2>&1
if %errorlevel% neq 0 (
    echo %ERROR% Docker not found. Please install Docker Desktop.
    exit /b 1
)

where docker-compose >nul 2>&1
if %errorlevel% neq 0 (
    echo %ERROR% Docker Compose not found. Please install Docker Compose.
    exit /b 1
)

if not exist ".env" (
    if exist ".env.example" (
        echo %WARNING% .env file not found. Copying from .env.example...
        copy ".env.example" ".env"
        echo %WARNING% Please edit .env file with your API keys before proceeding.
        pause
    ) else (
        echo %ERROR% .env.example file not found. Please create environment configuration.
        exit /b 1
    )
)

echo %SUCCESS% Prerequisites check passed
echo.

REM Handle commands
if "%1"=="deploy" goto :deploy
if "%1"=="dev" goto :dev
if "%1"=="scan" goto :scan
if "%1"=="scale" goto :scale
if "%1"=="backup" goto :backup
if "%1"=="restore" goto :restore
if "%1"=="logs" goto :logs
if "%1"=="monitor" goto :monitor
if "%1"=="stop" goto :stop
if "%1"=="clean" goto :clean
if "%1"=="health" goto :health
if "%1"=="update" goto :update

echo %ERROR% Unknown command: %1
exit /b 1

:deploy
echo %INFO% Deploying production stack with security scanning...
echo.

REM Run security scan first
call :run_security_scan
if %errorlevel% neq 0 (
    echo %ERROR% Security scan failed. Deployment aborted.
    exit /b 1
)

echo %INFO% Starting production deployment...
docker-compose pull
docker-compose up -d

echo.
echo %SUCCESS% Production deployment completed!
echo.
call :show_access_info
goto :end

:dev
echo %INFO% Deploying development environment...
echo.

docker-compose -f docker-compose.dev.yml pull
docker-compose -f docker-compose.dev.yml up -d

echo.
echo %SUCCESS% Development environment deployed!
echo.
echo 📊 Development Services:
echo   Dashboard: http://localhost:8501
echo   API Docs: http://localhost:8000/docs
echo   Jupyter: http://localhost:8888
echo   pgAdmin: http://localhost:5050
echo   Redis Commander: http://localhost:8081
echo.
goto :end

:scan
echo %INFO% Running security scan...
call :run_security_scan
goto :end

:scale
echo %INFO% Scaling services...
echo.
set /p WORKERS="Enter number of worker instances (default 3): "
if "%WORKERS%"=="" set WORKERS=3

set /p API_INSTANCES="Enter number of API instances (default 2): "
if "%API_INSTANCES%"=="" set API_INSTANCES=2

docker-compose up -d --scale worker=%WORKERS% --scale api=%API_INSTANCES%

echo %SUCCESS% Services scaled: API=%API_INSTANCES%, Workers=%WORKERS%
goto :end

:backup
echo %INFO% Creating database backup...
echo.

for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "BACKUP_NAME=backup_%dt:~0,8%_%dt:~8,6%"

docker-compose exec -T db pg_dump -U postgres -d security_agents > "backups\%BACKUP_NAME%.sql"

if %errorlevel% equ 0 (
    echo %SUCCESS% Database backup created: backups\%BACKUP_NAME%.sql
) else (
    echo %ERROR% Backup failed
)
goto :end

:restore
echo %INFO% Restoring database...
echo.

dir /b backups\*.sql 2>nul
if %errorlevel% neq 0 (
    echo %ERROR% No backup files found in backups\ directory
    goto :end
)

set /p BACKUP_FILE="Enter backup filename (from backups\ directory): "
if not exist "backups\%BACKUP_FILE%" (
    echo %ERROR% Backup file not found: backups\%BACKUP_FILE%
    goto :end
)

echo %WARNING% This will overwrite the current database. Continue? (y/N)
set /p CONFIRM=
if /i not "%CONFIRM%"=="y" goto :end

docker-compose exec -T db psql -U postgres -d security_agents < "backups\%BACKUP_FILE%"

if %errorlevel% equ 0 (
    echo %SUCCESS% Database restored from: backups\%BACKUP_FILE%
) else (
    echo %ERROR% Restore failed
)
goto :end

:logs
echo %INFO% Viewing logs...
if "%2"=="" (
    docker-compose logs -f --tail=100
) else (
    docker-compose logs -f --tail=100 %2
)
goto :end

:monitor
echo %INFO% Opening monitoring dashboards...
echo.
start http://localhost:3000
start http://localhost:9090
echo %SUCCESS% Opened Grafana (localhost:3000) and Prometheus (localhost:9090)
goto :end

:stop
echo %INFO% Stopping all services...
docker-compose down
echo %SUCCESS% All services stopped
goto :end

:clean
echo %WARNING% This will remove all containers, volumes, and data. Continue? (y/N)
set /p CONFIRM=
if /i not "%CONFIRM%"=="y" goto :end

echo %INFO% Cleaning up...
docker-compose down -v --remove-orphans
docker system prune -f
echo %SUCCESS% Cleanup completed
goto :end

:health
echo %INFO% Checking service health...
echo.

docker-compose ps

echo.
echo %INFO% Testing service endpoints...

REM Test API health
curl -f http://localhost:8000/health >nul 2>&1
if %errorlevel% equ 0 (
    echo %SUCCESS% API: http://localhost:8000 - Healthy
) else (
    echo %ERROR% API: http://localhost:8000 - Unhealthy
)

REM Test Dashboard
powershell -Command "try { Invoke-WebRequest -Uri 'http://localhost:8501' -UseBasicParsing -TimeoutSec 5 | Out-Null; Write-Host '%SUCCESS% Dashboard: http://localhost:8501 - Healthy' } catch { Write-Host '%ERROR% Dashboard: http://localhost:8501 - Unhealthy' }"

REM Test Grafana
powershell -Command "try { Invoke-WebRequest -Uri 'http://localhost:3000' -UseBasicParsing -TimeoutSec 5 | Out-Null; Write-Host '%SUCCESS% Grafana: http://localhost:3000 - Healthy' } catch { Write-Host '%ERROR% Grafana: http://localhost:3000 - Unhealthy' }"

goto :end

:update
echo %INFO% Updating images and restarting services...
echo.

docker-compose pull
docker-compose up -d

echo %SUCCESS% Update completed
goto :end

REM Helper function to run security scan
:run_security_scan
if exist "security-scan.bat" (
    echo %INFO% Running security scan...
    call security-scan.bat
    if %errorlevel% neq 0 (
        echo %ERROR% Security scan detected issues
        exit /b 1
    )
    echo %SUCCESS% Security scan passed
) else (
    echo %WARNING% Security scan script not found, skipping...
)
exit /b 0

REM Helper function to show access information
:show_access_info
echo 🌐 Access Information:
echo =====================
echo.
echo 📊 Dashboard:     http://localhost:8501
echo 🔌 API Docs:      http://localhost:8000/docs
echo 📈 Grafana:       http://localhost:3000 (admin/admin)
echo 📊 Prometheus:    http://localhost:9090
echo.
echo 🔐 Default credentials:
echo   Grafana: admin/admin (change on first login)
echo   Database: postgres/secure_password (from .env)
echo.
echo 💡 Tips:
echo   - Check logs: %0 logs [service]
echo   - Scale services: %0 scale
echo   - Monitor health: %0 health
echo   - Create backup: %0 backup
echo.

:end
echo.
echo 🏁 Deployment script completed
echo.
pause
