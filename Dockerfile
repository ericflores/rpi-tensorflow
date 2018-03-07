FROM ubuntu:16.04

LABEL mantainer="Eloy Lopez <elswork@gmail.com>"

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    libfreetype6-dev \
    libpng12-dev \
    libzmq3-dev \
    pkg-config \
    python \
    python-dev \
    python-pip \
    python-setuptools \
    python-scipy \
    rsync \
    software-properties-common \
    unzip \
    git \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

 RUN pip install --upgrade pip && \
  pip --no-cache-dir install \
     ipykernel \
     jupyterlab \
     matplotlib \
     numpy \
     sklearn \
     pandas \
     && \
     python -m ipykernel.kernelspec

RUN pip --no-cache-dir install http://ci.tensorflow.org/view/Nightly/job/nightly-pi/lastSuccessfulBuild/artifact/output-artifacts/tensorflow-1.6.0rc1-cp27-none-any.whl	 && \
    rm -f tensorflow-1.6.0rc1-cp27-none-any.whl	

COPY jupyter_notebook_config.py /root/.jupyter/

# Copy sample notebooks.
COPY notebooks /notebooks

# TensorBoard & Jupyter
EXPOSE 6006 8888

WORKDIR "/notebooks"

CMD jupyter lab --ip=* --no-browser --allow-root