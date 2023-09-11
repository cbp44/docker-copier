# docker-copier

Lightweight alpine-based Docker container to securely run [copier](https://github.com/copier-org/copier).

You can read the copier documentation [here](https://copier.readthedocs.io/en/stable/).

This repository is cloned from [here](https://github.com/cbp44/docker-copier), and re-purposed primarily for personal use. 

### Features
- Based on official `python:3.10-alpine` image
- Runs copier as non-root user
- Default volume configuration persists results back to the host machine
~~- Mounts `~/.ssh` as read-only inside container so copier can work with your private GitHub repositories~~
- Uses multi-stage builds to trim size of final image

View on [GitHub Registry](ghcr.io/ejoosterop/docker-copier).

## Quick Start

Just pull and run the image from [GitHub Registry](ghcr.io/ejoosterop/docker-copier).

```shell
# Pull the image
docker pull ghcr.io/ejoosterop/docker-copier:latest

# This should print the version of copier installed
docker run --rm ghcr.io/ejoosterop/docker-copier copier --version
```

### Copy a Template

The example usage below creates a new Snakemake workflow from the [`snakemake-workflow-template`](https://github.com/snakemake-workflows/snakemake-workflow-template) GitHub repository.

```shell
# Path where copier output will go
mkdir workflow

# Using curly brackets in ${pwd} for Windows.
docker run --rm -it -v ${pwd}/workflow:/usr/src/copier ghcr.io/ejoosterop/docker-copier copier copy gh:snakemake-workflows/snakemake-workflow-template /usr/src/copier

# Output will be in $(pwd)/workflow
```

## Build it Yourself

**NOTE** THIS DOES CURRENTLY NOT WORK AS DESCRIBED.

Clone [this repository](https://github.com/EJOOSTEROP/docker-copier), then build and run the container using `docker-compose`.

```shell
# Clone repository
git clone https://github.com/EJOOSTEROP/docker-copier

# Build the image
docker-compose build

# Run copier
docker-compose run --rm -it copier \
  copy gh:snakemake-workflows/snakemake-workflow-template /usr/src/dest_path

# Output will be in ./dest_path
```
