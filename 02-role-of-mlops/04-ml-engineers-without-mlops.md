# Role of an ML Engineer

> Once a Data Scientist builds a working model, the question becomes:  
> *"How do we let real users or applications actually use this model?"*  
> This is where the **ML Engineer** steps in.

---

## The Problem: A Model is Just a File

At this point in the project:
- The data scientist has trained the model
- MLOps engineers have set up continuous training via CI/CD
- Every code change triggers a new `model.pkl` uploaded to the GitHub Actions artifact location

Fellow data scientists and ML engineers can **download and evaluate** the model from there. But what about **end users**?

> Imagine you're a data scientist at Netflix and you've built a recommendation model. You cannot expect millions of users to go to a GitHub artifact location, download a `.pkl` file, and get their movie recommendations. That is impossible.

What you actually need is an **API** — so the model can be integrated into backend systems like the Netflix mobile app or website.

---

## Two Primary Responsibilities of ML Engineers

1. **Develop an API** for the model so it can be integrated into backend systems
2. **Ensure scalability and performance** — data scientists optimize for training efficiency; ML engineers optimize for serving millions of users in production

This lecture focuses on **building the API**.

---

## Building the API: `app.py`

ML engineers typically use Python to build the API. Two common choices are:

- **Flask** — simple, minimalistic, lightweight; great for straightforward requirements
- **FastAPI** — modern, faster, increasingly preferred (covered in future lectures)

### How `app.py` Works

```
Import statements  →  Load model  →  Define API endpoint  →  Run the server
```

#### Key Sections of the Script

**1. Model Loading**
```python
model_path = os.path.join("artifacts", "model.pkl")
```
The script looks for `model.pkl` in the artifacts folder. If the model is not found, it can either return an error or retrigger `train.py` to regenerate it.

**2. API Endpoint (`/predict`)**
- Path: `/predict`
- HTTP Method: **POST** — because the client sends input features and the model returns an output
  - Using GET or PUT will return an error
- Input format: **JSON** — reads `sepal_length`, `sepal_width`, `petal_length`, `petal_width`
- Output format: **JSON** — returns the predicted flower species

**3. Input Validation**
Input features are verified to be in the expected format before being passed to the model, preventing crashes from bad or missing data.

**4. Prediction**
```python
model.predict(features)  # → returns 0, 1, or 2
```

**5. Running the Server**
```python
app.run(host="localhost", port=5001)
```

---

## Testing the API

Once `app.py` is running, predictions can be made via `curl`:

```bash
# Start the API
python3 app.py
# → Running on http://localhost:5001

# Test with curl
curl -X POST http://localhost:5001/predict \
  -H "Content-Type: application/json" \
  -d '{"features": [10, 1, 5, 2]}'
# → {"prediction": 1}  → Versicolor

curl -X POST http://localhost:5001/predict \
  -H "Content-Type: application/json" \
  -d '{"features": [1, 1, 1, 1]}'
# → {"prediction": 0}  → Setosa
```

| Input Features | Prediction | Flower Species |
|---|---|---|
| `[10, 1, 5, 2]` | 1 | Versicolor |
| `[1, 1, 1, 1]` | 0 | Setosa |
| `[10, 1, 5, 10]` | 2 | Virginica |

---

## What ML Engineers Ensure

### Handle Input and Output Safely
In the real world, users send bad data. ML Engineers ensure:
- Inputs are validated before reaching the model
- Missing or incorrect fields are caught gracefully
- Errors don't crash the service or return incorrect predictions

### Make the Model Fast and Efficient
A model that works in a notebook may be slow or memory-heavy. ML Engineers:
- Load the model **once** at startup, not on every request
- Optimize prediction speed for real users at scale
- Ensure the service can handle repeated concurrent requests

---

## Summary

```
Trained model (model.pkl)
        ↓
   ML Engineer wraps it in an API (app.py)
        ↓
   API accepts JSON input → runs model.predict() → returns JSON output
        ↓
   Frontend / Backend / Mobile App calls the API
        ↓
   End users get predictions in real time
```

The model is no longer just a file — it is a **usable, integrated service**.