# Use an official Python runtime 
# as a parent image
FROM python:3.10
# Set the working directory to /app
WORKDIR /app
# Copy the current directory contents 
# into the container at /app
COPY . /app
# Copy requirements and install
COPY requirements.txt .
# Install any needed packages 
# specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
# Make port 5000 available to the world 
# outside this container
EXPOSE 5000
# Define environment variable
CMD ["python", "app.py"]
