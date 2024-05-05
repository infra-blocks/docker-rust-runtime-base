# docker-rust-runtime-base
[![Build Image](https://github.com/infrastructure-blocks/docker-rust-runtime-base/actions/workflows/build-image.yml/badge.svg)](https://github.com/infrastructure-blocks/docker-rust-runtime-base/actions/workflows/build-image.yml)
[![Update From Template](https://github.com/infrastructure-blocks/docker-rust-runtime-base/actions/workflows/update-from-template.yml/badge.svg)](https://github.com/infrastructure-blocks/docker-rust-runtime-base/actions/workflows/update-from-template.yml)

This is a runtime image for GitHub Actions that run Rust code. The image is the compliment of the matching 
[builder image](https://github.com/infrastructure-blocks/docker-rust-builder-base/).

The image is based on `alpine`, so the matching builder image should also be based on `alpine`.

## Usage

Here is an example Dockerfile where a Rust project is built using this base image:

```Dockerfile
# Should be passed as a build argument.
ARG RUST_VERSION=1.75

# The base tag is the version of the Rust toolchain to use.
FROM public.ecr.aws/infrastructure-blocks/docker-rust-builder-base:${RUST_VERSION} as builder

# This base builder image uses alpine, so the runtime image should also use alpine.
FROM public.ecr.aws/infrastructure-blocks/docker-rust-runtime-base:${RUST_VERSION}
RUN apk update && apk add --no-cache <extra-runtime-dependencies>
COPY --from=builder /usr/local/cargo/bin/<your-rust-project> /usr/local/bin/<your-rust-project>
ENTRYPOINT ["<your-rust-project>"]
```

Note that you may need to install some runtime libraries (the `<extra-runtime-dependencies>` placeholder shown
in the example).
