# How Data Scientists Create a Model

A step-by-step walkthrough of how data scientists go from raw data to a deployable ML model — using flower species prediction as a practical example.

---

## 🗺️ The 7-Step Pipeline

```
Dataset → Split → Algorithm → Train → Test → Improve → Package
```

---

## Step 1 — Start with a Dataset

Every model begins with data. A dataset contains:

- **Input features** — the measurable properties (e.g. petal length, sepal width)
- **Output label** — the correct answer (e.g. flower species)

### Example Dataset Structure

| Petal Length | Petal Width | Sepal Length | Sepal Width | Species  |
|:------------:|:-----------:|:------------:|:-----------:|:--------:|
| 4            | 3           | 5            | 6           | Rose     |
| 5            | 4           | 2            | 3           | Jasmine  |
| ...          | ...         | ...          | ...         | ...      |

> 💡 Today, large labeled datasets are freely available online — data scientists don't need to build them from scratch.

---

## Step 2 — Split the Dataset

Data scientists split the dataset before any training begins:

| Split | Proportion | Purpose |
|-------|-----------|---------|
| **Training data** | ~80% | Used to train the algorithm |
| **Testing data** | ~20% | Used to evaluate the trained model |

> Why keep 20% aside? You should never test a student with questions they already memorized.
> The test set has real labels, so the model's predictions can be compared against ground truth.

---

## Step 3 — Choose an Algorithm

Choosing the right algorithm is one of the most critical decisions — and it belongs to the **data scientist**, not the MLOps engineer.

Popular algorithms for classification problems like flower prediction:

| Algorithm | Notes |
|-----------|-------|
| **Logistic Regression** | Simple, interpretable, great baseline |
| **Decision Tree** | Easy to visualize, works well for this problem |
| **K-Nearest Neighbors (KNN)** | Intuitive, compares new inputs to known examples |

For flower species prediction, **Decision Tree** or **Logistic Regression** are both strong choices.

---

## Step 4 — Train the Model

Training feeds the 80% training data (features + labels) into the chosen algorithm.

During training, the algorithm:
1. Looks at each sample's features and its label
2. Starts identifying patterns (e.g. *small sepal length → likely Rose*)
3. Builds a **mathematical function** that maps features to predictions

```
Input features  →  [Algorithm]  →  Mathematical function (Model)
```

You don't write these patterns — the algorithm finds them automatically.

---

## Step 5 — Test the Model

Once trained, the model is evaluated on the **held-out 20% test data**.

Key questions:
- How many predictions are correct?
- Where is the model making mistakes?
- Is the accuracy acceptable for the use case?

If the model performs well → move to packaging.  
If not → go back and improve.

---

## Step 6 — Improve (If Needed)

Poor performance can come from two places:

| Root Cause | Fix |
|------------|-----|
| Bad/noisy dataset | Clean the data or gather more samples |
| Wrong algorithm choice | Try a different algorithm |
| Suboptimal settings | Tune hyperparameters |

The data scientist iterates through Steps 3–5 until the model is accurate enough.

---

## Step 7 — Package the Model

Once the model performs well, it is saved to a file so it can be used outside the training environment.

### Common Save Formats

| Format | Notes |
|--------|-------|
| `.pkl` | Python's pickle format — most common |
| `.joblib` | Optimized for large numpy arrays |
| `.onnx` | Cross-platform, framework-agnostic |

### What Happens After Packaging?

The saved model file is handed off to software developers or ML engineers who:

- Wrap it in an **API** (e.g. FastAPI, Flask)
- Embed it in a **web or mobile application**
- Deploy it via an **MLOps pipeline**

This is what end users ultimately interact with.

---

## 🔁 Full Pipeline Summary

```
1. Collect Dataset
       ↓
2. Split (80% Train / 20% Test)
       ↓
3. Choose Algorithm (Data Scientist's call)
       ↓
4. Train on 80% Data
       ↓
5. Test on 20% Data
       ↓
6. Improve if Accuracy is Low  ←──┐
       ↓                          │
       └──────────────────────────┘
7. Package & Deploy (.pkl / .joblib / .onnx)
```

---

## 📚 Key Takeaways

- A model is built through a **structured, repeatable process** — not guesswork
- The **80/20 train-test split** is the standard starting point
- **Algorithm selection** is the data scientist's responsibility
- A model that performs poorly is **retrained**, not abandoned
- The final packaged model is what gets integrated into real applications