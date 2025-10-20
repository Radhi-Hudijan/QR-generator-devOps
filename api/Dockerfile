FROM python:3.9 

# Set working directory inside the container
WORKDIR /user/src/app

# Copy requirements file and install dependencies to the working directory
COPY requirements.txt ./

# Install dependencies specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the content of the local directory to the working directory
COPY . .

# Expose port 80 for the FastAPI application & run the application using Uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]