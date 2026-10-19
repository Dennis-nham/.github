#!/usr/bin/env bash
# =============================================================================
# setup.sh â€” Khá»Ÿi táº¡o tá»± Ä‘á»™ng há»‡ thá»‘ng GitHub Governance cho NLP Labs Vietnam
# =============================================================================
# TĂ¡c giáº£  : Dennis-nham (NHAM QUOC HUAN) Â· @nlp-labs-vietnam
# PhiĂªn báº£n: 1.0.0
# YĂªu cáº§u  : bash â‰¥ 4, git, gh CLI, pnpm
# CĂ¡ch dĂ¹ng: bash setup.sh [--dry-run] [--help]
# =============================================================================

set -euo pipefail

# â”€â”€â”€ Báº«y lá»—i toĂ n cá»¥c â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
trap '_xu_ly_loi $? $LINENO' ERR

_xu_ly_loi() {
  local ma_loi=$1
  local dong=$2
  echo -e "\n${MAU_DO}${BOLD}âŒ Script tháº¥t báº¡i táº¡i dĂ²ng ${dong} (mĂ£ lá»—i: ${ma_loi})${RESET}"
  echo -e "${MAU_VANG}đŸ’¡ Kiá»ƒm tra log phĂ­a trĂªn Ä‘á»ƒ biáº¿t nguyĂªn nhĂ¢n.${RESET}"
  exit "$ma_loi"
}

# â”€â”€â”€ MĂ u sáº¯c terminal (ANSI) â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
MAU_XANH_LA='\033[0;32m'
MAU_XANH_DUONG='\033[0;34m'
MAU_VANG='\033[0;33m'
MAU_DO='\033[0;31m'
MAU_TIM='\033[0;35m'
MAU_CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

# â”€â”€â”€ Biáº¿n cáº¥u hĂ¬nh toĂ n cá»¥c â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
CHE_DO_THU=false
THU_MUC_GOC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THU_MUC_PROFILE="${THU_MUC_GOC}/.profile"
THU_MUC_GITHUB="${THU_MUC_GOC}/.github"

GITHUB_USER="Dennis-nham"
GITHUB_EMAIL="nhamhuan@gmail.com"
GITHUB_ORG="nlp-labs-vietnam"

URL_PROFILE="https://github.com/${GITHUB_USER}/${GITHUB_USER}.git"
URL_ORG_GITHUB="https://github.com/${GITHUB_ORG}/.github.git"
URL_INVESTMENT="https://github.com/${GITHUB_ORG}/investment-platform.git"
URL_IOS_DS="https://github.com/${GITHUB_ORG}/ios-design-system.git"

# â”€â”€â”€ HĂ m tiá»‡n Ă­ch â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
_tieu_de() {
  echo -e "\n${BOLD}${MAU_CYAN}â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•${RESET}"
  echo -e "${BOLD}${MAU_CYAN}  $1${RESET}"
  echo -e "${BOLD}${MAU_CYAN}â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•${RESET}"
}

_buoc() {
  echo -e "\n${MAU_XANH_DUONG}${BOLD}â–¶ $1${RESET}"
}

_thanh_cong() {
  echo -e "${MAU_XANH_LA}  âœ… $1${RESET}"
}

_canh_bao() {
  echo -e "${MAU_VANG}  â ï¸  $1${RESET}"
}

_thong_tin() {
  echo -e "${MAU_TIM}  â„¹  $1${RESET}"
}

_kho_chay() {
  if [[ "$CHE_DO_THU" == true ]]; then
    echo -e "${MAU_VANG}  [DRY-RUN] ${RESET}$*"
  else
    "$@"
  fi
}

