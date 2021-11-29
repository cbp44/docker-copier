#!/bin/sh
# This script is the main entrypoint of the workflow Docker container.
#
# If you specify snakemake as the command, it will drop root privileges
# and run as the unprivileged snakemake user for security.

set -eu

printenv

if [ "$1" = 'copier' ]; then
  set -x
  
  # Running copier command, drop to unpriviledged user.
  su-exec user:user "$@"
else
  set -x
  
  # Not running copier, so run command as root like normal.
  exec "$@"
fi
