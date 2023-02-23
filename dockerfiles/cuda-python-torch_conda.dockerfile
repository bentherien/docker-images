ARG REPO
ARG BASE

FROM ${REPO}:${BASE}

ARG TORCH_VERSION
ARG TORCHVISION_VERSION
ARG TORCHAUDIO_VERSION

# ------------------------------------------------------------------------------
# PyTorch
# https://pytorch.org/get-started/locally/
# ------------------------------------------------------------------------------

RUN echo ${CUDA_VERSION%.*} && \
    # export CU_VERSION=$(echo ${CUDA_VERSION%.*} | tr -d \.) && \
    conda install \
        pytorch=${TORCH_VERSION} \
        torchvision=${TORCHVISION_VERSION} \
        torchaudio=${TORCHAUDIO_VERSION} \
        cudatoolkit=${CUDA_VERSION%.*} \
        -c pytorch \
        && \

# ------------------------------------------------------------------------------
# config & cleanup
# ------------------------------------------------------------------------------

    rm -rf /tmp/* ~/*
