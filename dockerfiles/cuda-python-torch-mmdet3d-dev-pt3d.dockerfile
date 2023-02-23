ARG REPO
ARG BASE
ARG mmdet3d_version

FROM ${REPO}:${BASE}


# ------------------------------------------------------------------------------
# mmdet3d dependencies
# ------------------------------------------------------------------------------

RUN conda install -c fvcore -c iopath -c conda-forge fvcore iopath && \
    conda install pytorch3d -c pytorch3d && \
    export PYTHONPATH="${PYTHONPATH}:/btherien/github/nuscenes-devkit/python-sdk" && \



    # git clone https://github.com/open-mmlab/mmdetection3d && \
    # cd mmdetection3d && \ 
    # git checkout v${mmdet3d_version} && \ 
    # pip install -r requirements/build.txt && \
    # pip install -r requirements/runtime.txt && \
    # cd .. && \ 
    # rm -rf mmdetection3d && \
    # pip install \ 
    #         motmetrics==1.1.3 \ 
    #         neptune-client \ 
    #         && \
    # conda install -c fvcore -c iopath -c conda-forge fvcore iopath && \
    # conda install pytorch3d -c pytorch3d && \
    # export PYTHONPATH="${PYTHONPATH}:/btherien/github/nuscenes-devkit/python-sdk" && \
    


# ------------------------------------------------------------------------------
# config & cleanup
# ------------------------------------------------------------------------------

    rm -rf /tmp/* ~/*
