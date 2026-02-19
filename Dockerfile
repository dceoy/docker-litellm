FROM public.ecr.aws/docker/library/ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/opt/venv/bin:${PATH}"

WORKDIR /app

# Install system dependencies (rarely changes — cached aggressively)
RUN apt-get -qy update \
    && apt-get -qy install --no-install-recommends \
        ca-certificates \
        nodejs \
        npm \
        python3 \
        python3-pip \
        python3-venv \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create virtual environment
RUN python3 -m venv /opt/venv

# Install litellm with proxy extras (cache mount keeps pip cache across builds)
RUN --mount=type=cache,target=/root/.cache/pip \
    pip install --no-cache-dir 'litellm[proxy]'

# Generate Prisma client
RUN SCHEMA_PATH="$(python3 -c \
        'import pathlib, litellm; \
         print(pathlib.Path(litellm.__file__).parent / "proxy" / "schema.prisma")' \
    )" \
    && prisma generate --schema="${SCHEMA_PATH}"

# Copy config last (most frequently changed layer)
COPY config.yml .

EXPOSE 4000/tcp

ENTRYPOINT ["litellm"]
CMD ["--port", "4000", "--config", "config.yml"]