# â”€â”€â”€ HĂ m usage() â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
usage() {
  cat <<EOF

${BOLD}${MAU_CYAN}NLP Labs Vietnam â€” GitHub Governance Setup Script${RESET}

${BOLD}CĂ¡ch dĂ¹ng:${RESET}
  bash setup.sh [tuá»³ chá»n]

${BOLD}Tuá»³ chá»n:${RESET}
  --dry-run     Kiá»ƒm tra cĂ¡c bÆ°á»›c sáº½ thá»±c hiá»‡n mĂ  KHĂ”NG thá»±c thi thá»±c sá»±
  --help, -h    Hiá»ƒn thá»‹ trá»£ giĂºp nĂ y

${BOLD}Biáº¿n mĂ´i trÆ°á»ng:${RESET}
  GITHUB_TOKEN    Personal Access Token GitHub (PAT)
                Hoáº·c Ä‘áº·t trong file .env táº¡i thÆ° má»¥c gá»‘c

${BOLD}VĂ­ dá»¥:${RESET}
  bash setup.sh --dry-run       # Kiá»ƒm tra trÆ°á»›c
  bash setup.sh                 # Cháº¡y tháº­t

${BOLD}YĂªu cáº§u:${RESET}
  - git â‰¥ 2.38
  - gh CLI â‰¥ 2.0 (GitHub CLI)
  - pnpm â‰¥ 9
  - Node.js â‰¥ 20

EOF
}

# â”€â”€â”€ PhĂ¢n tĂ­ch tham sá»‘ â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
for arg in "$@"; do
  case $arg in
    --dry-run)  CHE_DO_THU=true ;;
    --help|-h)  usage; exit 0 ;;
    *)
      echo -e "${MAU_DO}âŒ Tham sá»‘ khĂ´ng há»£p lá»‡: $arg${RESET}"
      usage
      exit 1
      ;;
  esac
done

# â”€â”€â”€ Kiá»ƒm tra Ä‘iá»u kiá»‡n tiĂªn quyáº¿t â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
_kiem_tra_yeu_cau() {
  _tieu_de "KIá»‚M TRA ÄIá»€U KIá»†N TIĂN QUYáº¾T"

  local co_loi=false

  _buoc "Kiá»ƒm tra cĂ¡c cĂ´ng cá»¥ cáº§n thiáº¿t..."

  # git
  if command -v git &>/dev/null; then
    local phien_ban_git
    phien_ban_git=$(git --version | awk '{print $3}')
    _thanh_cong "git ${phien_ban_git} â€” Ä‘Ă£ cĂ i Ä‘áº·t"
  else
    echo -e "${MAU_DO}  âŒ git â€” CHÆ¯A CĂ€I Äáº¶T (cĂ i táº¡i: https://git-scm.com)${RESET}"
    co_loi=true
  fi

  # gh CLI
  if command -v gh &>/dev/null; then
    local phien_ban_gh
    phien_ban_gh=$(gh --version | head -1 | awk '{print $3}')
    _thanh_cong "gh CLI ${phien_ban_gh} â€” Ä‘Ă£ cĂ i Ä‘áº·t"
  else
    _canh_bao "gh CLI â€” chÆ°a cĂ i (khuyáº¿n nghá»‹: https://cli.github.com)"
  fi

  # pnpm
  if command -v pnpm &>/dev/null; then
    local phien_ban_pnpm
    phien_ban_pnpm=$(pnpm --version)
    _thanh_cong "pnpm ${phien_ban_pnpm} â€” Ä‘Ă£ cĂ i Ä‘áº·t"
  else
    _canh_bao "pnpm â€” chÆ°a cĂ i (npm install -g pnpm)"
  fi

  # node
  if command -v node &>/dev/null; then
    local phien_ban_node
    phien_ban_node=$(node --version)
    _thanh_cong "Node.js ${phien_ban_node} â€” Ä‘Ă£ cĂ i Ä‘áº·t"
  else
    _canh_bao "Node.js â€” chÆ°a cĂ i (https://nodejs.org)"
  fi

  if [[ "$co_loi" == true ]]; then
    echo -e "\n${MAU_DO}${BOLD}âŒ Má»™t sá»‘ cĂ´ng cá»¥ báº¯t buá»™c chÆ°a Ä‘Æ°á»£c cĂ i Ä‘áº·t. Dá»«ng láº¡i.${RESET}"
    exit 1
  fi

  # Äá»c GITHUB_TOKEN tá»« .env hoáº·c biáº¿n mĂ´i trÆ°á»ng
  _buoc "Kiá»ƒm tra GitHub Token..."
  if [[ -z "${GITHUB_TOKEN:-}" ]]; then
    if [[ -f "${THU_MUC_GOC}/.env" ]]; then
      # shellcheck disable=SC1090
      source "${THU_MUC_GOC}/.env"
    fi
  fi

  if [[ -z "${GITHUB_TOKEN:-}" ]]; then
    echo -e "${MAU_DO}  âŒ GITHUB_TOKEN chÆ°a Ä‘Æ°á»£c thiáº¿t láº­p!${RESET}"
    echo -e "${MAU_VANG}     CĂ¡ch kháº¯c phá»¥c:${RESET}"
    echo -e "     1. ThĂªm vĂ o file .env: ${BOLD}GITHUB_TOKEN=ghp_xxxxxxxxxxxx${RESET}"
    echo -e "     2. Hoáº·c export: ${BOLD}export GITHUB_TOKEN=ghp_xxxxxxxxxxxx${RESET}"
    exit 1
  else
    # Che token â€” chá»‰ hiá»‡n 8 kĂ½ tá»± Ä‘áº§u
    local token_an="${GITHUB_TOKEN:0:8}********************************"
    _thanh_cong "GITHUB_TOKEN Ä‘Ă£ Ä‘Æ°á»£c thiáº¿t láº­p (${token_an})"
  fi

  # Kiá»ƒm tra thÆ° má»¥c .profile tá»“n táº¡i
  _buoc "Kiá»ƒm tra thÆ° má»¥c nguá»“n .profile..."
  local cac_tep_can=(
    "README.md"
    "org-README.md"
    "MAINTAINERS.md"
    "CODEOWNERS"
    "CONTRIBUTING.md"
    "CODE_OF_CONDUCT.md"
    "SPONSORSHIP.md"
    "ARCHITECTURE.md"
    "CHANGELOG.md"
    "FUNDING.yml"
  )
  for tep in "${cac_tep_can[@]}"; do
    if [[ -f "${THU_MUC_PROFILE}/${tep}" ]]; then
      _thanh_cong ".profile/${tep}"
    else
      _canh_bao ".profile/${tep} â€” khĂ´ng tĂ¬m tháº¥y (sáº½ bá» qua)"
    fi
  done
}

