#!/usr/bin/env bash
# =============================================================================
# setup.sh — Khởi tạo tự động hệ thống GitHub Governance cho NLP Labs Vietnam
# =============================================================================
# Tác giả  : Dennis-nham (NHAM QUOC HUAN) · @nlp-labs-vietnam
# Phiên bản: 1.0.0
# Yêu cầu  : bash ≥ 4, git, gh CLI, pnpm
# Cách dùng: bash setup.sh [--dry-run] [--help]
# =============================================================================

set -euo pipefail

# ─── Bẫy lỗi toàn cục ────────────────────────────────────────────────────────
trap '_xu_ly_loi $? $LINENO' ERR

_xu_ly_loi() {
  local ma_loi=$1
  local dong=$2
  echo -e "\n${MAU_DO}${BOLD}❌ Script thất bại tại dòng ${dong} (mã lỗi: ${ma_loi})${RESET}"
  echo -e "${MAU_VANG}💡 Kiểm tra log phía trên để biết nguyên nhân.${RESET}"
  exit "$ma_loi"
}

# ─── Màu sắc terminal (ANSI) ─────────────────────────────────────────────────
MAU_XANH_LA='\033[0;32m'
MAU_XANH_DUONG='\033[0;34m'
MAU_VANG='\033[0;33m'
MAU_DO='\033[0;31m'
MAU_TIM='\033[0;35m'
MAU_CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

# ─── Biến cấu hình toàn cục ──────────────────────────────────────────────────
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

# ─── Hàm tiện ích ────────────────────────────────────────────────────────────
_tieu_de() {
  echo -e "\n${BOLD}${MAU_CYAN}══════════════════════════════════════════════════════${RESET}"
  echo -e "${BOLD}${MAU_CYAN}  $1${RESET}"
  echo -e "${BOLD}${MAU_CYAN}══════════════════════════════════════════════════════${RESET}"
}

_buoc() {
  echo -e "\n${MAU_XANH_DUONG}${BOLD}▶ $1${RESET}"
}

_thanh_cong() {
  echo -e "${MAU_XANH_LA}  ✅ $1${RESET}"
}

_canh_bao() {
  echo -e "${MAU_VANG}  ⚠️  $1${RESET}"
}

_thong_tin() {
  echo -e "${MAU_TIM}  ℹ  $1${RESET}"
}

_kho_chay() {
  if [[ "$CHE_DO_THU" == true ]]; then
    echo -e "${MAU_VANG}  [DRY-RUN] ${RESET}$*"
  else
    "$@"
  fi
}

# ─── Hàm usage() ─────────────────────────────────────────────────────────────
usage() {
  cat <<EOF

${BOLD}${MAU_CYAN}NLP Labs Vietnam — GitHub Governance Setup Script${RESET}

${BOLD}Cách dùng:${RESET}
  bash setup.sh [tuỳ chọn]

${BOLD}Tuỳ chọn:${RESET}
  --dry-run     Kiểm tra các bước sẽ thực hiện mà KHÔNG thực thi thực sự
  --help, -h    Hiển thị trợ giúp này

${BOLD}Biến môi trường:${RESET}
  GITHUB_KEY    Personal Access Token GitHub (PAT)
                Hoặc đặt trong file .env tại thư mục gốc

${BOLD}Ví dụ:${RESET}
  bash setup.sh --dry-run       # Kiểm tra trước
  bash setup.sh                 # Chạy thật

${BOLD}Yêu cầu:${RESET}
  - git ≥ 2.38
  - gh CLI ≥ 2.0 (GitHub CLI)
  - pnpm ≥ 9
  - Node.js ≥ 20

EOF
}

# ─── Phân tích tham số ────────────────────────────────────────────────────────
for arg in "$@"; do
  case $arg in
    --dry-run)  CHE_DO_THU=true ;;
    --help|-h)  usage; exit 0 ;;
    *)
      echo -e "${MAU_DO}❌ Tham số không hợp lệ: $arg${RESET}"
      usage
      exit 1
      ;;
  esac
done

