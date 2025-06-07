# Stage 1: Build
FROM python:3.10-slim AS base

# Set working directory
WORKDIR /app

# Cài các gói cần thiết và SSH server
RUN apt update && apt install -y \
  gcc \
  libpq-dev \
  python3-dev \
  postgresql-client \
  build-essential \
  openssh-server && \
  mkdir /var/run/sshd

# Thiết lập mật khẩu root (không nên dùng trong production)
RUN echo "root:root" | chpasswd

# Cho phép đăng nhập SSH bằng mật khẩu
RUN sed -i 's/^#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Copy requirements và cài dependencies
COPY requirements.txt requirements.txt
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy toàn bộ source code
COPY . /app

# Xoá migrations nếu có
RUN rm -rf /app/migrations


# Stage 2: Runtime
FROM base

WORKDIR /app

# Biến môi trường Flask
ENV FLASK_APP=manage:app
ENV PYTHONUNBUFFERED=1

# Expose cả Flask và SSH
EXPOSE 5000 22

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