# â”€â”€â”€ Cáº¥u hĂ¬nh Git toĂ n cá»¥c â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
_cau_hinh_git() {
  _tieu_de "Cáº¤U HĂŒNH GIT TOĂ€N Cá»¤C"

  _buoc "Thiáº¿t láº­p thĂ´ng tin ngÆ°á»i dĂ¹ng Git..."
  _kho_chay git config --global user.email "${GITHUB_EMAIL}"
  _kho_chay git config --global user.name  "${GITHUB_USER}"
  _thanh_cong "user.email = ${GITHUB_EMAIL}"
  _thanh_cong "user.name  = ${GITHUB_USER}"

  # Thiáº¿t láº­p helper lÆ°u credential
  _kho_chay git config --global credential.helper store
  _thanh_cong "credential.helper = store"
}

# â”€â”€â”€ HĂ m chung: init + commit + push má»™t repo â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
_khoi_tao_va_push_repo() {
  local ten_repo=$1
  local thu_muc=$2
  local url_remote=$3
  local nhanh=${4:-main}

  _buoc "Khá»Ÿi táº¡o git trong: ${thu_muc}"

  if [[ "$CHE_DO_THU" == true ]]; then
    _thong_tin "[DRY-RUN] git init ${thu_muc}"
    _thong_tin "[DRY-RUN] git remote add origin ${url_remote}"
    _thong_tin "[DRY-RUN] git add . && git commit && git push origin ${nhanh}"
    return 0
  fi

  cd "${thu_muc}"

  if [[ ! -d ".git" ]]; then
    git init -b "${nhanh}"
    _thanh_cong "git init -b ${nhanh}"
  else
    _canh_bao "ThÆ° má»¥c Ä‘Ă£ lĂ  git repo â€” bá» qua git init"
  fi

  # Cáº¥u hĂ¬nh remote vá»›i token
  local url_voi_token
  url_voi_token=$(echo "${url_remote}" | sed "s|https://|https://${GITHUB_TOKEN}@|")

  if git remote get-url origin &>/dev/null; then
    git remote set-url origin "${url_voi_token}"
    _canh_bao "Remote origin Ä‘Ă£ tá»“n táº¡i â€” cáº­p nháº­t URL"
  else
    git remote add origin "${url_voi_token}"
    _thanh_cong "git remote add origin (cĂ³ token)"
  fi

  git add .
  if ! git diff --cached --quiet; then
    git commit -m "chore: khá»Ÿi táº¡o ${ten_repo} â€” @nlp-labs-vietnam governance [bot]"
    _thanh_cong "ÄĂ£ commit"
  else
    _canh_bao "KhĂ´ng cĂ³ thay Ä‘á»•i Ä‘á»ƒ commit"
  fi

  git push -u origin "${nhanh}" --force-with-lease 2>/dev/null \
    || git push -u origin "${nhanh}" --force
  _thanh_cong "Push lĂªn ${url_remote} (nhĂ¡nh: ${nhanh})"

  cd "${THU_MUC_GOC}"
}