# ─── Kiểm tra điều kiện tiên quyết ───────────────────────────────────────────
_kiem_tra_yeu_cau() {
  _tieu_de "KIỂM TRA ĐIỀU KIỆN TIÊN QUYẾT"

  local co_loi=false

  _buoc "Kiểm tra các công cụ cần thiết..."

  # git
  if command -v git &>/dev/null; then
    local phien_ban_git
    phien_ban_git=$(git --version | awk '{print $3}')
    _thanh_cong "git ${phien_ban_git} — đã cài đặt"
  else
    echo -e "${MAU_DO}  ❌ git — CHƯA CÀI ĐẶT (cài tại: https://git-scm.com)${RESET}"
    co_loi=true
  fi

  # gh CLI
  if command -v gh &>/dev/null; then
    local phien_ban_gh
    phien_ban_gh=$(gh --version | head -1 | awk '{print $3}')
    _thanh_cong "gh CLI ${phien_ban_gh} — đã cài đặt"
  else
    _canh_bao "gh CLI — chưa cài (khuyến nghị: https://cli.github.com)"
  fi

  # pnpm
  if command -v pnpm &>/dev/null; then
    local phien_ban_pnpm
    phien_ban_pnpm=$(pnpm --version)
    _thanh_cong "pnpm ${phien_ban_pnpm} — đã cài đặt"
  else
    _canh_bao "pnpm — chưa cài (npm install -g pnpm)"
  fi

  # node
  if command -v node &>/dev/null; then
    local phien_ban_node
    phien_ban_node=$(node --version)
    _thanh_cong "Node.js ${phien_ban_node} — đã cài đặt"
  else
    _canh_bao "Node.js — chưa cài (https://nodejs.org)"
  fi

  if [[ "$co_loi" == true ]]; then
    echo -e "\n${MAU_DO}${BOLD}❌ Một số công cụ bắt buộc chưa được cài đặt. Dừng lại.${RESET}"
    exit 1
  fi

  # Đọc GITHUB_KEY từ .env hoặc biến môi trường
  _buoc "Kiểm tra GitHub Token..."
  if [[ -z "${GITHUB_KEY:-}" ]]; then
    if [[ -f "${THU_MUC_GOC}/.env" ]]; then
      # shellcheck disable=SC1090
      source "${THU_MUC_GOC}/.env"
    fi
  fi

  if [[ -z "${GITHUB_KEY:-}" ]]; then
    echo -e "${MAU_DO}  ❌ GITHUB_KEY chưa được thiết lập!${RESET}"
    echo -e "${MAU_VANG}     Cách khắc phục:${RESET}"
    echo -e "     1. Thêm vào file .env: ${BOLD}GITHUB_KEY=ghp_xxxxxxxxxxxx${RESET}"
    echo -e "     2. Hoặc export: ${BOLD}export GITHUB_KEY=ghp_xxxxxxxxxxxx${RESET}"
    exit 1
  else
    # Che token — chỉ hiện 8 ký tự đầu
    local token_an="${GITHUB_KEY:0:8}********************************"
    _thanh_cong "GITHUB_KEY đã được thiết lập (${token_an})"
  fi

  # Kiểm tra thư mục .profile tồn tại
  _buoc "Kiểm tra thư mục nguồn .profile..."
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
      _canh_bao ".profile/${tep} — không tìm thấy (sẽ bỏ qua)"
    fi
  done
}

# ─── Cấu hình Git toàn cục ───────────────────────────────────────────────────
_cau_hinh_git() {
  _tieu_de "CẤU HÌNH GIT TOÀN CỤC"

  _buoc "Thiết lập thông tin người dùng Git..."
  _kho_chay git config --global user.email "${GITHUB_EMAIL}"
  _kho_chay git config --global user.name  "${GITHUB_USER}"
  _thanh_cong "user.email = ${GITHUB_EMAIL}"
  _thanh_cong "user.name  = ${GITHUB_USER}"

  # Thiết lập helper lưu credential
  _kho_chay git config --global credential.helper store
  _thanh_cong "credential.helper = store"
}

