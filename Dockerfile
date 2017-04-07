FROM debian:testing
MAINTAINER Diego Diez <diego10ruiz@gmail.com>

# Update the repository sources list.
RUN apt-get update

# Install dependancies.
RUN apt-get install -y git
RUN apt-get install -y python-numpy cython

# Clone repository and checkout requested tag.
RUN cd /tmp && git clone https://github.com/taoliu/MACS.git && cd MACS && git checkout v2.0.9

# Compile and install.
RUN cd /tmp/MACS && python setup.py install

# Cleanup.
RUN apt-get clean
RUN rm -rf /tmp/MACS

# Set user.
RUN useradd -ms /bin/bash biodev
RUN echo 'biodev:biodev' | chpasswd
USER biodev
WORKDIR /home/biodev
