ARG REPO
ARG BASE

FROM ${REPO}:${BASE}
ENV PATH /opt/conda/bin:$PATH

ARG PYTHON_VERSION
ARG CONDA_VERSION

# ------------------------------------------------------------------------------
# miniconda
# https://github.com/ContinuumIO/docker-images/blob/master/miniconda3/debian/Dockerfile
# ------------------------------------------------------------------------------

RUN set -x && \
    UNAME_M="$(uname -m)" && \
    if [ "${CONDA_VERSION}" != "latest" ]; then \
        CONDA_VERSION="py$(echo ${PYTHON_VERSION} | tr -d \.)_${CONDA_VERSION}"; \
    fi && \
    if [ "${UNAME_M}" = "x86_64" ]; then \
        MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-${CONDA_VERSION}-0-Linux-x86_64.sh"; \
    elif [ "${UNAME_M}" = "s390x" ]; then \
        MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-${CONDA_VERSION}-Linux-s390x.sh"; \
    elif [ "${UNAME_M}" = "aarch64" ]; then \
        MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-${CONDA_VERSION}-Linux-aarch64.sh"; \
    elif [ "${UNAME_M}" = "ppc64le" ]; then \
        MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-${CONDA_VERSION}-Linux-ppc64le.sh"; \
    fi && \
    wget "${MINICONDA_URL}" -O miniconda.sh -q && \
    echo "${SHA256SUM} miniconda.sh" > shasum && \
    mkdir -p /opt && \
    sh miniconda.sh -b -p /opt/conda && \
    rm miniconda.sh shasum && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    /opt/conda/bin/conda clean -afy && \

# ------------------------------------------------------------------------------
# essential libraries
# ------------------------------------------------------------------------------

    conda install \
        python=${PYTHON_VERSION} \

        # file formats
        pyyaml \
        h5py \

        # maths & data
        numpy \
        scipy \
        scikit-learn \
        pandas \

        # image processing
        pillow \
        scikit-image \

        # plotting
        matplotlib \
        seaborn \

        # jupyter
        jupyterlab \

        # -c conda-forge \
        && \
    
    pip install \
        # logging
        neptune-client \
        wandb \

        && \



# ------------------------------------------------------------------------------
# nodejs (required by jupyter plugins)
# https://github.com/nodesource/distributions/blob/master/README.md
# ------------------------------------------------------------------------------

    curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    DEBIAN_FRONTEND=noninteractive apt-get install -q -y --no-install-recommends nodejs && \


# ------------------------------------------------------------------------------
# config & cleanup
# ------------------------------------------------------------------------------

    rm -rf /tmp/* ~/*
