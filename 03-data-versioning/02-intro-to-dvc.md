# 🗂️ What is DVC? — Lecture Notes
---

## 🔁 Quick Recap from Previous Lecture

Git is **not suitable** for data versioning because:
- Not designed for large files (GBs/TBs)
- Becomes extremely slow when multiple engineers push/modify large files concurrently
- Cost-ineffective — self-hosted Git stores files on local disk, which is expensive at scale

---

## 💡 What is DVC?

> **DVC (Data Version Control)** = Git for your data.

While Git handles code and small text files, DVC handles what Git cannot:
- Large datasets (CSVs, images, audio, Parquet, etc.)
- Model files
- Data stored in remote cloud storage

---

## ☁️ Where Does DVC Store Your Data?

DVC offloads your actual data to **remote cloud storage**, such as:

| Provider | Storage |
|---|---|
| AWS | S3 Bucket |
| Microsoft Azure | Azure Blob Storage |
| Google Cloud | Google Cloud Storage (GCS) |
| Local | Local/network drives |

### Why cloud storage?
- Specially designed for **large file handling** — no size limits
- Built-in **version control capabilities** — store multiple versions of a dataset
- **Cost-effective** — far cheaper than local disk on a self-hosted VM
- **Highly durable** — 99.999999999% (11 nines) durability; your files are never lost

---

## ⚙️ How DVC Works — The Core Flow

### The Key Idea
> Your **Git repo** stores a small metadata pointer (`.dvc` file).
> Your **actual data** lives in cloud storage.
> Git never touches the large files.

### Step-by-Step Workflow

**1. Track your dataset with DVC**
```bash
dvc add wine_data_sample.csv
```
- DVC starts tracking the file
- Creates `wine_data_sample.csv.dvc` — a small metadata/pointer file

**2. Commit the pointer file to Git**
```bash
git add wine_data_sample.csv.dvc
git commit -m "Track dataset with DVC"
```
- Git stores only the `.dvc` file, NOT the actual data

**3. Configure remote storage**
```bash
dvc remote add -d myremote s3://mybucket/dvcstore
```

**4. Push data to remote storage**
```bash
dvc push
```
- Uploads the actual dataset to S3 (or GCS/Azure)
- The version pushed is tracked in the **DVC config file**

**5. Anyone in the team pulls the data**
```bash
dvc pull
```
- Downloads the exact dataset version referenced in the `.dvc` file
- Requires the `.dvc` file and DVC config to be present (from Git clone)

---

## 🔄 What Lives Where?

| File | Stored In |
|---|---|
| `train.py`, `api.py` (scripts) | Git |
| `wine_data_sample.csv.dvc` (pointer) | Git |
| `.dvc/config` (remote config) | Git |
| `wine_data_sample.csv` (actual data) | S3 / GCS / Azure |

> **Git stores pointers. DVC stores data.**

---

## 👥 Team Collaboration Flow

```
Engineer A
  └── dvc add dataset.csv  →  creates dataset.csv.dvc
  └── git push             →  shares .dvc + config with team
  └── dvc push             →  uploads data to S3

Engineer B
  └── git clone <repo>     →  gets .dvc + config files
  └── dvc pull             →  downloads exact same dataset version
```

Everyone works with the **same data version**, tracked and reproducible.

---

## 🆚 Without DVC vs. With DVC

| | Without DVC | With DVC |
|---|---|---|
| CSV in repo | ✅ (slow, heavy) | ❌ (only pointer) |
| Git performance | Degrades fast | Stays fast |
| Data versioning | Manual | Automatic |
| Team sync | Painful | `dvc pull` |
| Storage cost | High (local disk) | Low (cloud) |

---

## 💡 Summary

DVC bridges the gap between Git and cloud storage:
- Use **Git** for code, configs, and `.dvc` pointer files
- Use **DVC + cloud storage** for actual datasets and model files
- Teammates clone the repo, install DVC, and run `dvc pull` to get the exact dataset version