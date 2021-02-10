FROM ubuntu:latest
ENV PATH /root/.cargo/bin:${PATH}
RUN sudo apt-get install \
    alsa-devel \
    binutils \
    binutils-devel \
    cmake \
    curl \
    expat \
    freetype2-devel \
    gcc-c++ \
    git \
    go1.12 \
    gzip \
    jq \
    kcov \
    kubernetes-client \
    libcurl-devel \
    libdw-devel \
    libelf-devel \
    libexpat-devel \
    libopenssl-devel \
    libxcb-devel \
    npm \
    openssh \
    postgresql12 \
    postgresql-devel \
    python \
    wget
RUN go get -u github.com/cloudflare/cfssl/cmd/...
RUN ln -s /root/go/bin/* /bin/
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN rustup default nightly &&\
    rustup update
RUN rustup component add clippy rustfmt && \
    rustup target add \
        wasm32-unknown-unknown \
        wasm32-unknown-emscripten \
        asmjs-unknown-emscripten
RUN cargo install \
    cargo-edit \
    cargo-kcov \
    cargo-update \
    cargo-web \
    wasm-pack
RUN export RUST_BACKTRACE=1
RUN cargo install diesel_cli --no-default-features --features postgres
RUN npm install -g rollup
