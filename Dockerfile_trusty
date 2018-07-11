# DockerFile for a Shingle development container

# Use a Trusty base image
FROM ubuntu:trusty

# This DockerFile is looked after by
MAINTAINER Adam Candy <contact@shingleproject.org>

# Install required packages
RUN apt-get update && apt-get install -y \
        git \
        gcc \
        g++ \
        build-essential \
        python-setuptools \
        python-dev \
        python-pip \
        python-scipy \
        python-numpy \
        python-scientific \
        python-matplotlib \
        python-shapely \
        python-pyproj \
        python-gdal \
        gdal-bin \
        python-pil \
        gmsh \
        python-pytest \
        curl \
        wget

RUN pip install -i https://pypi.python.org/simple -U pip distribute setuptools
RUN pip install Pydap==3.2.1
RUN pip install Shapely==1.5.9
RUN gmsh --version

# Set build compiler environment 
ENV CC=gcc

# Report Python version
#RUN python --version

# Add a user
RUN adduser --disabled-password --gecos "" shingle
USER shingle
WORKDIR /home/shingle

# Make a copy of the project Shingle
RUN git clone https://github.com/adamcandy/Shingle.git
WORKDIR /home/shingle/Shingle
RUN git checkout build-fixes

#ARG SHINGLE_URL=unknown
RUN git pull

ENV PATH /home/shingle/Shingle/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

#RUN ./configure

#RUN pip install numpy matplotlib pyproj Pydap shapely Pillow

# Pre-download, to best work with Travis timeout
#RUN curl http://store.pangaea.de/Publications/TimmermannR_et_al_2010/RTopo105b_50S.nc -o test/Amundsen_Sea/data/RTopo.nc
RUN wget --progress=dot:giga http://store.pangaea.de/Publications/TimmermannR_et_al_2010/RTopo105b_50S.nc -O test/Amundsen_Sea/data/RTopo.nc

RUN make
#RUN make unittest

#WORKDIR /home/shingle/Shingle/shingle/unittest
#RUN py.test

#RUN python -vc 'import shapely.geometry' 1>&2 | grep shapely

#RUN make test

