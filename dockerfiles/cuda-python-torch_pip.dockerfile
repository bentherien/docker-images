ARG REPO
ARG BASE

FROM ${REPO}:${BASE}

ARG TORCH_VERSION
ARG TORCHVISION_VERSION
ARG TORCHAUDIO_VERSION
ARG CUDA_VERSION_CONDA
# ------------------------------------------------------------------------------
# PyTorch
# https://pytorch.org/get-started/locally/
# ------------------------------------------------------------------------------

RUN export CU_VERSION=$(echo ${CUDA_VERSION%.*} | tr -d \.) && \
    pip install \
            torch==${TORCH_VERSION}+cu${CU_VERSION}\
            torchvision==${TORCHVISION_VERSION}+cu${CU_VERSION} \
            torchaudio==${TORCHAUDIO_VERSION} \
            -f https://download.pytorch.org/whl/torch_stable.html \
            && \

    conda install \
        skorch \
        pytorch-lightning \
        -c conda-forge \
        && \
    conda install tensorboard && \

# ------------------------------------------------------------------------------
# config & cleanup
# ------------------------------------------------------------------------------

    rm -rf /tmp/* ~/*
