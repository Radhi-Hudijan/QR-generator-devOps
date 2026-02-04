# devops-qr-code

This project is a cloud-native QR Code Generator application built with a Next.js frontend and a FastAPI backend, both fully containerized with Docker and deployed on Amazon EKS.

## Application

**Front-End** - A web application where users can submit URLs.

**API**: API that receives URLs and generates QR codes. The API stores the QR codes in cloud storage(AWS S3 Bucket).

**Both services** are packaged as Docker images and pushed to Docker Hub via GitHub Actions.

The application runs on Amazon EKS, using Kubernetes Services for internal communication.

## Running locally

### API

The API code exists in the `api` directory. You can run the API server locally:

- Clone this repo
- Make sure you are in the `api` directory
- Create a virtualenv by typing in the following command: `python -m venv .venv`
- Install the required packages: `pip install -r requirements.txt`
- Create a `.env` file, and add you AWS Access and Secret key, check `.env.example`
- Also, change the BUCKET_NAME to your S3 bucket name in `main.py`
- Run the API server: `uvicorn main:app --reload`
- Your API Server should be running on port `http://localhost:8000`

### Front-end

The front-end code exits in the `front-end-nextjs` directory. You can run the front-end server locally:

- Clone this repo
- Make sure you are in the `front-end-nextjs` directory
- Install the dependencies: `npm install`
- Run the NextJS Server: `npm run dev`
- Your Front-end Server should be running on `http://localhost:3000`

## Goal

The goal is to get hands-on with DevOps practices like Containerization, CICD and monitoring.
