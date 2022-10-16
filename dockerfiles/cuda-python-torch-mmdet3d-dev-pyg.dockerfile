ARG REPO
ARG BASE

FROM ${REPO}:${BASE}


# ------------------------------------------------------------------------------
# mmdet3d dependencies
# ------------------------------------------------------------------------------

RUN export CU_VERSION=$(echo ${CUDA_VERSION%.*} | tr -d \.) && \
    export TORCH_VERSION=$(python -c "import torch; print(torch.__version__)") && \
    # export TORCH_VERSION=${TORCH_VERSION%.*} && \
    pip install \ 
            motmetrics==1.1.3 \ 
            neptune-client \ 
            && \
    echo "[DOCKER] Using torch version: ${TORCH_VERSION} and cuda version: ${CU_VERSION}" && \
    pip install --no-index torch-scatter -f https://data.pyg.org/whl/torch-${TORCH_VERSION}+cu${CU_VERSION}.html && \
    pip install torch-sparse==0.6.12 -f https://data.pyg.org/whl/torch-${TORCH_VERSION}+cu${CU_VERSION}.html && \
    pip install torch-cluster -f https://data.pyg.org/whl/torch-${TORCH_VERSION}+cu${CU_VERSION}.html && \
    pip install torch-spline-conv -f https://data.pyg.org/whl/torch-${TORCH_VERSION}+cu${CU_VERSION}.html && \
    pip install torch-geometric && \


# ------------------------------------------------------------------------------
# config & cleanup
# ------------------------------------------------------------------------------

    rm -rf /tmp/* ~/*
