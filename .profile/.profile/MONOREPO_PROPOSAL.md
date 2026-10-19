# 🏗️ Đề xuất cấu trúc Monorepo — @nlp-labs-vietnam

> **Tác giả:** [@Dennis-nham](https://github.com/Dennis-nham) · Project Lead, NLP GROUP JSC  
> **Tham chiếu:** [`ios-design-system`](https://github.com/nlp-labs-vietnam/ios-design-system) · EVerest OSS governance model  
> **Build system:** Turborepo + pnpm workspaces

---

## 1. Nguyên tắc thiết kế

| Nguyên tắc | Mô tả |
|---|---|
| **Single source of truth** | Một monorepo cho mỗi domain (design system, investment platform, core-nlp) |
| **Package-first** | Logic tái sử dụng luôn nằm trong `packages/`, không trực tiếp trong `apps/` |
| **Turborepo cache** | Pipeline build được cache theo task hash — CI nhanh tuyệt đối |
| **CODEOWNERS gating** | Mọi PR phải qua đúng module owner trước khi Project Lead merge |
| **Conventional Commits** | `feat(tokens): add new color palette` — changelog tự động |

---

## 2. Cấu trúc tổng thể tổ chức

```
@nlp-labs-vietnam (GitHub Organization)
│
├── ios-design-system/          ← @thekingbao
│   ├── packages/tokens
│   ├── packages/icons
│   ├── packages/core
│   ├── packages/react
│   ├── packages/vue
│   ├── packages/blade
│   ├── apps/docs               (VitePress)
│   └── apps/showcase           (Vite)
│
├── investment-platform/        ← @nhamlapquoc
│   ├── services/
│   │   ├── ingestion/          (Apache Kafka consumer)
│   │   ├── nlp-sentiment/      (Fine-tuned Transformer workers)
│   │   ├── nlp-ner/            (Financial NER)
│   │   ├── orchestrator/       (RabbitMQ message broker)
│   │   └── api-gateway/        (gRPC / REST / WebSocket)
│   ├── packages/
│   │   ├── nlp-sdk/            (Client SDK — TypeScript)
│   │   └── shared-types/       (Shared DTOs & proto definitions)
│   └── apps/
│       └── dashboard/          (Investment intelligence UI)
│
├── core-nlp/                   ← @nhamlapquoc
│   ├── models/                 (Fine-tuned model checkpoints)
│   ├── pipeline/               (Data preprocessing)
│   ├── research/               (Jupyter notebooks)
│   └── packages/
│       └── vi-tokenizer/       (Vietnamese tokenizer)
│
├── wikialisa-labs/             ← @wikialisalabs
│   ├── packages/
│   │   ├── tree-sitter-vi/     (Vietnamese grammar for Tree-sitter)
│   │   └── open-standards/     (Educational resources)
│   └── tools/
│       └── automation/
│
└── .github (org-level)         ← @Dennis-nham
    ├── MAINTAINERS.md
    ├── CODEOWNERS
    ├── profile/README.md       (Org public profile)
    └── ISSUE_TEMPLATE/
```

---

## 3. Cấu hình Turborepo (`turbo.json`)

```json
{
  "$schema": "https://turbo.build/schema.json",
  "pipeline": {
    "build": {
      "dependsOn": ["^build"],
      "outputs": ["dist/**", ".next/**"]
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
    }
  }
}
```

---

## 4. pnpm Workspace (`pnpm-workspace.yaml`)

```yaml
packages:
  - "packages/*"
  - "apps/*"
  - "services/*"
  - "tools/*"
```

---

## 5. Package naming convention

```
@nlp-labs-vietnam/[name]     ← Công khai, scoped npm package
@alisababivip/[name]         ← Design system packages (đã dùng trong ios-design-system)
```

Ví dụ:
```
@alisababivip/tokens
@alisababivip/core
@alisababivip/react
@nlp-labs-vietnam/nlp-sdk
@nlp-labs-vietnam/vi-tokenizer
```

---

## 6. GitHub Actions CI/CD chuẩn

Mỗi repo tuân theo pipeline sau:

```
push / PR
 └─→ lint + typecheck           (turbo run lint typecheck)
       └─→ test                 (turbo run test)
             └─→ build          (turbo run build)
                   └─→ [main only] publish to npm
                                (pnpm publish -r --access public)
```

Tệp `.github/workflows/ci.yml` mẫu:

```yaml
name: CI
on:
  push:
    branches: [main]
  pull_request:

jobs:
  ci:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: pnpm/action-setup@v3
        with: { version: 9 }
      - uses: actions/setup-node@v4
        with:
          node-version: 20
          cache: pnpm
      - run: pnpm install --frozen-lockfile
      - run: pnpm turbo run lint typecheck test build
```

---

## 7. Branch strategy

| Branch | Mô tả | Bảo vệ |
|---|---|---|
| `main` | Production-ready, luôn xanh | Require PR · CODEOWNERS review |
| `develop` | Integration branch | Require PR |
| `feat/*` | Feature branches | Tự do |
| `fix/*` | Bugfix branches | Tự do |
| `release/*` | Release preparation | Module owner + Project Lead |

---

## 8. Tệp quản trị bắt buộc cho mỗi repo

```
✅ README.md          — Mô tả repo, cài đặt, sử dụng nhanh
✅ MAINTAINERS.md     — Danh sách người bảo trì (link về org-level)
✅ .github/CODEOWNERS — Phân quyền review tự động
✅ CONTRIBUTING.md    — Hướng dẫn đóng góp, commit convention
✅ CODE_OF_CONDUCT.md — Quy tắc cộng đồng
✅ LICENSE            — MIT (mặc định cho open source)
✅ CHANGELOG.md       — Tự động tạo từ conventional commits
```

---

## 9. Phân quyền GitHub Teams

```
@nlp-labs-vietnam/leads          → Admin (Dennis-nham)
@nlp-labs-vietnam/infra          → Write access: ios-design-system, .github
@nlp-labs-vietnam/nlp-core       → Write access: core-nlp, investment-platform
@nlp-labs-vietnam/packages       → Write access: wikialisa-labs
@nlp-labs-vietnam/contributors   → Read + PR (cộng đồng)
```

---

## 10. Lộ trình triển khai

| Giai đoạn | Hành động | Phụ trách |
|---|---|---|
| **Ngay bây giờ** | Đưa `MAINTAINERS.md` và `CODEOWNERS` vào `.github` repo | @Dennis-nham |
| **Tuần 1** | Setup GitHub Teams theo phân quyền mục 9 | @Dennis-nham |
| **Tuần 2** | Thêm `CONTRIBUTING.md` + `CODE_OF_CONDUCT.md` vào mọi repo | @thekingbao |
| **Tuần 3** | Chuẩn hóa `turbo.json` pipeline trên `investment-platform` | @thekingbao |
| **Tháng 2** | Tách `core-nlp` thành repo độc lập với CI/CD đầy đủ | @nhamlapquoc |
| **Tháng 3** | Phát hành `@nlp-labs-vietnam/nlp-sdk` v1 lên npm | @nhamlapquoc + @wikialisalabs |

---

<div align="center">
<sub>Tài liệu này được soạn thảo bởi <strong>@Dennis-nham</strong> · NLP GROUP JSC · <a href="https://github.com/nlp-labs-vietnam">@nlp-labs-vietnam</a></sub>
</div>
