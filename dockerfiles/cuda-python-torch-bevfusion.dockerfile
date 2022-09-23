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
    pip install \
        mmcv-full==${MMCV_VERSION} \
        -f https://download.openmmlab.com/mmcv/dist/cu${CU_VERSION}/torch${TORCH_VERSION}/index.html && \

    pip install \
        # mmsegmentation==${MMSEG_VERSION} \
        mmdet==${MMDET_VERSION} \
        pillow==8.4.0 \
        torchpack \
        tqdm \
        nuscenes-devkit \
        && \
    apt-get update && \
    apt-get install gcc && \
    apt-get install \ 
                openmpi-bin \ 
                openmpi-common \
                libopenmpi-dev \
                libgtk2.0-dev \ 
                && \ 
    wget https://www.open-mpi.org/software/ompi/v4.1/downloads/openmpi-4.1.1.tar.gz && \ 
    tar  -xvzf /home/mpiuser/openmpi-4.1.1.tar.gz && \ 
    cd openmpi-4.1.1 && \
    ./configure && \
    make install && \
    pip install mpi4py && \


# ------------------------------------------------------------------------------
# config & cleanup
# ------------------------------------------------------------------------------

    rm -rf /tmp/* ~/*