# â”€â”€â”€ 1. Personal Profile Repository â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
_khoi_tao_profile_repo() {
  _tieu_de "1. PERSONAL PROFILE REPO â€” Dennis-nham/Dennis-nham"

  local thu_muc_dich="${THU_MUC_GOC}/tmp-deploy/Dennis-nham"

  _buoc "Chuáº©n bá»‹ thÆ° má»¥c deploy..."
  _kho_chay rm -rf "${thu_muc_dich}"
  _kho_chay mkdir -p "${thu_muc_dich}"

  _buoc "Copy README.md tá»« .profile/..."
  if [[ -f "${THU_MUC_PROFILE}/README.md" ]]; then
    _kho_chay cp "${THU_MUC_PROFILE}/README.md" "${thu_muc_dich}/README.md"
    _thanh_cong "README.md Ä‘Ă£ copy"
  else
    echo -e "${MAU_DO}  âŒ KhĂ´ng tĂ¬m tháº¥y .profile/README.md${RESET}"
    exit 1
  fi

  _khoi_tao_va_push_repo \
    "Dennis-nham/Dennis-nham" \
    "${thu_muc_dich}" \
    "${URL_PROFILE}" \
    "main"

  _thanh_cong "âœ… Personal profile repo hoĂ n táº¥t â†’ ${URL_PROFILE}"
}

