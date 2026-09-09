#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT/infra/docker"
: "${POSTGRES_PASSWORD:?Set POSTGRES_PASSWORD}"
export POSTGRES_PASSWORD
export POSTGRES_DB="${POSTGRES_DB:-hala}"
export POSTGRES_USER="${POSTGRES_USER:-hala}"
export CORS_ORIGIN="${CORS_ORIGIN:-http://localhost:8088,http://localhost:8089}"
export HALA_WEBHOOK_SECRET="${HALA_WEBHOOK_SECRET:?Set HALA_WEBHOOK_SECRET}"
printf '\n[1/7] Validating compose...\n'
docker compose config >/dev/null
printf '[2/7] Building images...\n'
docker compose build
printf '[3/7] Starting clean production database/backend/workers...\n'
docker compose up -d db backend webhook-worker timer-worker supervisor-worker
printf '[4/7] Waiting for backend readiness...\n'
for i in $(seq 1 60); do
  if docker compose exec -T backend wget -qO- http://127.0.0.1:8080/ready >/dev/null 2>&1; then break; fi
  sleep 2
  if [ "$i" = 60 ]; then echo 'Backend readiness failed'; docker compose logs --tail=200 backend db; exit 1; fi
done
printf '[5/7] Starting customer/admin gateways...\n'
docker compose up -d customer admin
printf '[6/7] HTTP smoke checks...\n'
curl -fsS http://127.0.0.1:8088/ >/dev/null
curl -fsS http://127.0.0.1:8089/ >/dev/null
curl -fsS http://127.0.0.1:8088/api/v1/portal >/dev/null || true
printf '[7/7] Database smoke query...\n'
docker compose exec -T db psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "select count(*) from hala.markets; select count(*) from hala.ai_supervisor_configs; select count(*) from hala.provider_applications;" 
printf '\nREAL PRELAUNCH ENVIRONMENT IS UP WITHOUT PILOT SEED. Proceed to E2E/payment/security test suite.\n'
