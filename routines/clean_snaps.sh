#!/bin/bash
# Script avançado para limpeza de snaps antigos
# Agora com argumentos amigáveis: --dry-run e --execute

# DEPOIS POSSO ADICIONAR UM CALCULO DE QUANTO ESPACO VAI SER LIBERADO APOS A REMOCAO DOS 
# SNAPS ANTIGOS E FAZER UM PERGUNTA SE O USUARIO QUER PROSSEGUIR OU NAO

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
RESET="\033[0m"

set -eu

# Configurações de arquivos de log
LOG_FILE="./snap_cleanup.log"
SUMMARY_FILE="./snap_cleanup_summary.log"

# Função de log com timestamp
log() {
    echo -e "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# Função de log de resumo
summary() {
    echo "$1" >> "$SUMMARY_FILE"
}

# Verifica se snap está instalado
check_snap() {
    command -v snap >/dev/null 2>&1 || { log "snap não encontrado. Abortando."; exit 1; }
}

# Lista snaps desativados
list_disabled_snaps() {
    snap list --all | awk '/disabled/{print $1, $2, $3}'
}

# Remove snap antigo com confirmação
remove_snap() {
    local name=$1
    local revision=$2

    if [ "$DRY_RUN" = true ]; then
        log "[DRY-RUN] snap remove ${RED}$name${RESET} --revision=${RED}$revision${RESET}"
        summary "[DRY-RUN] $name:$revision"
    else
    	log "Removendo snap ${RED}$name${RESET}, revisão ${RED}$revision${RESET}..."
        sudo snap remove "$name" --revision="$revision"
        summary "REMOVIDO: $name:$revision"
    fi
}

# --------------------
# ARGUMENTOS
# --------------------
if [ $# -ne 1 ]; then
    echo -e "${RED}Erro${RESET}: você deve passar exatamente uma flag: ${YELLOW}--dry-run${RESET} ou ${YELLOW}--execute${RESET}"
    echo -e "Uso: $0 [--dry-run|--execute]"
    exit 1
fi

case "$1" in
    --dry-run)
        DRY_RUN=true
        ;;
    --execute)
        DRY_RUN=false
        ;;
    *)
        echo "Erro: flag inválida. Use --dry-run ou --execute"
        exit 1
        ;;
esac

# --------------------
# FUNÇÃO PRINCIPAL
# --------------------
main() {
    log "=== Início da limpeza de snaps antigos ==="
    check_snap

    disabled_snaps=$(list_disabled_snaps)
    if [ -z "$disabled_snaps" ]; then
        log "Nenhum snap antigo desativado encontrado."
        exit 0
    fi

    log "Snaps desativados encontrados:"
    echo "$disabled_snaps" | tee -a "$LOG_FILE"

    > "$SUMMARY_FILE"

    while read -r snap_name snap_version snap_revision; do
        remove_snap "$snap_name" "$snap_revision"
    done <<< "$disabled_snaps"

    log "=== Limpeza de snaps antigos concluída ==="
    log "Resumo das ações:"
    cat "$SUMMARY_FILE" | tee -a "$LOG_FILE"
}

main

