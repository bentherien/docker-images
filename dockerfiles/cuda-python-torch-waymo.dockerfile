ARG REPO
ARG BASE

FROM ${REPO}:${BASE}



RUN pip install waymo-open-dataset-tf-2-6-0==1.4.9 && \
    pip install pandas==1.0 && \
    

# ------------------------------------------------------------------------------
# config & cleanup
# ------------------------------------------------------------------------------

    rm -rf /tmp/* ~/*
