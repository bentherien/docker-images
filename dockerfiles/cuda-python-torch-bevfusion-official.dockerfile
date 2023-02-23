ARG REPO
ARG BASE

FROM ${REPO}:${BASE}

ARG MMCV_VERSION
ARG MMDET_VERSION
# ARG MMSEG_VERSION

# ------------------------------------------------------------------------------
# mmdet3d dependencies
# ------------------------------------------------------------------------------

# RUN export CU_VERSION=$(echo ${CUDA_VERSION%.*} | tr -d \.) && \
#     export TORCH_VERSION=$(python -c "import torch; print(torch.__version__)") && \
#     export TORCH_VERSION=${TORCH_VERSION%.*} && \
    
# RUN apt-get update && apt-get install wget -yq
# RUN apt-get install build-essential g++ gcc -y
# ENV DEBIAN_FRONTEND noninteractive
# RUN apt-get install libgl1-mesa-glx libglib2.0-0 -y
# RUN apt-get install openmpi-bin openmpi-common libopenmpi-dev libgtk2.0-dev git -y
# RUN pip install Pillow==8.4.0
# RUN pip install tqdm
# RUN pip install torchpack
RUN pip install mmcv==1.4.0 mmcv-full==1.4.0 mmdet==2.20.0
# RUN pip install nuscenes-devkit
# RUN pip install mpi4py==3.0.3
# RUN pip install numba==0.48.0


# ------------------------------------------------------------------------------
# config & cleanup
# ------------------------------------------------------------------------------

    rm -rf /tmp/* ~/*
