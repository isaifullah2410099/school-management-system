#!/bin/bash
set -e

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
APP_DIR="$ROOT_DIR/school-management-system-main/school-management-system-main"
SCHEMA_FILE="$APP_DIR/database/_sms.sql"

echo "==> Updating package metadata"
sudo apt-get update

echo "==> Installing PHP and MySQL dependencies"
sudo apt-get install -y php php-cli php-mysql default-mysql-server

echo "==> Starting MySQL service"
sudo service mysql start || true

echo "==> Creating database and application user"
sudo mysql -u root <<'SQL'
CREATE DATABASE IF NOT EXISTS _sms;
CREATE USER IF NOT EXISTS 'sms_user'@'localhost' IDENTIFIED WITH mysql_native_password BY '';
CREATE USER IF NOT EXISTS 'sms_user'@'127.0.0.1' IDENTIFIED WITH mysql_native_password BY '';
GRANT ALL PRIVILEGES ON _sms.* TO 'sms_user'@'localhost';
GRANT ALL PRIVILEGES ON _sms.* TO 'sms_user'@'127.0.0.1';
FLUSH PRIVILEGES;
SQL

echo "==> Importing database schema"
if [ -f "$SCHEMA_FILE" ]; then
  sudo mysql -u root _sms < "$SCHEMA_FILE"
  echo "Schema imported from $SCHEMA_FILE"
else
  echo "Schema file not found: $SCHEMA_FILE"
fi

echo "==> Setup complete"
echo "Run the app with: php -S 0.0.0.0:8000 -t $APP_DIR"
echo "Then open the forwarded Codespaces port 8000 or visit http://127.0.0.1:8000 if running locally."