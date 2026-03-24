# What is Experiment Tracking?

Experiment tracking is the process of **recording everything you do while training a machine learning model** so that you can:

- Compare different models
- Understand what worked and what didn't
- Reproduce a result in the future
- Share your results with others

In machine learning, you rarely train a model just once.
You try many combinations:

- Different algorithms
- Different hyperparameters (learning rate, batch size, epochs)
- Different datasets
- Different preprocessing steps

After a few tries, you forget which run gave the best accuracy.
**Experiment tracking solves this problem.**

---

## What Do We Track?

A good experiment tracking system stores:

| Category | Examples |
|---|---|
| **Parameters** | `learning_rate=0.01`, `epochs=20`, `max_depth=5` |
| **Code version** | Git commit ID, branch name |
| **Dataset version** | Which CSV/data file was used (DVC can help here) |
| **Metrics** | Accuracy, loss, RMSE, F1-score |
| **Artifacts** | Trained model files (`.pkl`, `.h5`), plots |
| **System info** | OS (Windows/Linux), Python version, CPU/GPU specs |

> ⚠️ **System info matters more than you think.**
> The same algorithm on Linux with high CPU/memory can give 87% accuracy,
> while the same code on Windows might give only 86%. That 1% difference can matter in production.

---

## Real-World Example — Wine Quality Prediction

A team is building a model to predict wine quality. Their goal: **≥ 85% accuracy**.

| Run | Algorithm | Dataset | Environment | Accuracy |
|---|---|---|---|---|
| 1 | Random Forest | Raw CSV | Windows | 67% |
| 2 | Logistic Regression | Raw CSV | Windows | 79% |
| 3 | XGBoost | Cleaned CSV (deduped, noise removed) | Linux (high CPU/RAM) | **87% ✅** |
| 4–24 | Various | Various | Various | Mixed |
| 25 | Some algorithm | Some CSV | Some env | 81% |

After 25 experiments, the team wants to go back to the **Run 3 setup** — but if they didn't track:

- ❌ Which algorithm was used?
- ❌ Which version of the dataset?
- ❌ What were the hyperparameters?
- ❌ What environment/specs?

They're **stuck at 81%**, even though they hit 87% earlier.

**This is exactly why experiment tracking is non-negotiable.**

---

## Popular Experiment Tracking Tools

| Tool | Notes |
|---|---|
| [MLflow](https://mlflow.org/) | Open-source, widely used |
| [Weights & Biases (W&B)](https://wandb.ai/) | Great visualizations |
| [DVC Experiments](https://dvc.org/) | Git-native, pairs well with data versioning |
| [Neptune.ai](https://neptune.ai/) | Collaboration-focused |
| [Comet ML](https://www.comet.com/) | Auto-logging support |

---

## TL;DR

> **Experiment tracking = keeping a structured record of all your model training runs**
> so you can compare, reproduce, and confidently pick the best one.

Without it, past results are lost — and you end up re-discovering what already worked.