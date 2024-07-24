# Stage 1: Build
FROM python:3.12-alpine AS base

# Set the working directory in the container
WORKDIR /app

# Install necessary packages including postgresql-client
RUN apk add --no-cache postgresql-client

# Copy the requirements file into the container
COPY requirements.txt requirements.txt

# Upgrade pip and install the Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy the rest of the application's code into the container
COPY . .

# Stage 2: Run
FROM base

# Set the working directory in the container
WORKDIR /app

# Copy the dependencies from the build stage
COPY --from=base /app /app

# Copy db-wait.sh vào thư mục gốc của container
COPY db-wait.sh /db-wait.sh
RUN chmod +x /db-wait.sh

# Set the FLASK_APP environment variable
ENV FLASK_APP=manage:app

# Define the command to run the application
CMD ["sh", "-c", "/db-wait.sh postgres && flask db upgrade && python seed/seed.py && python manage.py run"]

# Expose the port the app runs on
EXPOSE 5000
