# docker-copier

Lightweight alpine-based Docker container to securely run [copier](https://github.com/copier-org/copier). You can read the copier documentation [here](https://copier.readthedocs.io/en/stable/).

### Features
- Based on official `python:3.10-alpine` image
- Runs copier as non-root user
- Default volume configuration persists results back to the host machine
- Mounts `~/.ssh` as read-only inside container so copier can work with your private GitHub repositories too
- Uses multi-stage builds to trim size of final image

## Quick Start

Just build and run the container using `docker-compose`.

The example usage below creates a new Snakemake workflow from the [`snakemake-workflow-template`](https://github.com/snakemake-workflows/snakemake-workflow-template) GitHub repository.

```sh
# Build image
docker-compose build

# Run copier
docker-compose run --rm copier copy gh:snakemake-workflows/snakemake-workflow-template /usr/src/dest_path
```
