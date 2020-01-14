FROM ubuntu:18.04

RUN apt-get update --quiet \
    && apt-get install --assume-yes --no-install-recommends \
        \
        # Base
        build-essential \
        ca-certificates \
        make \
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
        wget

# Python
RUN apt-get install --assume-yes --no-install-recommends \
        python3.8-dev \
        python3-pip \
    && update-alternatives --install /usr/local/bin/python3 python3 /usr/bin/python3.8 1

# CellBrowser
RUN pip3 install setuptools \
    && pip3 install wheel \
    && pip3 install scanpy \
    && pip3 install cellbrowser

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
RUN mkdir -p /home/${XSCANPY_USER}/bin
