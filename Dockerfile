FROM docker.io/python:3.10-alpine AS base

#################### builder ####################
FROM base AS builder

RUN set -eux; \
  # Install gcc and libraries needed for building regex during pip install step
  apk add --no-cache \
    gcc \
    musl-dev; \
  # Install copier
  pip install --no-cache-dir copier

#################### /builder ####################

#################### final ####################
FROM base AS final

# Add non-root user to run copier
RUN set -eux; \
  adduser -D user; \
  mkdir -p /usr/src/dest_path; \
  chown user /usr/src/dest_path

# Install git
RUN set -eux; \
  apk add --no-cache git

# Copy over python packages and copier script from builder
COPY --from=builder /usr/local/lib/python3.10 /usr/local/lib/python3.10
COPY --from=builder /usr/local/bin/copier /usr/local/bin/copier

WORKDIR /usr/src/dest_path

# Run as non-root user created earlier
USER user

ENTRYPOINT ["copier"]
CMD ["--help"]

#################### /final ####################
