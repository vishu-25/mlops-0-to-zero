# Role of a Data Scientist

> Think of a Data Scientist as the person who turns raw data into insights and a working model.  
> Their focus is **data, logic, and predictions** — not deployment, automation, or production systems.

---

## Step-by-Step Workflow

### 1. Understand the Business Problem

The first job is **not coding**. A data scientist starts by answering:

- What problem are we trying to solve?
- What decision will this model help make?
- What does "success" look like?

For our Hello World project, the requirement was defined by the product owner:
> *"Build a system to predict flower species based on petal length, petal width, sepal length, and sepal width."*

---

### 2. Collect and Understand Data

Once the problem is clear, the data scientist works with available data sources — CSV files, databases, logs, APIs, etc.

For this project, the publicly available **Iris dataset** was used. It contains:

| Feature | Example Value |
|---|---|
| Sepal Length | 5.1 |
| Sepal Width | 3.5 |
| Petal Length | 1.4 |
| Petal Width | 0.2 |
| **Target (Species)** | **0 = Setosa, 1 = Versicolor, 2 = Virginica** |

> **Note:** Sometimes data scientists must gather data from internal/external sources. In simple or popular use cases like this, public datasets are available and ready to use.

---

### 3. Clean and Prepare the Data

Real-world data is messy. A data scientist:

- Removes duplicates
- Handles missing values
- Fixes incorrect data
- Converts text to numerical form
- Normalizes or scales numbers if needed

> This step often takes **more time than model building** in real projects.

---

### 4. Explore the Data (EDA)

The data scientist explores patterns and relationships by plotting graphs, checking correlations, comparing distributions, and identifying outliers.

**Goal:** Decide which features are useful and which model might work well.

---

### 5. Write the Training Script (`train.py`)

The core of the data scientist's work — a Python script that:

1. **Loads the dataset** from the import
2. **Splits the data** into training and test sets (e.g., 80% train / 20% test via `test_size=0.2`)
3. **Chooses an algorithm** — in this case, **Logistic Regression** was selected as the best fit
4. **Trains the model** on the training data — the model identifies patterns and builds a mathematical function
5. **Saves the model** as `artifacts/model.pkl`
6. **Creates a metrics file** to track model performance and accuracy

```bash
# Set up Python virtual environment
python3 -m venv .venv
source .venv/bin/activate

# Verify activation
which python3

# Install dependencies
python3 -m pip install -r requirements.txt

# Train the model
python3 train.py
```

> **Result:** Test accuracy = ~100% *(due to the simplicity of the Iris dataset — real-world accuracy is rarely this high)*

---

### 6. Evaluate the Model (`run_model.py`)

After training, the data scientist runs inference to validate predictions manually:

```bash
# Example predictions
python3 run_model.py --input 10 1 5 10   # → Prediction: 2 (Virginica)
python3 run_model.py --input 1 1 1 1     # → Prediction: 0 (Setosa)
```

---

### 7. Save the Model

Once satisfied with results, the trained model is saved as `artifacts/model.pkl` and shared with the team.

At this point:
- ✅ The model exists as a file
- ❌ It is **NOT deployed**
- ❌ It is **NOT automated**

---

## The Problem: Too Many Manual Activities

Even in this simple project, notice the manual effort involved:

- Script lives only on the **local machine**
- Commands must be **re-run manually** after every change
- Moving to a new machine requires **re-setting up everything** from scratch:
  - Create virtual environment
  - Download dependencies
  - Copy files
  - Re-run all commands

> 💡 **This is exactly where MLOps engineers step in.** The next lecture covers how MLOps engineers automate and streamline all of this for data scientists.