# â”€â”€â”€ 2. Organization .github Repository â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
_khoi_tao_org_github_repo() {
  _tieu_de "2. ORG GOVERNANCE REPO â€” nlp-labs-vietnam/.github"

  local thu_muc_dich="${THU_MUC_GOC}/tmp-deploy/nlp-github"

  _buoc "Chuáº©n bá»‹ cáº¥u trĂºc thÆ° má»¥c..."
  _kho_chay rm -rf "${thu_muc_dich}"
  _kho_chay mkdir -p "${thu_muc_dich}/profile"
  _kho_chay mkdir -p "${thu_muc_dich}/.github/workflows"
  _kho_chay mkdir -p "${thu_muc_dich}/.github/ISSUE_TEMPLATE"

  _buoc "Copy tá»‡p governance..."

  # HĂ m copy an toĂ n
  _copy_neu_ton_tai() {
    local nguon=$1
    local dich=$2
    if [[ -f "$nguon" ]]; then
      if [[ "$CHE_DO_THU" == false ]]; then
        cp "$nguon" "$dich"
      fi
      _thanh_cong "$(basename "$nguon") â†’ $(echo "$dich" | sed "s|${thu_muc_dich}/||")"
    else
      _canh_bao "Bá» qua: $(basename "$nguon") (khĂ´ng tĂ¬m tháº¥y)"
    fi
  }

  _copy_neu_ton_tai "${THU_MUC_PROFILE}/org-README.md"      "${thu_muc_dich}/profile/README.md"
  _copy_neu_ton_tai "${THU_MUC_PROFILE}/MAINTAINERS.md"     "${thu_muc_dich}/MAINTAINERS.md"
  _copy_neu_ton_tai "${THU_MUC_PROFILE}/CODEOWNERS"         "${thu_muc_dich}/CODEOWNERS"
  _copy_neu_ton_tai "${THU_MUC_PROFILE}/CONTRIBUTING.md"    "${thu_muc_dich}/CONTRIBUTING.md"
  _copy_neu_ton_tai "${THU_MUC_PROFILE}/CODE_OF_CONDUCT.md" "${thu_muc_dich}/CODE_OF_CONDUCT.md"
  _copy_neu_ton_tai "${THU_MUC_PROFILE}/CHANGELOG.md"       "${thu_muc_dich}/CHANGELOG.md"
  _copy_neu_ton_tai "${THU_MUC_PROFILE}/SPONSORSHIP.md"     "${thu_muc_dich}/SPONSORSHIP.md"
  _copy_neu_ton_tai "${THU_MUC_PROFILE}/ARCHITECTURE.md"    "${thu_muc_dich}/ARCHITECTURE.md"
  _copy_neu_ton_tai "${THU_MUC_PROFILE}/FUNDING.yml"        "${thu_muc_dich}/.github/FUNDING.yml"

  # Copy GitHub Actions workflows
  if [[ -d "${THU_MUC_GITHUB}/workflows" ]]; then
    for tep_wf in "${THU_MUC_GITHUB}/workflows/"*.yml; do
      [[ -f "$tep_wf" ]] || continue
      _copy_neu_ton_tai "$tep_wf" "${thu_muc_dich}/.github/workflows/$(basename "$tep_wf")"
    done
  fi

  # Táº¡o issue templates
  _buoc "Táº¡o Issue Templates..."
  if [[ "$CHE_DO_THU" == false ]]; then
    cat > "${thu_muc_dich}/.github/ISSUE_TEMPLATE/bug_report.md" <<'TMPL'
---
name: đŸ› BĂ¡o cĂ¡o lá»—i
about: Táº¡o bĂ¡o cĂ¡o Ä‘á»ƒ giĂºp chĂºng tĂ´i cáº£i thiá»‡n
title: "[BUG] "
labels: bug
assignees: Dennis-nham
---

## MĂ´ táº£ lá»—i
<!-- MĂ´ táº£ rĂµ rĂ ng vĂ  sĂºc tĂ­ch vá» lá»—i -->

## BÆ°á»›c tĂ¡i hiá»‡n
1. Äi Ä‘áº¿n '...'
2. Click vĂ o '...'
3. Cuá»™n xuá»‘ng Ä‘áº¿n '...'
4. Tháº¥y lá»—i

## HĂ nh vi mong Ä‘á»£i
<!-- MĂ´ táº£ báº¡n mong Ä‘á»£i Ä‘iá»u gĂ¬ xáº£y ra -->

## Screenshots
<!-- Náº¿u cĂ³, thĂªm áº£nh chá»¥p mĂ n hĂ¬nh Ä‘á»ƒ giáº£i thĂ­ch váº¥n Ä‘á» -->

## MĂ´i trÆ°á»ng
- OS: [e.g. macOS 14, Ubuntu 22.04]
- Node: [e.g. 20.11.0]
- pnpm: [e.g. 9.0.0]
- Browser (náº¿u UI): [e.g. Chrome 124]

## ThĂ´ng tin bá»• sung
<!-- Báº¥t ká»³ thĂ´ng tin nĂ o khĂ¡c vá» váº¥n Ä‘á» -->
TMPL
    _thanh_cong "bug_report.md"

    cat > "${thu_muc_dich}/.github/ISSUE_TEMPLATE/feature_request.md" <<'TMPL'
---
name: đŸ’¡ Äá» xuáº¥t tĂ­nh nÄƒng
about: Äá» xuáº¥t Ă½ tÆ°á»Ÿng cho dá»± Ă¡n nĂ y
title: "[FEAT] "
labels: enhancement
assignees: Dennis-nham
---

## BĂ i toĂ¡n Ä‘ang gáº·p pháº£i
<!-- MĂ´ táº£ bĂ i toĂ¡n. VĂ­ dá»¥: TĂ´i luĂ´n bá»±c bá»™i khi [...] -->

## Giáº£i phĂ¡p Ä‘á» xuáº¥t
<!-- MĂ´ táº£ giáº£i phĂ¡p báº¡n muá»‘n -->

## Alternatives Ä‘Ă£ xem xĂ©t
<!-- MĂ´ táº£ cĂ¡c giáº£i phĂ¡p thay tháº¿ báº¡n Ä‘Ă£ cĂ¢n nháº¯c -->

## ThĂ´ng tin bá»• sung
<!-- ThĂªm context, screenshots, mockups vá» feature request -->
TMPL
    _thanh_cong "feature_request.md"

    cat > "${thu_muc_dich}/.github/ISSUE_TEMPLATE/sponsorship_inquiry.md" <<'TMPL'
---
name: đŸ’ Há»i vá» tĂ i trá»£
about: LiĂªn há»‡ vá» cÆ¡ há»™i tĂ i trá»£ vĂ  há»£p tĂ¡c
title: "[SPONSOR] "
labels: sponsorship
assignees: Dennis-nham
---

## Tá»• chá»©c / CĂ¡ nhĂ¢n
- **TĂªn:** 
- **Website:** 
- **LÄ©nh vá»±c:** 

## Loáº¡i há»£p tĂ¡c quan tĂ¢m
- [ ] Cloud Credits (Infrastructure Sponsor)
- [ ] Corporate Sponsorship ($50kâ€“$500k)
- [ ] VC Investment ($1M+)
- [ ] Strategic Partnership (MOU)
- [ ] Community Sponsor (GitHub Sponsors)

## MĂ´ táº£ ngáº¯n vá» Ä‘á» xuáº¥t há»£p tĂ¡c

## ThĂ´ng tin liĂªn há»‡
- **Email:** 
- **LinkedIn:** 
TMPL
    _thanh_cong "sponsorship_inquiry.md"
  fi

  _khoi_tao_va_push_repo \
    "nlp-labs-vietnam/.github" \
    "${thu_muc_dich}" \
    "${URL_ORG_GITHUB}" \
    "main"

  _thanh_cong "âœ… Org .github repo hoĂ n táº¥t â†’ ${URL_ORG_GITHUB}"
}

