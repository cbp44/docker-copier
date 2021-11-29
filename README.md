# docker-copier

Lightweight alpine-based Docker container to securely run [copier](https://github.com/copier-org/copier).

You can read the copier documentation [here](https://copier.readthedocs.io/en/stable/).

### Features
- Based on official `python:3.10-alpine` image
- Runs copier as non-root user
- Default volume configuration persists results back to the host machine
- Mounts `~/.ssh` as read-only inside container so copier can work with your private GitHub repositories
- Uses multi-stage builds to trim size of final image

View on [Docker Hub](https://hub.docker.com/r/cbp44/copier).

## Quick Start

Just pull and run the image from [Docker Hub](https://hub.docker.com/r/cbp44/copier).

```shell
# Pull the image
docker pull cbp44/copier:latest

# This should print the version of copier installed
docker run --rm copier --version
```

### Copy a Template

The example usage below creates a new Snakemake workflow from the [`snakemake-workflow-template`](https://github.com/snakemake-workflows/snakemake-workflow-template) GitHub repository.

```shell
# Path where copier output will go
mkdir workflow

docker run --rm -it -v $(pwd)/workflow:/usr/src/copier copier \
  copy gh:snakemake-workflows/snakemake-workflow-template /usr/src/copier

# Output will be in $(pwd)/workflow
```

## Build it Yourself

Clone [this repository](https://github.com/cbp44/docker-copier), then build and run the container using `docker-compose`.

```shell
# Clone repository
git clone https://github.com/cbp44/docker-copier

# Build the image
docker-compose build

# Run copier
docker-compose run --rm -it copier \
  copy gh:snakemake-workflows/snakemake-workflow-template /usr/src/dest_path

# Output will be in ./dest_path
```
