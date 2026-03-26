# Run Next.js dev without local Node/npm — requires Docker Desktop
Set-Location $PSScriptRoot
docker compose -f docker-compose.yml -f docker-compose.dev.yml up --build db app
