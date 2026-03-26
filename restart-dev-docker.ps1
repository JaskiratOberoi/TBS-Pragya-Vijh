# Restart Postgres + Next dev app (picks up next.config, .env, etc.)
Set-Location $PSScriptRoot
docker compose -f docker-compose.yml -f docker-compose.dev.yml restart db app
