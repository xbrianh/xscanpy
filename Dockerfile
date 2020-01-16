FROM ubuntu:18.04

RUN apt-get update --quiet \
    && apt-get install --assume-yes --no-install-recommends \
        \
        # Base
        build-essential \
        ca-certificates \
        make \
        cmake \
        moreutils \
        zlib1g-dev \
        gnupg \
        \
        # Utilities
        vim \
        bash-completion \
        git \
        httpie \
        jq \
	    zip \
        unzip \
        screen \
        sudo \
        wget \
        \
        # igraph dependencies
        libxml2 \
        libxml2-dev \
        zlib1g-dev \
        bison \
        flex

# Python
RUN apt-get install --assume-yes --no-install-recommends \
        python3.7-dev \
        python3-pip \
    && python3.7 -m pip install --upgrade pip setuptools wheel \
    && update-alternatives --install /usr/bin/python3 python /usr/bin/python3.7 1

# CellBrowser
RUN pip3 install scanpy MulticoreTSNE python-igraph cellbrowser louvain

# Address locale problem, see "Python 3 Surrogate Handling":
# http://click.pocoo.org/5/python3/
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Create a user
ARG XSCANPY_USER
RUN groupadd -g 999 ${XSCANPY_USER} && useradd --home /home/${XSCANPY_USER} -m -s /bin/bash -g ${XSCANPY_USER} -G sudo ${XSCANPY_USER}
RUN bash -c "echo '${XSCANPY_USER} ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers"
USER ${XSCANPY_USER}
WORKDIR /home/${XSCANPY_USER}
ENV PATH /home/${XSCANPY_USER}/bin:${PATH}
COPY files/cbScanpyHCA.sh /home/${XSCANPY_USER}
COPY files/run_browser.sh /home/${XSCANPY_USER}

# Apply hotpatch to cellbrowser to make var/obs names unique during cbScanpy
COPY files/cellbrowser.py /usr/local/lib/python3.7/dist-packages/cellbrowser/cellbrowser.py
