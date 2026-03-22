# How MLOps Engineers Help ML Engineers

> MLOps Engineers focus on the **infrastructure and automation side** so that ML Engineers can concentrate on **model logic and APIs**.  
> Their goal: take what ML Engineers build and turn it into a **scalable, reliable, and production-grade service** that real users can depend on.

---

## The Problem: The API is Still Local

At this point in the project:
- The ML Engineer has built `app.py` — a Flask API wrapping the model
- The model is accessible via `curl` on `localhost:5001`

But "localhost" means it only runs on one person's machine. To make the model **publicly available**, a few more steps are needed — and those steps belong to MLOps engineers.

---

## What MLOps Engineers Do

### Step 1: Containerize the Model (This Lecture)

The first and most immediate activity is **containerization using Docker**. This ensures the model API runs the same way on a laptop, a VM, or a Kubernetes cluster — eliminating environment-related issues entirely.

#### Writing the Dockerfile

```dockerfile
# Use Python base image to avoid manually installing Python
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy and install dependencies FIRST (reduces Docker image size)
COPY requirements.txt .
RUN python -m pip install --upgrade pip
RUN python -m pip install -r requirements.txt

# Copy the rest of the source code
COPY . .

# Expose the API port
EXPOSE 5001

# Start the API
CMD ["python", "app.py"]
```

> **Best Practice:** Always copy `requirements.txt` and install dependencies **before** copying the full source code. Docker caches layers — if only the source code changes, the dependency layer doesn't need to rebuild, keeping image sizes small and builds fast.

#### Building and Running the Container

```bash
# Build the image
docker build -t hello-mlops:latest .

# Run the container in the background, binding port 5001
docker run -d -p 5001:5001 hello-mlops:latest

# Verify the container is running
docker ps

# Test the model via curl (same as before, now running in Docker)
curl -X POST http://localhost:5001/predict \
  -H "Content-Type: application/json" \
  -d '{"features": [1, 1, 1, 1]}'
# → {"prediction": 0}  → Setosa ✅
```

---

### Step 2: Deploy to VMs or Kubernetes *(Future Lectures)*

Once containerized, MLOps engineers handle deployment:
- **VMs** for simpler, smaller-scale setups
- **Kubernetes clusters** for scalability and resilience
- Managing configuration and environment variables per environment

ML Engineers don't need to worry about servers, clusters, or runtime management.

### Step 3: Load Balancing and Networking *(Future Lectures)*

To handle real user traffic, MLOps engineers:
- Introduce **load balancers** in front of the model API
- Configure **networking** for secure service-to-service communication
- Distribute traffic evenly across multiple running instances

### Step 4: Make the Service Production-Ready *(Future Lectures)*

The final production layers added by MLOps engineers:
- **Health checks** — is the service alive and responding?
- **Logging and monitoring** — what is the service doing?
- **Safe rollout and rollback** — deploy new models without downtime

---

## Summary: From Local to Production

```
ML Engineer builds API (app.py)  →  Runs on localhost only
        ↓
MLOps Engineer writes Dockerfile  →  Packages model + API into a container
        ↓
MLOps Engineer deploys container  →  Runs on VM / Kubernetes
        ↓
MLOps Engineer adds load balancer, networking, monitoring
        ↓
Real users access the model reliably at scale
```

---

## Key Takeaway

Containerization is the **first step** MLOps engineers take to help ML engineers. Everything else — infrastructure creation, Kubernetes manifests, networking, security — builds on top of this foundation and will be covered in future lectures.