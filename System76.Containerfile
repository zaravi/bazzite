ARG BASE_IMAGE

FROM scratch AS ctx
COPY build_files /

FROM ${BASE_IMAGE} AS bazzite-system76

ARG IMAGE_NAME="bazzite-system76-nvidia-open"
ARG IMAGE_VENDOR="ublue-os"
ARG IMAGE_BRANCH="stable"
ARG BASE_IMAGE_NAME="kinoite"
ARG FEDORA_VERSION="45"
ARG VERSION_TAG
ARG VERSION_PRETTY

# Derive System76 support from the already-built Bazzite NVIDIA Open image.
RUN --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/chi_custom/install-system76 && \
    /ctx/image-info.sh && \
    /ctx/build-initramfs.sh && \
    /ctx/finalize.sh && \
    /ctx/cleanup.sh && \
    bootc container lint
