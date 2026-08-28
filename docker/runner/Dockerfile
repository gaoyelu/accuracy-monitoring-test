FROM quay.io/ascend/vllm-ascend:releases-v0.18.0

ARG RUNNER_VERSION=2.322.0
ARG RUNNER_ARCH=arm64
ARG RUNNER_HOME=/home/runner/actions-runner

ENV RUNNER_VERSION=${RUNNER_VERSION}
ENV RUNNER_ARCH=${RUNNER_ARCH}
ENV RUNNER_HOME=${RUNNER_HOME}

RUN groupadd -g 1001 runner && \
    useradd -m -u 1001 -g runner runner && \
    apt-get update -qq && \
    apt-get install -y -qq --no-install-recommends \
        curl \
        tar \
        jq \
        sudo \
        ca-certificates \
        gnupg \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p ${RUNNER_HOME} && \
    cd ${RUNNER_HOME} && \
    curl -fsSL -o actions-runner.tar.gz \
        "https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-${RUNNER_ARCH}-${RUNNER_VERSION}.tar.gz" && \
    tar xzf actions-runner.tar.gz && \
    rm actions-runner.tar.gz && \
    chown -R runner:runner ${RUNNER_HOME}

RUN echo "runner ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER runner
WORKDIR ${RUNNER_HOME}

ENTRYPOINT ["/entrypoint.sh"]
