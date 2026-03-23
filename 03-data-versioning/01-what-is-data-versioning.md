# 📦 Data Version Control (DVC) — Lecture Notes

---

## 🧠 Context: What Matters in ML Workflows

Two critical pillars for any data scientist:

1. **Data** — the raw material for training
2. **Algorithm & Training Process** — the Python scripts, configs, and pipelines

Both ML teams and ML engineers store their Python scripts in **Git**, which gives them:
- ✅ **Auditing** — who changed what and when
- ✅ **Versioning** — compare versions, track changes
- ✅ **RBAC** — control who can read/write to the repo

> Git works great for code. But what about **data**?

---

## ❓ Why Not Just Use Git for Data?

Data is equally important as the training process — sometimes more so. Teams constantly update datasets (removing duplicates, handling noise, feature engineering, adding new records).

They need the **same capabilities** for data: auditing, versioning, and access control.

So why can't Git handle it?

---

## ❌ Reasons Git Fails for Data Versioning

### 1. 📏 Git Is Not Built for Large Files
- Python scripts and config files → typically **KB to a few MB**
- Real-world ML datasets → easily **GBs to TBs**
  - Weather prediction: 40–50 years of historical data
  - Image processing: thousands/millions of images
- Git is **not designed** for GB/TB-scale files — it becomes slow and bloated

### 2. 🐢 Git Becomes Very Slow
- Multiple data scientists pushing changes to large CSV files concurrently → **Git instance slows to a crawl**
- Even upper-MB / lower-GB files cause significant performance degradation

### 3. 💰 Cost Inefficiency
- Self-hosted Git (e.g., on EC2) = paying for **storage + compute resources**
- Storing images, videos, or large CSVs in Git causes **storage to explode exponentially**
- Cloud providers charge for both storage and bandwidth → not scalable

### 4. 🔢 Git Can't Diff Binary Data Meaningfully
- Datasets (CSVs, images, audio, Parquet) are treated as **binary blobs** by Git
- Git stores the **entire file** on every change — no smart diffing
- Leads to enormous, unmanageable repositories

### 5. 🔗 No Dataset Lineage Tracking
Git cannot answer:
- Where did this data come from?
- What transformations were applied?
- Which data version produced which model?

It has no awareness of **data pipelines, transformation steps, or quality checks**.

### 6. 📋 No Built-in Dataset Metadata
ML workflows need metadata like:
- Schema changes
- Statistics (min/max, missing values, distributions)
- Train/validation splits
- Data provenance

**Git provides none of this.**

### 7. 👥 Poor Collaboration on Large Datasets
- Multi-GB pushes/pulls across a team → slow and painful
- **Merge conflicts on binary files** → practically impossible to resolve
- Large repos break CI/CD pipelines

### 8. 🧪 No Experiment-Level Tracking
Git cannot correlate:
- Which dataset version was used for **model v3**?
- What changed between **dataset v1.4 → v1.5**?
- Why did **accuracy drop** yesterday?

---

## ✅ The Solution: DVC (Data Version Control)

DVC is purpose-built for what Git cannot do in ML workflows.

| Need | Git | DVC |
|---|---|---|
| Code versioning | ✅ | — |
| Large file handling | ❌ | ✅ |
| Binary data diffing | ❌ | ✅ |
| Dataset lineage | ❌ | ✅ |
| Metadata tracking | ❌ | ✅ |
| Experiment correlation | ❌ | ✅ (+ MLflow, Delta Lake) |
| Cost-efficient storage | ❌ | ✅ (deduplication) |

> Other tools in this space: **LakeFS**, **MLflow**, **Delta Lake**

---

## 💡 Summary

> **Git is great for text-based code.**
> ML needs versioning for huge, complex, constantly changing datasets — and Git simply wasn't designed for that.

Data versioning tools like DVC provide:
- Efficient storage & deduplication
- Lineage and provenance tracking
- Dataset metadata
- Reproducible ML pipelines
- Experiment-level correlation (data ↔ code ↔ model)
