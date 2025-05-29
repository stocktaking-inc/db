#!/bin/bash
set -euo pipefail

INIT_FILE="init.sql"
SCHEMA_DIR="schemas"

ORDERED_TABLES=(
    "warehouse"
    "suppliers"
    "business_plans"
    "customers"
    "categories"
    "settings"
    "items"
    "orders"
    "good"
    "order_items"
    "inventory_items"
    "stock_transactions"
    "profile"
    "notifications"
)

ORDERED_SEEDS=(
    "business_plans"
    "categories"
    "warehouse"
    "suppliers"
    "customers"
    "settings"
    "items"
    "orders"
    "good"
    "order_items"
    "profile"
)

SOURCES=(
    "enum.sql:ENUM ТИПЫ"
    "ordered_tables:ТАБЛИЦЫ В ПОРЯДКЕ"
    "function.sql:ФУНКЦИИ"
    "trigger.sql:ТРИГГЕРЫ"
    "index.sql:ИНДЕКСЫ"
    "ordered_seeds:НАЧАЛЬНЫЕ ДАННЫЕ"
)

[[ ! -d "$SCHEMA_DIR" ]] && { echo "❌ Ошибка: директория '$SCHEMA_DIR' не существует!"; exit 1; }
touch "$INIT_FILE" || { echo "❌ Ошибка: нет прав на запись в '$INIT_FILE'!"; exit 1; }

echo "🚀 Начинаю генерацию $INIT_FILE..."

generate_section() {
    local filename="$1"
    local filter_type="$2"
    local pattern="$3"
    echo "-- ===== $header ====="

    if [[ "$filename" == "ordered_tables" ]]; then
        for table in "${ORDERED_TABLES[@]}"; do
            file_path="$SCHEMA_DIR/$table/table.sql"
            if [[ -f "$file_path" ]]; then
                echo "-- $table"
                cat "$file_path"
                echo ""
            else
                echo "⚠️ Предупреждение: $file_path не найден"
            fi
        done
    elif [[ "$filename" == "ordered_seeds" ]]; then
        for table in "${ORDERED_SEEDS[@]}"; do
            seed_path="$SCHEMA_DIR/$table/seed.sql"
            if [[ -f "$seed_path" ]]; then
                echo "-- $table"
                cat "$seed_path"
                echo ""
            else
                echo "⚠️ Предупреждение: $seed_path не найден"
            fi
        done
    else
        find "$SCHEMA_DIR" -type f -name "$filename" -exec cat {} \; 2>/dev/null || echo "⚠️ Предупреждение: не найдено файлов $filename"
    fi
}

{
    echo "-- 🚀 Автоматически сгенерированный init.sql"
    echo "-- ⚠️ Не редактировать вручную! Генерируется скриптом"
    echo ""
    echo "BEGIN;"
    echo ""

    for source in "${SOURCES[@]}"; do
        IFS=':' read -r filename header filter_type pattern <<< "$(echo "$source::::" | cut -d':' -f1-4)"
        generate_section "$filename" "$filter_type" "$pattern"
    done

    echo "COMMIT;"
    echo ""
    echo "-- ✅ Сгенерировано $(date +'%Y-%m-%d %H:%M:%S')"
} > "$INIT_FILE"

echo "✅ Генерация $INIT_FILE завершена!"
echo "ℹ️ Порядок выполнения:"
for i in "${!SOURCES[@]}"; do
    header=$(echo "${SOURCES[$i]}" | cut -d':' -f2)
    printf "  %d. %s\n" $((i+1)) "$header"
done
