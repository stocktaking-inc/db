#!/bin/bash
set -euo pipefail

INIT_FILE="init.sql"
SCHEMA_DIR="schemas"

SOURCES=(
    "enum.sql:ENUM ТИПЫ"
    "table.sql:ОСНОВНЫЕ ТАБЛИЦЫ:exclude:good|inventory_items|order_items|orders|stock_transactions|profile|notifications"
    "table.sql:ТАБЛИЦЫ С ЗАВИСИМОСТЯМИ:include:good|inventory_items|order_items|orders|stock_transactions|profile|notifications"
    "function.sql:ФУНКЦИИ"
    "trigger.sql:ТРИГГЕРЫ"
    "index.sql:ИНДЕКСЫ"
    "seed.sql:НАЧАЛЬНЫЕ ДАННЫЕ"
)

# Проверка входных данных
[[ ! -d "$SCHEMA_DIR" ]] && { echo "❌ Ошибка: директория '$SCHEMA_DIR' не существует!"; exit 1; }
touch "$INIT_FILE" || { echo "❌ Ошибка: нет прав на запись в '$INIT_FILE'!"; exit 1; }

echo "🚀 Начинаю генерацию $INIT_FILE..."

generate_section() {
    local filename="$1" filter_type="$2" pattern="$3"
    local find_cmd="find \"$SCHEMA_DIR\" -name \"$filename\" -type f"

    echo "-- ===== $header ====="

    if [[ "$filter_type" == "exclude" ]]; then
        IFS='|' read -ra patterns <<< "$pattern"
        for p in "${patterns[@]}"; do
            find_cmd+=" -not -path \"*/$p/*\""
        done
        find_cmd+=" -exec cat {} \;"
    elif [[ "$filter_type" == "include" ]]; then
        IFS='|' read -ra patterns <<< "$pattern"
        find_cmd+=" \( "
        first=true
        for p in "${patterns[@]}"; do
            if [[ "$first" == true ]]; then
                find_cmd+="-path \"*/$p/*\""
                first=false
            else
                find_cmd+=" -o -path \"*/$p/*\""
            fi
        done
        find_cmd+=" \) -exec cat {} \;"
    else
        find_cmd+=" -exec cat {} \;"
    fi

    eval "$find_cmd" || echo "⚠️ Предупреждение: не найдено файлов для '$filename' с фильтром '$filter_type:$pattern'"
    echo ""
}

{
    echo "-- 🚀 Автоматически сгенерированный init.sql"
    echo "-- ⚠️ Не редактировать вручную! Генерируется скриптом"
    echo ""
    echo "BEGIN;"
    echo ""

    for source in "${SOURCES[@]}"; do
        IFS=':' read -r filename header filter_type pattern <<< "$source"
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
