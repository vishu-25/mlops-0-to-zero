# Machine Learning Lifecycle

The ML lifecycle is the **complete, repeating journey** of building, deploying, and maintaining a machine learning model — from raw data collection all the way to production monitoring.

> It is not a one-time activity. Just like the software development lifecycle, these stages run in a continuous loop.

---

## 🗺️ Lifecycle at a Glance

```
Problem Definition
       ↓
Data Collection
       ↓
Data Cleaning & Preparation
       ↓
Feature Engineering
       ↓
Model Selection (Algorithm Selection)
       ↓
Model Training  ←──────────────────────┐
       ↓                               │
Model Evaluation                       │
       ↓                               │
Hyperparameter Tuning                  │
       ↓                               │
Model Deployment                       │
       ↓                               │
Monitoring & Maintenance ──────────────┘
(if accuracy drops, loop restarts)
```

---

## Stage 1 — Problem Definition

Every ML project starts here, just like traditional software.

- What problem are we solving?
- What does success look like? (target accuracy, latency, cost)
- Is it a classification, regression, or clustering problem?

A well-defined problem prevents wasted effort in every stage that follows.

---

## Stage 2 — Data Collection

Models learn from data — so data collection is foundational.

Data scientists gather data from sources such as:

| Source | Example |
|--------|---------|
| Public datasets | Iris dataset, Kaggle, UCI ML Repository |
| Databases | Internal transactional or operational data |
| APIs | Third-party data providers |
| Logs | Application or system event logs |
| Sensors / Devices | IoT telemetry |

> If a relevant public dataset exists, data scientists use it. Otherwise, they build one from scratch.

---

## Stage 3 — Data Cleaning & Preparation

Raw data is rarely ready to use. This stage removes noise so the model trains on reliable information.

Common tasks:
- Remove **duplicate entries**
- Fix or drop **incorrect / inconsistent values**
- Handle **missing fields**
- Split data into **train / validation / test sets** (typically 80/20)

> Poor data quality = poor model accuracy, regardless of how good the algorithm is.

---

## Stage 4 — Feature Engineering

Feature engineering is the process of **adding or transforming features** in the dataset to help the model learn better patterns.

### Example: Iris Dataset

The raw dataset has: `petal_length`, `petal_width`, `sepal_length`, `sepal_width`

A data scientist might add:

| New Feature | Reasoning |
|-------------|-----------|
| `petal_length / sepal_length` | Ratio may reveal patterns not visible in raw values |
| `total_area` (petal + sepal) | Combined size might correlate strongly with species |

> The raw data you collect often isn't enough. Feature engineering shapes the data into a form that unlocks better model performance.

---

## Stage 5 — Model Selection

> ⚠️ In ML, **"model selection" and "algorithm selection" mean the same thing.** Don't let the terminology confuse you.

Data scientists choose an algorithm based on the problem type and data characteristics:

| Algorithm | Common Use Case |
|-----------|----------------|
| Linear Regression | Predicting continuous values |
| Logistic Regression | Binary or multi-class classification |
| Decision Tree | Interpretable classification/regression |
| Random Forest | High-accuracy ensemble classification |
| Neural Networks | Complex patterns, images, language |
| K-Nearest Neighbors | Simple classification tasks |

This decision belongs to the **data scientist** — not the MLOps engineer.

---

## Stage 6 — Model Training

The most critical stage. The algorithm is fed the **80% training data** and begins learning.

During training the algorithm:
1. Processes each sample's features and its label
2. Identifies patterns (e.g. *small petal length → likely Setosa*)
3. Builds a **mathematical function** (the model) that maps inputs to outputs
4. Continuously adjusts itself to reduce prediction errors

```
Training Data (80%)  +  Algorithm  →  Trained Model
```

---

## Stage 7 — Model Evaluation

The trained model is tested against the **held-out 20% test data** — data it has never seen.

Common evaluation metrics:

| Metric | Used For |
|--------|----------|
| Accuracy | Classification problems |
| F1-Score | Imbalanced classification |
| RMSE | Regression problems |
| ROC-AUC | Binary classification |

If the model doesn't meet the target accuracy → **retrain** with adjusted data or a different algorithm.

---

## Stage 8 — Hyperparameter Tuning

After initial training, data scientists fine-tune the model's internal settings (hyperparameters) to squeeze out more accuracy.

Common techniques:
- **Grid Search** — exhaustively tests all combinations
- **Random Search** — samples random combinations
- **Bayesian Optimization** — uses previous results to guide the search

Examples of hyperparameters: learning rate, tree depth, regularization strength.

> This stage will be covered in depth later in the course.

---

## Stage 9 — Model Deployment

Once the model performs well, it is packaged and deployed so end users can interact with it.

Common deployment patterns:

| Pattern | Example |
|---------|---------|
| REST API | Mobile app or website calls the model endpoint |
| Batch Jobs | Model runs on large datasets periodically |
| Edge Devices | Model runs locally on a device (IoT, phone) |
| Cloud ML Services | AWS SageMaker, Google Vertex AI, Azure ML |

> This is where MLOps engineers take over — packaging, containerizing, and shipping the model to production.

---

## Stage 10 — Monitoring & Maintenance

Deployment is not the finish line. Models degrade over time as real-world data changes.

### What to Monitor

| Signal | Why It Matters |
|--------|---------------|
| Model accuracy | Are predictions still correct? |
| Data drift | Has the input data distribution shifted? |
| Latency | Is the model responding fast enough? |
| Error rates | Are there unexpected failures? |

### What Triggers a New Cycle

If monitoring reveals degraded performance, the lifecycle **loops back**:

```
Accuracy drops
     ↓
Revisit feature engineering or algorithm selection
     ↓
Retrain → Evaluate → Tune → Deploy new version
     ↓
Monitor again
```

This is why it is called a **lifecycle** — not a one-time process.

---

## 🔁 ML Lifecycle vs. Software Development Lifecycle

| SDLC | ML Lifecycle |
|------|-------------|
| Requirements gathering | Problem definition |
| Development | Model training |
| Testing | Model evaluation |
| Deployment | Model deployment |
| Observability & bug fixes | Monitoring & retraining |

The feedback loop is the same. The tools and automation are what MLOps brings to the ML side.

---

## 📋 Stage Summary

| # | Stage | Owner |
|---|-------|-------|
| 1 | Problem Definition | Business + Data Scientists |
| 2 | Data Collection | Data Scientists |
| 3 | Data Cleaning & Preparation | Data Scientists |
| 4 | Feature Engineering | Data Scientists + ML Engineers |
| 5 | Model Selection | Data Scientists |
| 6 | Model Training | Data Scientists + ML Engineers |
| 7 | Model Evaluation | Data Scientists + ML Engineers |
| 8 | Hyperparameter Tuning | Data Scientists |
| 9 | Model Deployment | ML Engineers + MLOps Engineers |
| 10 | Monitoring & Maintenance | MLOps Engineers |

---

## 🔗 Further Reading

- [Google's ML Lifecycle Overview](https://cloud.google.com/architecture/mlops-continuous-delivery-and-automation-pipelines-in-machine-learning)
- [Feature Engineering for Machine Learning — Towards Data Science](https://towardsdatascience.com/feature-engineering-for-machine-learning-3a5e293a5114)
- [Model Monitoring in Production](https://christophergs.com/machine%20learning/2020/03/14/how-to-monitor-machine-learning-models/)