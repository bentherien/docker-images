ARG REPO
ARG BASE

FROM ${REPO}:${BASE}

# ------------------------------------------------------------------------------
# PyTorch
# https://pytorch.org/get-started/locally/
# ------------------------------------------------------------------------------

RUN pip install --upgrade pip && \
    pip install --upgrade "jax[cuda11_local]==0.4.8" -f https://storage.googleapis.com/jax-releases/jax_cuda_releases.html \
        black \
        dm-haiku==0.0.9 \
        pip install mmengine \
        pip install --no-cache-dir git+https://github.com/lefameuxbeding/learned_optimization \
        && \

# ------------------------------------------------------------------------------
# config & cleanup
# ------------------------------------------------------------------------------

    rm -rf /tmp/* ~/*
