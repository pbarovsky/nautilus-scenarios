#!/bin/bash

set -e
trap 'echo "[ERROR] Что-то пошло не так. Установка прервана." >&2; exit 1' ERR

# Абсолютный путь к текущей директории скрипта
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "[INFO] Установка скриптов Nautilus..."

# 1. Проверка/создание папки скриптов
SCRIPTS_DIR="$HOME/.local/share/nautilus/scripts"
if [ -d "$SCRIPTS_DIR" ]; then
  echo "[INFO] Папка уже существует: $SCRIPTS_DIR"
else
  mkdir -p "$SCRIPTS_DIR"
  echo "[INFO] Создана папка для скриптов: $SCRIPTS_DIR"
fi

# 2. Копирование скриптов
if cp "$BASE_DIR/scripts/"* "$SCRIPTS_DIR"; then
  echo "[INFO] Скрипты скопированы в $SCRIPTS_DIR"
else
  echo "[ERROR] Не удалось скопировать скрипты." >&2
  exit 1
fi

# 3. Проверка/создание папки шаблонов
TEMPLATES_DIR="$HOME/.local/share/file-templates"
if [ -d "$TEMPLATES_DIR" ]; then
  echo "[INFO] Папка уже существует: $TEMPLATES_DIR"
else
  mkdir -p "$TEMPLATES_DIR"
  echo "[INFO] Создана папка для шаблонов: $TEMPLATES_DIR"
fi

# 4. Копирование шаблонов
if cp "$BASE_DIR/file-templates/"* "$TEMPLATES_DIR"; then
  echo "[INFO] Шаблоны скопированы в $TEMPLATES_DIR"
else
  echo "[ERROR] Не удалось скопировать шаблоны." >&2
  exit 1
fi

# 5. Сделать скрипты исполняемыми
if chmod +x "$SCRIPTS_DIR"/*; then
  echo "[INFO] Скрипты сделаны исполняемыми."
else
  echo "[ERROR] Не удалось установить права на выполнение для скриптов." >&2
  exit 1
fi

# 6. Финальное сообщение после установки
echo "[OK] Установка завершена."
echo "[INFO] Перезапустите Nautilus вручную, чтобы изменения вступили в силу."
echo "[INFO] Скрипты появятся в контекстном меню Nautilus после перезапуска."
exit 0