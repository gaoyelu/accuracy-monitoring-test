#!/bin/bash
set -e

if [ -z "${GITHUB_TOKEN}" ]; then
    echo "Error: GITHUB_TOKEN environment variable is required"
    exit 1
fi

if [ -z "${GITHUB_REPOSITORY}" ]; then
    echo "Error: GITHUB_REPOSITORY environment variable is required (e.g. gaoyelu/accuracy-monitoring-test)"
    exit 1
fi

RUNNER_NAME="${RUNNER_NAME:-$(hostname)}"
RUNNER_LABELS="${RUNNER_LABELS:-self-hosted,linux,arm64,e2e}"
RUNNER_GROUP="${RUNNER_GROUP:-default}"

cd "${RUNNER_HOME}"

if [ ! -f .runner ]; then
    echo "Configuring GitHub Actions Runner..."
    ./config.sh \
        --url "https://github.com/${GITHUB_REPOSITORY}" \
        --token "${GITHUB_TOKEN}" \
        --name "${RUNNER_NAME}" \
        --labels "${RUNNER_LABELS}" \
        --runnergroup "${RUNNER_GROUP}" \
        --unattended \
        --replace \
        --work _work
fi

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --token "${GITHUB_TOKEN}" || true
}
trap cleanup EXIT

echo "Starting runner..."
./run.sh
