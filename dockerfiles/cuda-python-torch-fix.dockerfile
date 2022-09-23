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

RUN pip install \
            torch==${TORCH_VERSION}+cu111 \
            torchvision==${TORCHVISION_VERSION}+cu111 \
            torchaudio==${TORCHAUDIO_VERSION} \
            -f https://download.pytorch.org/whl/torch_stable.html \
            && \

    # conda install \
    #     skorch \
    #     pytorch-lightning \
    #     -c conda-forge \
    #     && \
    # conda install tensorboard && \

# ------------------------------------------------------------------------------
# config & cleanup
# ------------------------------------------------------------------------------

    rm -rf /tmp/* ~/*