# ─── Hàm chung: init + commit + push một repo ─────────────────────────────────
_khoi_tao_va_push_repo() {
  local ten_repo=$1
  local thu_muc=$2
  local url_remote=$3
  local nhanh=${4:-main}

  _buoc "Khởi tạo git trong: ${thu_muc}"

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
    _canh_bao "Thư mục đã là git repo — bỏ qua git init"
  fi

  # Cấu hình remote với token
  local url_voi_token
  url_voi_token=$(echo "${url_remote}" | sed "s|https://|https://${GITHUB_KEY}@|")

  if git remote get-url origin &>/dev/null; then
    git remote set-url origin "${url_voi_token}"
    _canh_bao "Remote origin đã tồn tại — cập nhật URL"
  else
    git remote add origin "${url_voi_token}"
    _thanh_cong "git remote add origin (có token)"
  fi

  git add .
  if ! git diff --cached --quiet; then
    git commit -m "chore: khởi tạo ${ten_repo} — @nlp-labs-vietnam governance [bot]"
    _thanh_cong "Đã commit"
  else
    _canh_bao "Không có thay đổi để commit"
  fi

  git push -u origin "${nhanh}" --force-with-lease 2>/dev/null \
    || git push -u origin "${nhanh}" --force
  _thanh_cong "Push lên ${url_remote} (nhánh: ${nhanh})"

  cd "${THU_MUC_GOC}"
}

# ─── 1. Personal Profile Repository ─────────────────────────────────────────
_khoi_tao_profile_repo() {
  _tieu_de "1. PERSONAL PROFILE REPO — Dennis-nham/Dennis-nham"

  local thu_muc_dich="${THU_MUC_GOC}/tmp-deploy/Dennis-nham"

  _buoc "Chuẩn bị thư mục deploy..."
  _kho_chay rm -rf "${thu_muc_dich}"
  _kho_chay mkdir -p "${thu_muc_dich}"

  _buoc "Copy README.md từ .profile/..."
  if [[ -f "${THU_MUC_PROFILE}/README.md" ]]; then
    _kho_chay cp "${THU_MUC_PROFILE}/README.md" "${thu_muc_dich}/README.md"
    _thanh_cong "README.md đã copy"
  else
    echo -e "${MAU_DO}  ❌ Không tìm thấy .profile/README.md${RESET}"
    exit 1
  fi

  _khoi_tao_va_push_repo \
    "Dennis-nham/Dennis-nham" \
    "${thu_muc_dich}" \
    "${URL_PROFILE}" \
    "main"

  _thanh_cong "✅ Personal profile repo hoàn tất → ${URL_PROFILE}"
}

