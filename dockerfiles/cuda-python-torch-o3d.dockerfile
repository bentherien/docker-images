ARG REPO
ARG BASE

FROM ${REPO}:${BASE}



RUN apt install pigz && \
    pip install open3d motmetrics==1.1.3 neptune-client transformers matplotlib_venn && \ 
    

# ------------------------------------------------------------------------------
# config & cleanup
# ------------------------------------------------------------------------------

    rm -rf /tmp/* ~/*
