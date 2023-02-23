ARG REPO
ARG BASE

FROM ${REPO}:${BASE}



RUN conda install -c fvcore -c iopath -c conda-forge fvcore iopath && \
    conda install pytorch3d -c pytorch3d && \

# ------------------------------------------------------------------------------
# config & cleanup
# ------------------------------------------------------------------------------

    rm -rf /tmp/* ~/*
