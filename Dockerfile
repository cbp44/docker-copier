FROM docker.io/python:3.10-alpine AS base

#################### update ####################
FROM base AS update

# Obtain any recent security updates not in image
RUN set -eux; \
  apk update; \
  apk upgrade --verbose
#################### /update ####################

#################### builder ####################
FROM update AS builder

RUN set -eux; \
  # Install gcc and libraries needed for building regex during pip install step
  apk add --no-cache \
    gcc \
    musl-dev; \
  # Install copier
  pip install --no-cache-dir copier; \
  apk del \
    gcc \
    musl-dev
#################### /builder ####################

#################### final ####################
FROM update AS final

ARG COPIER_DEST_PATH
ENV COPIER_DEST_PATH=${COPIER_DEST_PATH:-/usr/src/copier}

WORKDIR "$COPIER_DEST_PATH"

# Add non-root user to run copier
RUN set -eux; \
  adduser -D user; \
  chown -R user:user "$COPIER_DEST_PATH"

RUN set -eux; \
  apk add --no-cache \
    # Install git, dependency of copier
    git \
    # Install su-exec to drop down from root when running copier
    su-exec

# Copy over python packages and copier script from builder
COPY --from=builder /usr/local/lib/python3.10 /usr/local/lib/python3.10
COPY --from=builder /usr/local/bin/copier /usr/local/bin/copier

COPY ./docker-entrypoint.sh /docker-entrypoint.sh

RUN set -eux; \
  chmod 0755 /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["copier","--version"]
# CMD ["bash"]
#################### /final ####################