# ─── 2. Organization .github Repository ──────────────────────────────────────
_khoi_tao_org_github_repo() {
  _tieu_de "2. ORG GOVERNANCE REPO — nlp-labs-vietnam/.github"

  local thu_muc_dich="${THU_MUC_GOC}/tmp-deploy/nlp-github"

  _buoc "Chuẩn bị cấu trúc thư mục..."
  _kho_chay rm -rf "${thu_muc_dich}"
  _kho_chay mkdir -p "${thu_muc_dich}/profile"
  _kho_chay mkdir -p "${thu_muc_dich}/.github/workflows"
  _kho_chay mkdir -p "${thu_muc_dich}/.github/ISSUE_TEMPLATE"

  _buoc "Copy tệp governance..."

  # Hàm copy an toàn
  _copy_neu_ton_tai() {
    local nguon=$1
    local dich=$2
    if [[ -f "$nguon" ]]; then
      if [[ "$CHE_DO_THU" == false ]]; then
        cp "$nguon" "$dich"
      fi
      _thanh_cong "$(basename "$nguon") → $(echo "$dich" | sed "s|${thu_muc_dich}/||")"
    else
      _canh_bao "Bỏ qua: $(basename "$nguon") (không tìm thấy)"
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

  # Tạo issue templates
  _buoc "Tạo Issue Templates..."
  if [[ "$CHE_DO_THU" == false ]]; then
    cat > "${thu_muc_dich}/.github/ISSUE_TEMPLATE/bug_report.md" <<'TMPL'
---
name: 🐛 Báo cáo lỗi
about: Tạo báo cáo để giúp chúng tôi cải thiện
title: "[BUG] "
labels: bug
assignees: Dennis-nham
---

## Mô tả lỗi
<!-- Mô tả rõ ràng và súc tích về lỗi -->

## Bước tái hiện
1. Đi đến '...'
2. Click vào '...'
3. Cuộn xuống đến '...'
4. Thấy lỗi

## Hành vi mong đợi
<!-- Mô tả bạn mong đợi điều gì xảy ra -->

## Screenshots
<!-- Nếu có, thêm ảnh chụp màn hình để giải thích vấn đề -->

## Môi trường
- OS: [e.g. macOS 14, Ubuntu 22.04]
- Node: [e.g. 20.11.0]
- pnpm: [e.g. 9.0.0]
- Browser (nếu UI): [e.g. Chrome 124]

## Thông tin bổ sung
<!-- Bất kỳ thông tin nào khác về vấn đề -->
TMPL
    _thanh_cong "bug_report.md"

    cat > "${thu_muc_dich}/.github/ISSUE_TEMPLATE/feature_request.md" <<'TMPL'
---
name: 💡 Đề xuất tính năng
about: Đề xuất ý tưởng cho dự án này
title: "[FEAT] "
labels: enhancement
assignees: Dennis-nham
---

## Bài toán đang gặp phải
<!-- Mô tả bài toán. Ví dụ: Tôi luôn bực bội khi [...] -->

## Giải pháp đề xuất
<!-- Mô tả giải pháp bạn muốn -->

## Alternatives đã xem xét
<!-- Mô tả các giải pháp thay thế bạn đã cân nhắc -->

## Thông tin bổ sung
<!-- Thêm context, screenshots, mockups về feature request -->
TMPL
    _thanh_cong "feature_request.md"

    cat > "${thu_muc_dich}/.github/ISSUE_TEMPLATE/sponsorship_inquiry.md" <<'TMPL'
---
name: 💚 Hỏi về tài trợ
about: Liên hệ về cơ hội tài trợ và hợp tác
title: "[SPONSOR] "
labels: sponsorship
assignees: Dennis-nham
---

## Tổ chức / Cá nhân
- **Tên:** 
- **Website:** 
- **Lĩnh vực:** 

## Loại hợp tác quan tâm
- [ ] Cloud Credits (Infrastructure Sponsor)
- [ ] Corporate Sponsorship ($50k–$500k)
- [ ] VC Investment ($1M+)
- [ ] Strategic Partnership (MOU)
- [ ] Community Sponsor (GitHub Sponsors)

## Mô tả ngắn về đề xuất hợp tác

## Thông tin liên hệ
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

  _thanh_cong "✅ Org .github repo hoàn tất → ${URL_ORG_GITHUB}"
}

# ─── 3. Monorepo scaffold ─────────────────────────────────────────────────────
_tao_cau_truc_monorepo() {
  local ten_repo=$1
  local thu_muc_dich="${THU_MUC_GOC}/tmp-deploy/${ten_repo}"

  _buoc "Tạo cấu trúc thư mục monorepo: ${ten_repo}..."
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

    # package.json gốc
    cat > "${thu_muc_dich}/package.json" <<JSON
{
  "name": "@nlp-labs-vietnam/${ten_repo}",
  "version": "0.1.0",
  "private": true,
  "description": "NLP Labs Vietnam — ${ten_repo}",
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
# Sao chép file này thành .env và điền giá trị thực
# KHÔNG bao giờ commit file .env lên git

# GitHub Personal Access Token
GITHUB_KEY=

# Database
DATABASE_URL=

# API Keys (thay bằng giá trị thực)
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

> **@nlp-labs-vietnam** — NLP Labs Vietnam

Xem [ARCHITECTURE.md](./ARCHITECTURE.md) để hiểu toàn bộ cấu trúc hệ thống.

## Cài đặt

\`\`\`bash
pnpm install
pnpm build
pnpm dev
\`\`\`

## Tài liệu

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
    name: Lint · Typecheck · Test · Build
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

      - name: Cài đặt dependencies
        run: pnpm install --frozen-lockfile

      - name: Lint + Typecheck + Test + Build
        run: pnpm turbo run lint typecheck test build
YML
    _thanh_cong ".github/workflows/ci.yml"

  fi # hết CHE_DO_THU == false

  # Copy governance docs
  _buoc "Copy tệp governance vào ${ten_repo}..."
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

  _tieu_de "$(echo "$ten_repo" | tr '[:lower:]' '[:upper:]') — nlp-labs-vietnam/${ten_repo}"
  _tao_cau_truc_monorepo "${ten_repo}"
  _khoi_tao_va_push_repo \
    "nlp-labs-vietnam/${ten_repo}" \
    "${THU_MUC_GOC}/tmp-deploy/${ten_repo}" \
    "${url_remote}" \
    "main"
  _thanh_cong "✅ ${ten_repo} hoàn tất → ${url_remote}"
}

# ─── Dọn dẹp thư mục tạm ────────────────────────────────────────────────────
_don_dep() {
  _tieu_de "DỌN DẸP"
  if [[ "$CHE_DO_THU" == false ]]; then
    rm -rf "${THU_MUC_GOC}/tmp-deploy"
    _thanh_cong "Đã xóa thư mục tạm tmp-deploy/"
  else
    _thong_tin "[DRY-RUN] Bỏ qua dọn dẹp"
  fi
}

# ─── Tóm tắt kết quả ────────────────────────────────────────────────────────
_tom_tat() {
  _tieu_de "TÓM TẮT KẾT QUẢ"
  echo -e "${BOLD}Các repo đã được khởi tạo và push:${RESET}"
  echo -e "  ${MAU_XANH_LA}✅${RESET} ${URL_PROFILE}"
  echo -e "  ${MAU_XANH_LA}✅${RESET} ${URL_ORG_GITHUB}"
  echo -e "  ${MAU_XANH_LA}✅${RESET} ${URL_INVESTMENT}"
  echo -e "  ${MAU_XANH_LA}✅${RESET} ${URL_IOS_DS}"
  echo ""
  echo -e "${BOLD}Bước tiếp theo:${RESET}"
  echo -e "  1. Vào ${MAU_CYAN}github.com/organizations/nlp-labs-vietnam/settings/profile${RESET}"
  echo -e "     → Enable GitHub Sponsors cho org"
  echo -e "  2. Đăng ký secrets tại:"
  echo -e "     ${MAU_CYAN}github.com/Dennis-nham/Dennis-nham/settings/secrets/actions${RESET}"
  echo -e "     • GITHUB_KEY    (Personal Access Token)"
  echo -e "     • NLP_LABS_ORG_TOKEN (PAT có quyền admin:org)"
  echo -e "  3. Nộp đơn Google for Startups: ${MAU_CYAN}cloud.google.com/startup${RESET}"
  echo ""
  if [[ "$CHE_DO_THU" == true ]]; then
    echo -e "${MAU_VANG}${BOLD}⚠️  ĐÂY LÀ KẾT QUẢ DRY-RUN — Không có thay đổi nào được thực thi.${RESET}"
    echo -e "${MAU_VANG}   Chạy lại không có --dry-run để thực thi thật.${RESET}"
  fi
}

# ─── MAIN ────────────────────────────────────────────────────────────────────
main() {
  echo -e "\n${BOLD}${MAU_CYAN}"
  echo "  ╔═══════════════════════════════════════════════════════╗"
  echo "  ║     NLP Labs Vietnam — GitHub Governance Setup       ║"
  echo "  ║     @Dennis-nham · NLP GROUP JSC · 2025              ║"
  echo "  ╚═══════════════════════════════════════════════════════╝"
  echo -e "${RESET}"

  if [[ "$CHE_DO_THU" == true ]]; then
    echo -e "${MAU_VANG}${BOLD}  ⚠️  CHẾ ĐỘ DRY-RUN — Chỉ mô phỏng, không thực thi${RESET}\n"
  fi

  _kiem_tra_yeu_cau
  _cau_hinh_git

  _khoi_tao_profile_repo
  _khoi_tao_org_github_repo
  _deploy_monorepo "investment-platform" "${URL_INVESTMENT}"
  _deploy_monorepo "ios-design-system"   "${URL_IOS_DS}"

  _don_dep
  _tom_tat

  echo -e "\n${MAU_XANH_LA}${BOLD}🎉 Hoàn tất! Hệ thống governance của @nlp-labs-vietnam đã được khởi tạo.${RESET}\n"
}

main "$@"
