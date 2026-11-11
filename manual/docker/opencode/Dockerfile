FROM ubuntu:26.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    build-essential \
    ca-certificates \
    clang \
    clang-format \
    clang-tidy \
    clangd \
    cmake \
    curl \
    file \
    gcovr \
    gdb \
    git \
    gnupg \
    doxygen \
    iproute2 \
    iputils-ping \
    jq \
    lcov \
    libbenchmark-dev \
    libgtest-dev \
    neovim \
    ninja-build \
    nodejs \
    npm \
    pkg-config \
    python3 \
    python3-cryptography \
    python3-pip \
    python3-scapy \
    python3-venv \
    ripgrep \
    shellcheck \
    tar \
    tcpdump \
    tshark \
    valgrind \
    zstd \
    && apt-get clean \
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
    mkdir -p /home/hostuser/.local/share/opencode && \
    chown -R hostuser:hostuser /home/hostuser

ENV EDITOR=nvim
ENV VISUAL=nvim
ENV PATH="/home/hostuser/.opencode/bin:${PATH}"

USER hostuser

RUN curl -fsSL https://opencode.ai/v2/install | bash -s -- --version 2.0.0

CMD ["/bin/bash"]
