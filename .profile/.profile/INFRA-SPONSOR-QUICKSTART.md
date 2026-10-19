# ⚡ Infrastructure Sponsorship & B2B Deal Guide
## @nlp-labs-vietnam · Hướng dẫn kích hoạt tài trợ hạ tầng & quy trình đầu tư doanh nghiệp

> **Tác giả:** [@Dennis-nham](https://github.com/Dennis-nham) · Project Lead, NLP GROUP JSC  
> **Mục tiêu tài liệu này:** Hành động ngay — không chờ deal lớn mới có tài nguyên vận hành.

---

## Phần 1 — Kích hoạt GitHub Sponsors cho Org

> **Làm trước tiên.** Đây là kênh thu tài trợ cộng đồng tốn 0 chi phí setup.

### Bước kích hoạt

1. Truy cập **Settings** của org:  
   👉 [`github.com/organizations/nlp-labs-vietnam/settings/profile`](https://github.com/organizations/nlp-labs-vietnam/settings/profile)

2. Vào mục **"Sponsorship"** trong sidebar trái → chọn **"Set up GitHub Sponsors"**

3. Điền thông tin:
   - **Short description:** `AI for Clean Energy & Vietnamese NLP — Open Source`
   - **Full description:** Copy từ [`SPONSORSHIP.md`](./SPONSORSHIP.md)
   - **Fiscal host:** Chọn Open Source Collective hoặc kết nối tài khoản ngân hàng trực tiếp

4. Tạo **Sponsor tiers** (gợi ý):

   | Tier name | Giá/tháng | Mô tả |
   |---|---|---|
   | ☕ Coffee Supporter | $5 | Cảm ơn từ team + mention monthly update |
   | 🌱 Community Builder | $25 | Badge contributor + early access blog posts |
   | 🚀 Dev Advocate | $100 | Logo nhỏ trong README + Discord role |
   | 💚 Green Tech Ally | $500 | Logo README + mention trong release notes |
   | 🏢 Corporate Sponsor | $2,000 | Logo prominently + quarterly call với team |

5. Thêm file [`.github/FUNDING.yml`](#funding-yml) vào org-level repo.

### `.github/FUNDING.yml`

```yaml
# Đặt tại: .github/FUNDING.yml (trong repo .github của org)
github: [Dennis-nham]
custom:
  - "https://github.com/sponsors/Dennis-nham"
  - "mailto:enterprise@nlpgroup.vn"
```

> Sau khi enable, nút **Sponsor** xuất hiện trên tất cả repo thuộc `@nlp-labs-vietnam`.

---

## Phần 2 — Tier "Infrastructure Sponsor" (Cloud Credits)

> Đây là nguồn tài nguyên **có thể kích hoạt trong 1–2 tuần**, không cần đàm phán.  
> Mục tiêu: Phủ chi phí GPU, Vector DB, API inference trước khi deal lớn về.

### 2.1 Bảng chương trình Cloud Credits

| Provider | Chương trình | Credits | Điều kiện | Link đăng ký |
|---|---|---|---|---|
| **Microsoft Azure** | Founders Hub | Đến **$150,000** | Startup / OSS | [foundershub.startups.microsoft.com](https://foundershub.startups.microsoft.com) |
| **Google Cloud** | Google for Startups | Đến **$200,000** | Startup AI/ML | [cloud.google.com/startup](https://cloud.google.com/startup) |
| **AWS** | AWS Activate | Đến **$100,000** | Startup (qua VC/incubator) | [aws.amazon.com/activate](https://aws.amazon.com/activate) |
| **NVIDIA** | Inception Program | GPU credits + software | AI startup | [nvidia.com/en-us/startups](https://www.nvidia.com/en-us/startups/) |
| **Qdrant Cloud** | Open Source Sponsorship | Managed Vector DB free tier | OSS project | [qdrant.tech/documentation/cloud](https://qdrant.tech/documentation/cloud/) |
| **Zilliz / Milvus** | Community Grant | Milvus cloud credits | OSS / research | [zilliz.com/cloud](https://zilliz.com/cloud) |
| **RunPod** | Research Grant | H100/A100 GPU hours | AI research OSS | [runpod.io](https://www.runpod.io) |
| **Lambda Labs** | Academic / OSS Grant | GPU compute | Research + OSS | [lambdalabs.com/service/gpu-cloud](https://lambdalabs.com/service/gpu-cloud) |
| **Hugging Face** | PRO / ZeroGPU | Inference credits | OSS models | [huggingface.co/pricing](https://huggingface.co/pricing) |
| **GitHub** | Copilot for OSS | Copilot free for maintainers | OSS maintainer | [github.com/features/copilot](https://github.com/features/copilot) |

### 2.2 Checklist nộp đơn

```
Chuẩn bị 1 lần, dùng cho tất cả chương trình:

[ ] GitHub org URL: github.com/nlp-labs-vietnam
[ ] Website: nlpgroup.vn (hoặc github.io fallback)
[ ] Mô tả dự án EN (1 đoạn):
    "NLP Labs Vietnam builds open-source AI infrastructure for clean
     energy transition — RAG/LLM systems for solar PV advisory,
     Vietnamese NLP models, and financial intelligence APIs."
[ ] Use case cụ thể cho cloud:
    - GPU (A100/H100): Fine-tuning Vietnamese NLP transformer models
    - Vector DB: RAG pipeline for solar sizing advisor (Qdrant/Milvus)
    - API Gateway: Real-time NLP inference (gRPC / WebSocket)
[ ] Impact statement: CO₂ reduction metrics (xem SPONSORSHIP.md)
[ ] Funding status: Bootstrap / pre-seed, seeking $50M Series A
[ ] OSS license: MIT (dẫn link repo)
```

### 2.3 Thứ tự ưu tiên đăng ký

```
Tuần 1:  Google for Startups ($200k GCP) ← ưu tiên #1
          NVIDIA Inception (GPU credits)
Tuần 2:  Microsoft Founders Hub ($150k Azure)
          AWS Activate ($100k, cần referral từ VC/incubator)
Tuần 3:  Qdrant OSS sponsorship
          Zilliz Community Grant
          Hugging Face ZeroGPU
Tháng 2: RunPod / Lambda Labs research grants
```

### 2.4 Template email xin Cloud Credits (tiếng Anh)

```
Subject: Open-Source AI for Clean Energy — Cloud Credits Request

Hi [Provider] Startup Team,

I'm NHAM QUOC HUAN, Project Lead at NLP Labs Vietnam
(github.com/nlp-labs-vietnam), an open-source AI organization
building foundational NLP infrastructure for:

1. Solar PV advisory systems (RAG/LLM for clean energy transition)
2. Vietnamese NLP models (low-resource language research)
3. Financial intelligence APIs (real-time sentiment analysis)

We are actively training and deploying transformer models that
require significant GPU compute and vector database resources.
Our project is MIT-licensed and directly contributes to Vietnam's
clean energy goals (NDC target: -43.5% emissions by 2030).

We would like to apply for [Program Name] to cover:
- GPU compute for model fine-tuning (A100/H100)
- Vector DB hosting for RAG pipeline (Qdrant/Milvus)
- API inference infrastructure

Organization: github.com/nlp-labs-vietnam
Contact: enterprise@nlpgroup.vn

Thank you for supporting open-source AI for sustainability.

NHAM QUOC HUAN
Project Lead, NLP GROUP JSC
```

---

## Phần 3 — Quy trình B2B: 6 bước từ NDA → Wire Transfer

> Áp dụng cho tất cả deal **$1M+** — đối tác doanh nghiệp, VC, NGO quốc tế.

```
┌─────────────────────────────────────────────────────────────────┐
│              QUY TRÌNH ĐẦU TƯ / TÀI TRỢ DOANH NGHIỆP           │
│                    @nlp-labs-vietnam · NLP GROUP JSC             │
└─────────────────────────────────────────────────────────────────┘

  ① LIÊN HỆ BAN ĐẦU (Initial Contact)
  ────────────────────────────────────
  Kênh: enterprise@nlpgroup.vn · GitHub Discussions · LinkedIn
  Thời gian phản hồi: ≤ 48 giờ
  Output: Xác nhận interest, schedule call

        ↓  (2–3 ngày)

  ② KÝ NDA (Non-Disclosure Agreement)
  ─────────────────────────────────────
  Tài liệu: NDA tiêu chuẩn song ngữ (EN/VI)
  Ký bằng: DocuSign / Bowtie / Chữ ký điện tử theo Luật GDĐT VN
  Output: NDA được ký bởi cả 2 bên, lưu trữ bảo mật

        ↓  (ngay sau NDA)

  ③ TRÌNH BÀY PITCH DECK & DEMO
  ──────────────────────────────
  Nội dung:
    · Tầm nhìn & Roadmap ($50M, 3 phases)
    · Demo live: RAG solar sizing advisor
    · Demo live: NLP investment platform
    · Financial projections (3-year: $4.5M → $28M → $85M revenue)
    · Team: NHAM QUOC HUAN + core contributors
    · Impact metrics: CO₂, thị trường điện mặt trời VN
  Tham quan: Cơ sở hiện tại / virtual tour
  Output: Pitch deck gửi sau buổi demo (PDF, confidential)

        ↓  (2–4 tuần)

  ④ DUE DILIGENCE
  ────────────────
  Phía nhà đầu tư/tài trợ kiểm tra:
    · Pháp lý: Giấy ĐKKD, điều lệ công ty NLP GROUP JSC
    · Kỹ thuật: Code audit, architecture review
    · Tài chính: Sao kê, kế hoạch sử dụng vốn chi tiết
    · IP: Quyền sở hữu mã nguồn, patent (nếu có)
  NLP Labs Vietnam cung cấp:
    · Data Room (Google Drive / Notion bảo mật)
    · Technical Q&A session với @nhamlapquoc + @thekingbao
  Output: Due diligence report từ phía đối tác

        ↓  (1–2 tuần đàm phán)

  ⑤ KÝ KẾT HỢP ĐỒNG
  ───────────────────
  Loại hợp đồng (chọn 1):
    A. Sponsorship Agreement      → Logo + advisory seat, không cổ phần
    B. Investment Agreement       → Equity stake (SAFE / Convertible note)
    C. Strategic Partnership MOU  → Tích hợp kỹ thuật, revenue share
  Điều khoản quan trọng:
    · Quyền sử dụng logo và thương hiệu NLP Labs Vietnam
    · Milestone-based disbursement (giải ngân theo mốc)
    · Anti-dilution clauses (cho equity deal)
    · IP ownership: NLP Labs Vietnam giữ 100% IP lõi
  Ký bởi: NHAM QUOC HUAN (Authorized Signatory, NLP GROUP JSC)
  Output: Hợp đồng có hiệu lực pháp lý

        ↓  (theo lịch giải ngân trong hợp đồng)

  ⑥ GIẢI NGÂN — WIRE TRANSFER / SWIFT
  ──────────────────────────────────────
  Tài khoản nhận:
    · Tên TK: CÔNG TY CỔ PHẦN NLP GROUP
    · Ngân hàng: [Techcombank / VietinBank / BIDV — xác nhận với kế toán]
    · SWIFT Code: [VTCBVNVX / ICBVVNVX]
    · Số TK & địa chỉ CN: Cung cấp riêng sau khi ký NDA
  Đối với chuyển khoản quốc tế:
    · Phương thức: SWIFT T/T (Telegraphic Transfer)
    · Currency: USD hoặc VND (theo thỏa thuận)
    · Reference: "[Tên đối tác] – NLP Labs Investment [Năm]"
  Output: Xác nhận nhận tiền + cấp quyền lợi theo hợp đồng

        ↓  (ngay sau giải ngân)

  ⑦ ONBOARDING ĐỐI TÁC
  ──────────────────────
  · Thêm logo vào README.md, org profile, website
  · Cấp API access / early beta access
  · Invite vào Advisory Board (nếu có điều khoản)
  · Lên lịch quarterly review call
  · Publish press release / announcement

└─────────────────────────────────────────────────────────────────┘
```

### Thời gian ước tính theo loại deal

| Loại | Tổng thời gian | Bottleneck thường gặp |
|---|---|---|
| Cloud Credits (AWS/GCP/Azure) | 1–3 tuần | Vòng review của provider |
| NGO / Grant (GIZ, UNDP) | 3–6 tháng | Open call schedule |
| Corporate Sponsorship ($50k–$500k) | 4–8 tuần | Legal review nội bộ đối tác |
| VC Investment ($1M+) | 3–6 tháng | Due diligence + term sheet |
| Strategic Partnership (MOU) | 2–4 tuần | Sign-off từ C-level đối tác |

---

## Tổng kết — Hành động theo thứ tự ưu tiên

```
NGAY HÔM NAY:
  1. Enable GitHub Sponsors tại:
     github.com/organizations/nlp-labs-vietnam/settings/profile
  2. Thêm .github/FUNDING.yml vào org repo
  3. Nộp đơn Google for Startups ($200k GCP credits)
  4. Đăng ký NVIDIA Inception Program

TUẦN NÀY:
  5. Nộp Microsoft Founders Hub ($150k Azure)
  6. Nộp AWS Activate (cần referral — liên hệ qua LinkedIn VC network)
  7. Gửi email tới Qdrant + Zilliz xin OSS sponsorship

THÁNG NÀY:
  8. Soạn Pitch Deck hoàn chỉnh (dựa trên SPONSORSHIP.md)
  9. Tiếp cận 3 công ty EPC điện mặt trời đầu tiên (V-Energy, SolarBK, TTC)
 10. Gửi proposal tới GIZ Vietnam (chương trình năng lượng tái tạo)
```

---

<div align="center">
<sub>
Tài liệu này được duy trì bởi <a href="https://github.com/Dennis-nham">@Dennis-nham</a> · NLP GROUP JSC<br/>
Cập nhật lần cuối: 2025 · <a href="./SPONSORSHIP.md">← Quay về SPONSORSHIP.md</a>
</sub>
</div>