# â”€â”€â”€ 3. Monorepo scaffold â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
_tao_cau_truc_monorepo() {
  local ten_repo=$1
  local thu_muc_dich="${THU_MUC_GOC}/tmp-deploy/${ten_repo}"

  _buoc "Táº¡o cáº¥u trĂºc thÆ° má»¥c monorepo: ${ten_repo}..."
  _kho_chay rm -rf "${thu_muc_dich}"
  _kho_chay mkdir -p "${thu_muc_dich}"/{apps,packages,services,tools,libs}
  _kho_chay mkdir -p "${thu_muc_dich}/.github/workflows"

  if [[ "$CHE_DO_THU" == false ]]; then

    # pnpm-workspace.yaml
    cat > "${thu_muc_dich}/pnpm-workspace.yaml" <<'YAML'
packages:
  - "packages/*"
  - "apps/*"
  - "services/*"
  - "tools/*"
  - "libs/*"
YAML
    _thanh_cong "pnpm-workspace.yaml"

    # turbo.json
    cat > "${thu_muc_dich}/turbo.json" <<'JSON'
{
  "$schema": "https://turbo.build/schema.json",
  "pipeline": {
    "build": {
      "dependsOn": ["^build"],
      "outputs": ["dist/**", ".next/**", "build/**"]
    },
    "dev": {
      "cache": false,
      "persistent": true
    },
    "test": {
      "dependsOn": ["build"],
      "outputs": ["coverage/**"]
    },
    "lint": {
      "outputs": []
    },
    "typecheck": {
      "dependsOn": ["^build"],
      "outputs": []
    },
    "clean": {
      "cache": false
    }
  }
}
JSON
    _thanh_cong "turbo.json"

    # package.json gá»‘c
    cat > "${thu_muc_dich}/package.json" <<JSON
{
  "name": "@nlp-labs-vietnam/${ten_repo}",
  "version": "0.1.0",
  "private": true,
  "description": "NLP Labs Vietnam â€” ${ten_repo}",
  "scripts": {
    "build": "turbo run build",
    "dev": "turbo run dev",
    "test": "turbo run test",
    "lint": "turbo run lint",
    "typecheck": "turbo run typecheck",
    "clean": "turbo run clean && rm -rf node_modules"
  },
  "devDependencies": {
    "turbo": "^2.0.0"
  },
  "engines": {
    "node": ">=20",
    "pnpm": ">=9"
  },
  "packageManager": "pnpm@9.0.0"
}
JSON
    _thanh_cong "package.json"

    # .npmrc
    cat > "${thu_muc_dich}/.npmrc" <<'NPMRC'
auto-install-peers=true
strict-peer-dependencies=false
NPMRC
    _thanh_cong ".npmrc"

    # .gitignore
    cat > "${thu_muc_dich}/.gitignore" <<'IGNORE'
# Dependencies
node_modules/
.pnpm-store/

# Build outputs
dist/
build/
.next/
out/
.turbo/

# Environment
.env
.env.local
.env.*.local

# OS
.DS_Store
Thumbs.db

# IDE
.vscode/
.idea/
*.swp

# Testing
coverage/

# Logs
*.log
npm-debug.log*
IGNORE
    _thanh_cong ".gitignore"

    # .env.example
    cat > "${thu_muc_dich}/.env.example" <<'ENV'
# Sao chĂ©p file nĂ y thĂ nh .env vĂ  Ä‘iá»n giĂ¡ trá»‹ thá»±c
# KHĂ”NG bao giá» commit file .env lĂªn git

# GitHub Personal Access Token
GITHUB_TOKEN=

# Database
DATABASE_URL=

# API Keys (thay báº±ng giĂ¡ trá»‹ thá»±c)
OPENAI_API_KEY=
MILVUS_HOST=localhost
MILVUS_PORT=19530

# Kafka
KAFKA_BROKERS=localhost:9092

# RabbitMQ
RABBITMQ_URL=amqp://localhost:5672
ENV
    _thanh_cong ".env.example"

    # README.md placeholder
    cat > "${thu_muc_dich}/README.md" <<MD
# ${ten_repo}

> **@nlp-labs-vietnam** â€” NLP Labs Vietnam

Xem [ARCHITECTURE.md](./ARCHITECTURE.md) Ä‘á»ƒ hiá»ƒu toĂ n bá»™ cáº¥u trĂºc há»‡ thá»‘ng.

## CĂ i Ä‘áº·t

\`\`\`bash
pnpm install
pnpm build
pnpm dev
\`\`\`

## TĂ i liá»‡u

- [CONTRIBUTING.md](./CONTRIBUTING.md)
- [ARCHITECTURE.md](./ARCHITECTURE.md)
- [SPONSORSHIP.md](./SPONSORSHIP.md)
MD
    _thanh_cong "README.md"

    # CI workflow
    cat > "${thu_muc_dich}/.github/workflows/ci.yml" <<'YML'
name: CI

on:
  push:
    branches: [main]
  pull_request:

jobs:
  ci:
    name: Lint Â· Typecheck Â· Test Â· Build
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: pnpm/action-setup@v3
        with:
          version: 9

      - uses: actions/setup-node@v4
        with:
          node-version: 20
          cache: pnpm

      - name: CĂ i Ä‘áº·t dependencies
        run: pnpm install --frozen-lockfile

      - name: Lint + Typecheck + Test + Build
        run: pnpm turbo run lint typecheck test build
YML
    _thanh_cong ".github/workflows/ci.yml"

  fi # háº¿t CHE_DO_THU == false

  # Copy governance docs
  _buoc "Copy tá»‡p governance vĂ o ${ten_repo}..."
  local gov_files=(
    "MAINTAINERS.md"
    "CONTRIBUTING.md"
    "CODE_OF_CONDUCT.md"
    "CHANGELOG.md"
    "SPONSORSHIP.md"
    "ARCHITECTURE.md"
  )
  for tep in "${gov_files[@]}"; do
    if [[ -f "${THU_MUC_PROFILE}/${tep}" ]]; then
      [[ "$CHE_DO_THU" == false ]] && cp "${THU_MUC_PROFILE}/${tep}" "${thu_muc_dich}/${tep}"
      _thanh_cong "${tep}"
    fi
  done

  # CODEOWNERS
  if [[ -f "${THU_MUC_PROFILE}/CODEOWNERS" ]]; then
    [[ "$CHE_DO_THU" == false ]] && cp "${THU_MUC_PROFILE}/CODEOWNERS" "${thu_muc_dich}/.github/CODEOWNERS"
    _thanh_cong ".github/CODEOWNERS"
  fi
}

_deploy_monorepo() {
  local ten_repo=$1
  local url_remote=$2

  _tieu_de "$(echo "$ten_repo" | tr '[:lower:]' '[:upper:]') â€” nlp-labs-vietnam/${ten_repo}"
  _tao_cau_truc_monorepo "${ten_repo}"
  _khoi_tao_va_push_repo \
    "nlp-labs-vietnam/${ten_repo}" \
    "${THU_MUC_GOC}/tmp-deploy/${ten_repo}" \
    "${url_remote}" \
    "main"
  _thanh_cong "âœ… ${ten_repo} hoĂ n táº¥t â†’ ${url_remote}"
}

# â”€â”€â”€ Dá»n dáº¹p thÆ° má»¥c táº¡m â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
_don_dep() {
  _tieu_de "Dá»ŒN Dáº¸P"
  if [[ "$CHE_DO_THU" == false ]]; then
    rm -rf "${THU_MUC_GOC}/tmp-deploy"
    _thanh_cong "ÄĂ£ xĂ³a thÆ° má»¥c táº¡m tmp-deploy/"
  else
    _thong_tin "[DRY-RUN] Bá» qua dá»n dáº¹p"
  fi
}

# â”€â”€â”€ TĂ³m táº¯t káº¿t quáº£ â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
_tom_tat() {
  _tieu_de "TĂ“M Táº®T Káº¾T QUáº¢"
  echo -e "${BOLD}CĂ¡c repo Ä‘Ă£ Ä‘Æ°á»£c khá»Ÿi táº¡o vĂ  push:${RESET}"
  echo -e "  ${MAU_XANH_LA}âœ…${RESET} ${URL_PROFILE}"
  echo -e "  ${MAU_XANH_LA}âœ…${RESET} ${URL_ORG_GITHUB}"
  echo -e "  ${MAU_XANH_LA}âœ…${RESET} ${URL_INVESTMENT}"
  echo -e "  ${MAU_XANH_LA}âœ…${RESET} ${URL_IOS_DS}"
  echo ""
  echo -e "${BOLD}BÆ°á»›c tiáº¿p theo:${RESET}"
  echo -e "  1. VĂ o ${MAU_CYAN}github.com/organizations/nlp-labs-vietnam/settings/profile${RESET}"
  echo -e "     â†’ Enable GitHub Sponsors cho org"
  echo -e "  2. ÄÄƒng kĂ½ secrets táº¡i:"
  echo -e "     ${MAU_CYAN}github.com/Dennis-nham/Dennis-nham/settings/secrets/actions${RESET}"
  echo -e "     â€¢ GITHUB_TOKEN    (Personal Access Token)"
  echo -e "     â€¢ NLP_LABS_ORG_TOKEN (PAT cĂ³ quyá»n admin:org)"
  echo -e "  3. Ná»™p Ä‘Æ¡n Google for Startups: ${MAU_CYAN}cloud.google.com/startup${RESET}"
  echo ""
  if [[ "$CHE_DO_THU" == true ]]; then
    echo -e "${MAU_VANG}${BOLD}â ï¸  ÄĂ‚Y LĂ€ Káº¾T QUáº¢ DRY-RUN â€” KhĂ´ng cĂ³ thay Ä‘á»•i nĂ o Ä‘Æ°á»£c thá»±c thi.${RESET}"
    echo -e "${MAU_VANG}   Cháº¡y láº¡i khĂ´ng cĂ³ --dry-run Ä‘á»ƒ thá»±c thi tháº­t.${RESET}"
  fi
}

# â”€â”€â”€ MAIN â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
main() {
  echo -e "\n${BOLD}${MAU_CYAN}"
  echo "  â•”â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•—"
  echo "  â•‘     NLP Labs Vietnam â€” GitHub Governance Setup       â•‘"
  echo "  â•‘     @Dennis-nham Â· NLP GROUP JSC Â· 2025              â•‘"
  echo "  â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•"
  echo -e "${RESET}"

  if [[ "$CHE_DO_THU" == true ]]; then
    echo -e "${MAU_VANG}${BOLD}  â ï¸  CHáº¾ Äá»˜ DRY-RUN â€” Chá»‰ mĂ´ phá»ng, khĂ´ng thá»±c thi${RESET}\n"
  fi

  _kiem_tra_yeu_cau
  _cau_hinh_git

  _khoi_tao_profile_repo
  _khoi_tao_org_github_repo
  _deploy_monorepo "investment-platform" "${URL_INVESTMENT}"
  _deploy_monorepo "ios-design-system"   "${URL_IOS_DS}"

  _don_dep
  _tom_tat

  echo -e "\n${MAU_XANH_LA}${BOLD}đŸ‰ HoĂ n táº¥t! Há»‡ thá»‘ng governance cá»§a @nlp-labs-vietnam Ä‘Ă£ Ä‘Æ°á»£c khá»Ÿi táº¡o.${RESET}\n"
}

main "$@"

