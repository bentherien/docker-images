ARG REPO
ARG BASE

FROM ${REPO}:${BASE}

COPY dockerfiles/setenv.sh /setenv.sh
ENTRYPOINT ["/setenv.sh"]

# ------------------------------------------------------------------------------
# MPI Setup and Installation
# ------------------------------------------------------------------------------

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    wget \
    build-essential \
    g++ \
    gcc \
    libgl1-mesa-glx \
    libglib2.0-0 \
    openmpi-bin \
    openmpi-common \
    libopenmpi-dev \
    libgtk2.0-dev \
    git \
    sudo

# Add sudo support for the default user (assuming default user is root)
RUN echo "root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# If you want to create a non-root user with sudo privileges, uncomment and modify these lines:
ARG USERNAME=btherien
RUN useradd -m ${USERNAME} && \
    usermod -aG sudo ${USERNAME} && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Set compiler environment variables
ENV CC=/usr/bin/gcc
ENV CXX=/usr/bin/g++
ENV MPICC=/usr/bin/mpicc
ENV MPICXX=/usr/bin/mpicxx

# Install mpi4py
RUN git clone https://github.com/mpi4py/mpi4py.git && \
    cd mpi4py && \
    python setup.py build --mpicc=${MPICC} && \
    python setup.py install && \
    cd .. && \
    rm -rf mpi4py

# ------------------------------------------------------------------------------
# Cleanup
# ------------------------------------------------------------------------------

RUN rm -rf /tmp/* ~/*
