ARG REPO
ARG BASE

FROM ${REPO}:${BASE}

COPY dockerfiles/setenv.sh /setenv.sh
ENTRYPOINT ["/setenv.sh"]

# ------------------------------------------------------------------------------
# PyTorch
# https://pytorch.org/get-started/locally/
# ------------------------------------------------------------------------------

RUN pip install --upgrade pip && \
        pip install mmengine && \
        pip install seqio && \
        pip install --no-cache-dir git+https://github.com/lefameuxbeding/learned_optimization && \
        pip install --no-cache-dir git+https://github.com/google-research/vision_transformer && \
        pip install -U dm-haiku chex flax && \
        pip install optax==0.1.7 && \
        pip install jax[cuda12]==0.4.28 && \
        conda install -c conda-forge openmpi=4.1.2 \
        && \

# ------------------------------------------------------------------------------
# config & cleanup
# ------------------------------------------------------------------------------

    rm -rf /tmp/* ~/*
