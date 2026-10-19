# 🔐 GitHub Secrets Setup Guide

Hướng dẫn đăng ký token vào GitHub Secrets để kích hoạt CI/CD workflows.

---

## Tóm tắt — 2 secrets cần tạo

| Secret name | Workflow sử dụng | Scopes cần có |
|---|---|---|
| `PROFILE_DEPLOY_TOKEN` | `deploy-profile.yml` | `repo` |
| `NLP_LABS_ORG_TOKEN` | `deploy-org-docs.yml` | `repo` + `write:org` |

> ⚠️ **Lưu ý quan trọng:** `GITHUB_TOKEN` (built-in của GitHub Actions) **không thể push sang repo khác**.  
> Phải dùng PAT thủ công với đúng tên secret như bảng trên.

---

## Bước 1 — Tạo Token 1: `PROFILE_DEPLOY_TOKEN`

**Mục đích:** Push `README.md` từ repo này sang `Dennis-nham/Dennis-nham`

1. Truy cập: 👉 **[github.com/settings/tokens/new](https://github.com/settings/tokens/new)**
2. Điền thông tin:
   - **Note:** `Profile Sync Token — Dennis-nham`
   - **Expiration:** 90 days
3. **Scopes** — tick duy nhất:
   - ✅ `repo` → Full control of private repositories
4. Nhấn **Generate token** → **copy ngay** (`ghp_...`)

---

## Bước 2 — Tạo Token 2: `NLP_LABS_ORG_TOKEN`

**Mục đích:** Push governance docs sang `nlp-labs-vietnam/.github`

1. Truy cập: 👉 **[github.com/settings/tokens/new](https://github.com/settings/tokens/new)**
2. Điền thông tin:
   - **Note:** `Org Docs Sync Token — nlp-labs-vietnam`
   - **Expiration:** 90 days
3. **Scopes** — tick:
   - ✅ `repo`
   - ✅ `admin:org` → mở rộng → ✅ `write:org`
4. Nhấn **Generate token** → **copy ngay** (`ghp_...`)

---

## Bước 3 — Đăng ký secrets vào repo

Truy cập:  
👉 **[github.com/Dennis-nham/Dennis-nham/settings/secrets/actions](https://github.com/Dennis-nham/Dennis-nham/settings/secrets/actions)**

### Thêm secret thứ nhất

1. Nhấn **New repository secret**
2. **Name:** `PROFILE_DEPLOY_TOKEN`
3. **Secret:** Dán token từ Bước 1
4. Nhấn **Add secret**

### Thêm secret thứ hai

1. Nhấn **New repository secret**
2. **Name:** `NLP_LABS_ORG_TOKEN`
3. **Secret:** Dán token từ Bước 2
4. Nhấn **Add secret**

### Kết quả mong đợi

Sau khi thêm xong, màn hình **Repository secrets** hiển thị:

```
✅ NLP_LABS_ORG_TOKEN     Updated X minutes ago
✅ PROFILE_DEPLOY_TOKEN   Updated X minutes ago
```

---

## Bước 4 — Trigger workflows lần đầu

```bash
# Commit tất cả và push lên master
git add .
git commit -m "chore: initial governance setup — trigger CI/CD"
git push origin master
```

Kiểm tra workflows chạy tại:  
👉 **[github.com/Dennis-nham/Dennis-nham/actions](https://github.com/Dennis-nham/Dennis-nham/actions)**

| Workflow | Trigger khi | Đích đến |
|---|---|---|
| `🚀 Deploy — Dennis-nham GitHub Profile` | `.profile/README.md` thay đổi | `Dennis-nham/Dennis-nham` |
| `🏛 Deploy — nlp-labs-vietnam Org Governance Docs` | Bất kỳ file `.profile/*.md` thay đổi | `nlp-labs-vietnam/.github` |

---

## Xử lý lỗi thường gặp

| Lỗi | Nguyên nhân | Cách sửa |
|---|---|---|
| `remote: Permission to ... denied` | Sai secret name hoặc token hết hạn | Kiểm tra lại tên secret, tạo token mới |
| `Error: Resource not accessible by integration` | Dùng nhầm built-in `GITHUB_TOKEN` | Đảm bảo dùng `PROFILE_DEPLOY_TOKEN` |
| `fatal: repository not found` | Repo đích chưa tồn tại | Tạo repo `Dennis-nham/Dennis-nham` và `nlp-labs-vietnam/.github` trên GitHub trước |
| `Updates were rejected (non-fast-forward)` | Lịch sử commit không khớp | Chạy `setup.sh` lần đầu hoặc xóa và tạo lại repo đích |

---

## Bảo mật token

- ✅ File `.env` đã có trong `.gitignore` — **không bị commit**
- ✅ Secrets trên GitHub được mã hóa end-to-end
- ⚠️ Không paste token vào chat, email, hay file `.md`
- 🔄 Gia hạn token trước 7 ngày hết hạn (đặt nhắc lịch)
