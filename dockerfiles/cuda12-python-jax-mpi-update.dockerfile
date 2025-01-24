ARG REPO
ARG BASE

FROM ${REPO}:${BASE}

COPY dockerfiles/setenv.sh /setenv.sh
ENTRYPOINT ["/setenv.sh"]

# ------------------------------------------------------------------------------
# PyTorch
# https://pytorch.org/get-started/locally/
# ------------------------------------------------------------------------------

RUN pip install torch==2.2.0 torchvision==0.17.0 torchaudio==2.2.0 --index-url https://download.pytorch.org/whl/cpu \
    pip install smart_open && \
    pip install -U jax chex flax && \

# ------------------------------------------------------------------------------
# config & cleanup
# ------------------------------------------------------------------------------

    rm -rf /tmp/* ~/*
