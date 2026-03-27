# Restart Postgres + Next dev app (next.config, .env, UI/CSS/tailwind, prisma, etc.)
Set-Location $PSScriptRoot
docker compose -f docker-compose.yml -f docker-compose.dev.yml restart db app
