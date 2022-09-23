ARG REPO
ARG BASE

FROM ${REPO}:${BASE}

ARG MMCV_VERSION
ARG MMDET_VERSION
# ARG MMSEG_VERSION

# ------------------------------------------------------------------------------
# mmdet3d dependencies
# ------------------------------------------------------------------------------

RUN export CU_VERSION=$(echo ${CUDA_VERSION%.*} | tr -d \.) && \
    export TORCH_VERSION=$(python -c "import torch; print(torch.__version__)") && \
    export TORCH_VERSION=${TORCH_VERSION%.*} && \
    git clone https://github.com/open-mmlab/mmdetection3d.git ~/mmdet3d && \
    cd ~/mmdet3d && \
    git checkout tags/v${MMDET3D_VERSION} && \
    pip install -v . && \



# ------------------------------------------------------------------------------
# config & cleanup
# ------------------------------------------------------------------------------

    rm -rf /tmp/* ~/*
