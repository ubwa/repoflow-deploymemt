S3_ACCESS_KEY="$(openssl rand -hex 16)"
S3_SECRET_KEY="$(openssl rand -hex 32)"
JWT_SECRET="$(openssl rand -hex 64)"
HASURA_ADMIN_SECRET="$(openssl rand -hex 32)"
POSTGRES_USER="$(openssl rand -hex )"
POSTGRES_PASSWORD="$(openssl rand -hex 32)"
POSTGRES_DB="repoflow"

cat > secrets.env <<EOF
# ======================
# RepoFlow secrets
# ======================

# Used for signing cookies
GENERAL_COOKIE_SECRET=$(openssl rand -hex 32)

# ======================
# RepoFlow server JWTs
# ======================

# MUST MATCH HASURA_GRAPHQL_JWT_SECRET.key
JWT_SECRET=$JWT_SECRET

RESET_PASSWORD_JWT_SECRET=$(openssl rand -hex 64)
PERSONAL_ACCESS_TOKEN_JWT_SECRET=$(openssl rand -hex 64)

# MUST MATCH HASURA_GRAPHQL_ADMIN_SECRET
HASURA_ADMIN_SECRET=$HASURA_ADMIN_SECRET

# ======================
# S3 / MinIO credentials
# These values MUST match
# ======================

S3_ACCESS_KEY=$S3_ACCESS_KEY
S3_SECRET_KEY=$S3_SECRET_KEY
MINIO_ROOT_USER=$S3_ACCESS_KEY
MINIO_ROOT_PASSWORD=$S3_SECRET_KEY

# ======================
# PostgreSQL
# ======================

POSTGRES_USER=$POSTGRES_USER
POSTGRES_PASSWORD=$POSTGRES_PASSWORD
POSTGRES_DB=$POSTGRES_DB

# ======================
# Hasura
# ======================

# MUST MATCH HASURA_ADMIN_SECRET
HASURA_GRAPHQL_ADMIN_SECRET=$HASURA_ADMIN_SECRET

# MUST MATCH JWT_SECRET
HASURA_GRAPHQL_JWT_SECRET={"type":"HS256","key":"$JWT_SECRET","header":{"type":"Cookie","name":"X-USER-TOKEN"}}
EOF

echo "Created secrets.env"
