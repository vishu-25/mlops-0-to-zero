# Introduction to MLflow

MLflow is an **open-source MLOps framework** used to manage the end-to-end machine learning lifecycle.
It helps you **track experiments, manage models, and make ML work reproducible**.

In simple terms:

> MLflow helps you answer the question:
> **"Which model did we train, with what parameters, and how good was it?"**

---

## Why Not Just Use an Excel Sheet?

Many teams still manually track experiments in Excel or notebooks. This is an **anti-MLOps pattern** for several reasons:

| Problem | What Goes Wrong |
|---|---|
| **Human error** | A team running 100 experiments might forget to record experiment #67 — which could be the best one |
| **No centralization** | Team A has one spreadsheet, Team B has another — the org ends up with a mess of disconnected files |
| **No standard format** | Every person's sheet looks different, making cross-team comparison impossible |
| **Poor discoverability** | A year later, no one knows which file has what result |

**MLflow completely automates this process and provides a clean comparison UI.**
Instead of manually noting parameters, every run is recorded automatically the moment a Python script executes.

---

## Core Components of MLflow

MLflow has four main components. Beginners should focus mainly on the first two.

---

### 1. MLflow Tracking ⭐ (Most Important)

Used to **log and compare experiments**.

You can log:
- Parameters → `learning_rate`, `epochs`, `max_depth`
- Metrics → accuracy, loss, F1-score
- Artifacts → model files, plots, datasets
- Source code version

Each training run is stored as a **Run** inside an **Experiment**.

```python
import mlflow

with mlflow.start_run():
    mlflow.log_param("learning_rate", 0.01)
    mlflow.log_metric("accuracy", 0.92)
```

To view all runs in the UI:

```bash
mlflow ui
```

This opens a dashboard where you can visually compare any two experiments side by side.

---

### 2. MLflow Model Registry

A centralized place to manage models across their lifecycle:

- Track model versions
- Assign stages: `Staging → Production → Archived`
- Add metadata, descriptions, and approvals

Very useful in team and enterprise MLOps setups.

---

### 3. MLflow Models

MLflow provides a **standard format to package models**, making the same model:

- Loadable in Python
- Servable via REST API
- Containerizable with Docker
- Deployable to cloud or Kubernetes

This makes models **portable and production-ready**.

---

### 4. MLflow Projects

A way to package ML code with environment details and entry points for **reproducible execution**.
Mostly useful in larger teams and advanced workflows.

---

## Real-World Example — Wine Quality Prediction

A team runs multiple experiments. Without MLflow they lose track of results. With MLflow, every run is automatically recorded:

| Run | Algorithm | Learning Rate | Dataset | Accuracy |
|---|---|---|---|---|
| 1 | Random Forest | 0.01 | Raw CSV | 67% |
| 2 | Logistic Regression | 0.05 | Raw CSV | 79% |
| 3 | XGBoost | 0.05 | Cleaned CSV | **87% ✅** |
| ... | ... | ... | ... | ... |
| 25 | XGBoost | 0.01 | Raw CSV | 81% |

With MLflow:
- Every run is logged automatically
- Metrics are compared visually in the UI
- The best model is clearly identified
- The model artifact is stored and versioned — ready to retrieve anytime

---

## How MLflow Is Set Up in an Organization

MLflow is a **shared responsibility** between two roles:

### MLOps Engineer (Infrastructure)
- Installs and hosts the **centralized MLflow Tracking Server** for the whole organization
- Can be deployed on: a VM, Docker container, Fargate (serverless), or Kubernetes
- All teams connect to this **single shared instance** — no more scattered spreadsheets

### Data Scientist (Instrumentation)
- Uses the `mlflow` Python module inside their training scripts
- Connects to the shared MLflow instance
- Logs parameters, metrics, and artifacts per run

> ⚠️ **Important:** Installing MLflow alone does nothing.
> Data scientists must instrument their scripts with `mlflow.log_param()`, `mlflow.log_metric()`, etc.
> Once instrumented, every script execution is recorded automatically — even across 100 runs.

---

## How MLflow Fits into the Broader MLOps Stack

MLflow is rarely used alone in production. It typically sits alongside:

| Tool | Role |
|---|---|
| **Git** | Code versioning |
| **DVC** | Data versioning |
| **MLflow** | Experiment tracking + model registry |
| **GitHub Actions** | CI/CD pipelines |
| **Docker** | Containerization |
| **Kubernetes** | Model serving at scale |
| **AWS S3 / GCS** | Remote artifact storage |

---

## TL;DR

> **MLflow = the central system of record for all your ML experiments.**
> It automates what teams used to do manually in spreadsheets,
> gives everyone a single source of truth, and makes results reproducible.

Two steps to use it in production:
1. **MLOps Engineer** → set up and host the MLflow server
2. **Data Scientist** → instrument Python scripts to log to that server