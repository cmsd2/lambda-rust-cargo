FROM lambci/lambda:build-provided

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    RUST_VERSION=1.39.0

RUN set -eux; \
    url="https://static.rust-lang.org/rustup/archive/1.19.0/x86_64-unknown-linux-gnu/rustup-init"; \
    curl -o rustup-init "$url"; \
    echo "36285482ae5c255f2decfab27d32ba19465804cb3ddf5a23e6ff2a7b0f6e0250 *rustup-init" | sha256sum -c -; \
    chmod +x rustup-init; \
    ./rustup-init -y --no-modify-path --profile minimal --default-toolchain $RUST_VERSION; \
    rm rustup-init; \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
    rustup --version; \
    cargo --version; \
    rustc --version;

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

ENV CRATE_DIR=.

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
