# docker-litellm

Dockerfile and Docker Compose configuration for
[LiteLLM](https://github.com/BerriAI/litellm) proxy server with PostgreSQL
and Prometheus.

## Prerequisites

- [Docker](https://docs.docker.com/engine/install/) (with Compose V2)

## Setup

1. Copy the example environment file and edit it:

   ```sh
   cp .env.example .env
   ```

   Set `LITELLM_MASTER_KEY`, `LITELLM_SALT_KEY`, and your LLM API keys in
   `.env`.

2. Edit `config.yaml` to configure your model routing.  See the
   [LiteLLM proxy config docs](https://docs.litellm.ai/docs/proxy/configs)
   for details.

## Usage

```sh
docker compose up -d
```

The services will be available at:

| Service    | URL                     |
|------------|-------------------------|
| LiteLLM    | http://localhost:4000   |
| Prometheus | http://localhost:9090   |

To view logs:

```sh
docker compose logs -f litellm
```

To stop:

```sh
docker compose down
```

To stop and remove volumes:

```sh
docker compose down -v
```
