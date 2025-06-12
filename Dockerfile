# Stage 1: Build
FROM python:3.10-slim AS base

# Set the working directory in the container
WORKDIR /app
RUN apt update && apt install -y \
  gcc \       
  libpq-dev \
  python3-dev \
  postgresql-client \
  build-essential

# Copy only necessary files first (ignore migrations/)
COPY requirements.txt requirements.txt

# Upgrade pip and install the Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy the rest of the application's code, but exclude migrations/
COPY . /app
RUN rm -rf /app/migrations  # Chắc chắn xóa migrations/

# Stage 2: Run
FROM base

# Set the working directory in the container
WORKDIR /app

# Set the FLASK_APP environment variable
ENV FLASK_APP=manage:app
# Set to use print()
ENV PYTHONUNBUFFERED=1        

# Expose the port
EXPOSE 5000

# CMD: chạy SSH server trước, rồi tiếp tục chờ Postgres và chạy Flask
CMD ["sh", "-c", " \
  service ssh start && \
  timeout=30; \
  while ! pg_isready -h postgres; do \
    >&2 echo 'Postgres is unavailable - sleeping'; \
    sleep 1; \
    timeout=$((timeout-1)); \
    if [ $timeout -le 0 ]; then \
      >&2 echo 'Postgres failed to start'; \
      exit 1; \
    fi; \
  done; \
  >&2 echo 'Postgres is up - executing command'; \
  if [ ! -d 'migrations/versions' ]; then \
    flask db init && flask db migrate -m \"Initial migration\"; \
  fi; \
  flask db upgrade && python init_db/seed.py && flask run --host=0.0.0.0 \
"]
