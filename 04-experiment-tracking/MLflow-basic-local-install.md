# MLflow — Local Installation (Demo / POC)

> ⚠️ **This setup is for local development and proof-of-concept only.**
> For production-grade MLflow setup (VM, Docker, Kubernetes), refer to future lectures.

Official Docs: [MLflow Quickstart](https://mlflow.org/docs/2.4.2/quickstart.html#install-mlflow)

---

## Step 1 — Create Project Directory & Virtual Environment

```bash
mkdir mlflow-basic-install
cd mlflow-basic-install

# Create virtual environment
python3 -m venv .venv

# Activate it
source .venv/bin/activate        # macOS / Linux
# .venv\Scripts\activate         # Windows
```

---

## Step 2 — Install MLflow

```bash
python3 -m pip install mlflow
```

A single command installs:

| Component | What It Does |
|---|---|
| **MLflow Tracking** | Logs and stores experiment runs |
| **MLflow UI** | Web dashboard to view and compare runs |
| **MLflow Model Registry** | Manages model versions and stages |

Verify the installation:

```bash
mlflow --version
```

---

## Step 3 — Start the MLflow UI

```bash
mlflow ui --backend-store-uri sqlite:///mlflow.db --port 7006
```

### What each flag does:

| Flag | Purpose |
|---|---|
| `mlflow ui` | Starts the MLflow web interface |
| `--backend-store-uri` | Tells MLflow where to store experiment metadata |
| `sqlite:///mlflow.db` | Uses a local SQLite database file in the current directory |
| `--port 7006` | Runs the UI on port 7006 (use any free port; 5000 is also common) |

---

## What Gets Created

Running the above command creates a `mlflow.db` file in your directory.
This SQLite database stores everything MLflow tracks:

- Experiments
- Runs
- Parameters
- Metrics
- Tags

---

## Step 4 — Access the UI

Open your browser and go to:

```
http://localhost:7006
```

You'll see the MLflow home page with an **Experiments** tab.
Runs will appear here once data scientists start pushing records from their Python scripts.

---

## What's Next

This local setup is enough to explore MLflow's interface.
In upcoming lectures:
- Setting up a **production MLflow instance** (VM / Docker / Kubernetes)
- Connecting a **Wine Prediction model** to MLflow
- Logging runs and **comparing experiments** in the UI