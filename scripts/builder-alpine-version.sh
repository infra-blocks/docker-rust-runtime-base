#!/bin/sh

set -e

BUILDER_TAG=${BUILDER_TAG:?"missing BUILDER_TAG environment variable!"}

builder_image="public.ecr.aws/infrastructure-blocks/docker-rust-builder-base:${BUILDER_TAG}"
alpine_version=$(docker run --rm -q "${builder_image}" cat /etc/alpine-release)
# Only keep the major and minor version.
echo "${alpine_version%.*}"
