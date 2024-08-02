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

# Set the FLASK_APP environment variable
ENV FLASK_APP=manage:app

# Define the command to run the application
CMD ["sh", "-c", " \
  until pg_isready -h postgres; do \
    >&2 echo 'Postgres is unavailable - sleeping'; \
    sleep 1; \      
  done; \
  >&2 echo 'Postgres is up - executing command'; \
  heads=$(flask db heads | tr -d '[],' | tr -s ' ' | sed 's/ (head)//g'); \
  echo 'Heads: ' $heads; \
  if [ $(echo $heads | wc -w) -gt 1 ]; then \
    flask db merge -m 'merge heads' $heads; \
  fi; \
  flask db history; \
  flask db upgrade && python seed/seed.py && python manage.py run \
"]

# Expose the port the app runs on
EXPOSE 5000