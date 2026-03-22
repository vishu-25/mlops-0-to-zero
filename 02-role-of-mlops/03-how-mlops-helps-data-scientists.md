# How MLOps Engineers Help Data Scientists

> Before automation, data scientists train models by running scripts manually, clicking "Run" in a notebook, or training only on their local machine. This does not scale and is hard to repeat.  
> MLOps Engineers fix this using **CI (Continuous Integration)** with **GitHub Actions**.

---

## The Problem: Manual Activities

Even in a simple Hello World project, the manual overhead is significant. Consider two data scientists, A and B:

- A makes a small change to `train.py` and wants B to review it
- B must then:
  1. Set up Python and a virtual environment locally
  2. Install all dependencies
  3. Pull the latest changes
  4. Run unit and end-to-end test cases
  5. Execute `train.py` and verify the output

Now imagine the model must support **three Python versions**. B would need to spin up three separate virtual machines, one per version, and repeat all of the above on each — for a simple hello world model.

> In enterprise projects, these steps only grow in number and complexity.

---

## What MLOps Engineers Introduce

### 1. Version Control System (Git + GitHub)

MLOps engineers don't just set up a repo — they also introduce best practices:

- **Branching strategy** — one branch per environment
- **RBAC** — only the right people can make changes
- **Auditing** — track who changed what and when
- **`.gitignore`** — prevent unnecessary files (like `.venv/`) from being pushed

```bash
# Initialize and push the project
git init
git add .
git commit -m "first commit"
git remote add origin <repo-url>
git push -u origin main
```

---

### 2. CI/CD with GitHub Actions

MLOps engineers set up a CI pipeline (`.github/workflows/ci.yml`) that **automatically triggers** whenever code is pushed or a pull request is opened on `main`.

#### What the CI pipeline does automatically:

| Step | Action |
|---|---|
| Checkout code | Pull latest files onto the runner |
| Set up Python | Install the specified Python version(s) |
| Upgrade pip | Ensure pip and setuptools are up to date |
| Install dependencies | `pip install -r requirements.txt` |
| Train the model | Execute `train.py` |
| Upload artifacts | Save `model.pkl` + `metrics.json` for download |

#### Matrix Strategy — Multiple Python Versions

Instead of manually testing across versions, the matrix strategy handles it automatically:

```yaml
strategy:
  matrix:
    python: ["3.11", "3.12"]
```

Adding support for a new Python version is as simple as adding one line. The rest is automated.

#### Artifact Upload

After training, the model is uploaded as a GitHub Actions artifact with a unique name:

```
ML-artifacts-{matrix.python}-{github.run_id}
```

Anyone on the team can download `model.pkl` and `metrics.json` directly from the GitHub Actions run — no manual file sharing over chat or email.

---

## Key Benefits of CI/CD for Data Scientists

### Training Becomes an Automatic Event
Training triggers on:
- A new code push
- A pull request merge
- A data change

Training is now **predictable, consistent, and not tied to anyone's laptop**.

### Standard Environment Every Time
Local machines differ in Python versions, library versions, and OS settings. CI ensures:
- Same Python version
- Same dependencies
- Same environment — every single run

> *"The model worked on my machine but not in CI"* — this problem is eliminated.

### Clean, Fresh Runs
Each CI run starts from scratch:
- No leftover files
- No cached results
- No manual tweaks

This makes training **reproducible** and results **trustworthy**.

### Experiment Tracking Built In
Every CI run is automatically linked to:
- A Git commit
- A timestamp
- A specific change

This makes it easy to answer: *Which code produced this model? Why did accuracy drop?*

### Early Failure Detection
If anything breaks — dependency issues, data format problems, training errors — CI **fails immediately and visibly**, helping the team catch problems before a broken model reaches production.

---

## Summary: Continuous Training Pipeline

What MLOps engineers implement here is called **Continuous Training (CT)** — a key practice in MLOps where model training is automated as part of the CI/CD pipeline.

```
Code Push / PR  →  GitHub Actions Triggers  →  Environment Setup  
→  Install Dependencies  →  Train Model  →  Upload model.pkl + metrics.json
```