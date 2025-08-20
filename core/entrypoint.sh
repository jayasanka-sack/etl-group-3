#!/bin/bash

export PGPASSWORD=$TARGET_PASS
MYSQL_USER="root"
MYSQL_PASSWORD="openmrs"
MYSQL_HOST="sqlmesh-db"
MYSQL_PORT="3306"
SOURCE_DB="omop_db"
TARGET_MYSQL_DB="public"
CONCEPTS_CSV_FILE="seed/CONCEPT.csv"
TEMP_DIR="tmp"

clone-openmrs-db() {
  echo "Cloning OpenMRS database..."
  mysqldump -h "$SRC_HOST" -P "$SRC_PORT" -u "$SRC_USER" -p"$SRC_PASS" "$SRC_DB" \
  | mysql -h sqlmesh-db -uopenmrs -popenmrs openmrs
  echo "Clone completed."
}


apply-sqlmesh-plan() {
  echo "Running SQLMesh plan..."
  sqlmesh plan --no-prompts --auto-apply
  echo "SQLMesh plan completed."
}



command="$1"
shift

echo "DEBUG: received command: $command"
echo "DEBUG: all args: $@"

# Create tmp directory if it doesn't exist
mkdir -p "$TEMP_DIR"

case "$command" in
  clone-openmrs-db)
    clone-openmrs-db
    ;;
  apply-sqlmesh-plan)
    apply-sqlmesh-plan
    ;;
  *)
    echo "Unknown command: $command"
    echo "Usage: $0 {clone-openmrs-db|generate-concepts-usagi-input|apply-sqlmesh-plan|materialize-mysql-views|migrate-to-postgresql|import-omop-concepts|apply-omop-constraints|run-full-pipeline}"
    exit 1
    ;;
esac

# Remove temp directory
rm -rf "$TEMP_DIR"
