FROM ubuntu:26.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    build-essential \
    ca-certificates \
    clang \
    clangd \
    clang-format \
    cmake \
    curl \
    git \
    iputils-ping \
    jq \
    gnupg \
    libgtest-dev \
    neovim \
    python3 \
    python3-pip \
    python3-venv \
    ripgrep \
    tar \
    zstd \
    && rm -rf /var/lib/apt/lists/*

ARG UID=1000
ARG GID=1000

RUN groupadd --gid ${GID} --non-unique hostuser && \
    useradd --uid ${UID} \
            --gid ${GID} \
            --create-home \
            --non-unique \
            --shell /bin/bash hostuser && \
    mkdir -p /home/hostuser/.config/opencode && \
    chown -R hostuser:hostuser /home/hostuser

ENV EDITOR=nvim
ENV VISUAL=nvim
ENV PATH="/home/hostuser/.opencode/bin:${PATH}"

USER hostuser

RUN curl -fsSL https://opencode.ai/v2/install | bash -s -- --version 2.0.0

CMD ["/bin/bash"]
