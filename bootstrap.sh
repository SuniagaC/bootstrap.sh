#!/usr/bin/env bash
set -e

PROJECT="devops-task-platform"

echo "🚀 Creando estructura del proyecto: $PROJECT"

# Crear carpetas
mkdir -p $PROJECT/{app,tests,k8s,terraform,nginx}
mkdir -p $PROJECT/.github/workflows

# Archivos app
touch $PROJECT/app/{main.py,db.py,models.py,schemas.py,crud.py}

# Tests
touch $PROJECT/tests/test_health.py

# Raíz
touch $PROJECT/{requirements.txt,Dockerfile,docker-compose.yml,.env.example}

# GitHub Actions
touch $PROJECT/.github/workflows/ci.yml

# Kubernetes
touch $PROJECT/k8s/{namespace.yml,configmap.yml,secret.yml,postgres-deployment.yml,postgres-service.yml,api-deployment.yml,api-service.yml,ingress.yml}

# Terraform
touch $PROJECT/terraform/{main.tf,variables.tf,outputs.tf}

# Nginx
touch $PROJECT/nginx/default.conf

echo "📁 Estructura creada correctamente"

# Opcional: contenido base mínimo

echo "📝 Añadiendo contenido base..."

cat > $PROJECT/app/main.py << 'EOF'
from fastapi import FastAPI

app = FastAPI()

@app.get("/health")
def health():
    return {"status": "ok"}
EOF

cat > $PROJECT/tests/test_health.py << 'EOF'
from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)

def test_health():
    response = client.get("/health")
    assert response.status_code == 200
EOF

cat > $PROJECT/requirements.txt << 'EOF'
fastapi
uvicorn
pytest
EOF

cat > $PROJECT/docker-compose.yml << 'EOF'
version: "3.9"
services:
  api:
    build: .
    ports:
      - "8000:8000"
EOF

echo "✅ Proyecto listo"