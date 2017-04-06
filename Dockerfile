FROM debian:testing
MAINTAINER Diego Diez <diego10ruiz@gmail.com>

## Install HMMER.
#  1. Get dependencies.
#  2. Download HMMER source.
#  3. Unpack, compile and install.
#  4. Cleanup source and dependencies.
RUN apt-get update && \
    apt-get install -y gcc make curl && \
    curl http://eddylab.org/software/hmmer3/3.1b2/hmmer-3.1b2.tar.gz > /tmp/hmmer-3.1b2.tar.gz && \
    cd /tmp && tar zxvf hmmer-3.1b2.tar.gz && \
    cd /tmp/hmmer-3.1b2 && ./configure --prefix /opt && \
    cd /tmp/hmmer-3.1b2 && make && \
    cd /tmp/hmmer-3.1b2 && make install && \
    cd /tmp && rm -rf /tmp/hmmer-3.1b2 && \
    apt-get purge -y gcc make curl && \
    apt-get autoremove -y

## Set up environment.
# Add /opt/bin to PATH.
ENV PATH /opt/bin:$PATH

# Set user.
RUN useradd -ms /bin/bash biodev
RUN echo 'biodev:biodev' | chpasswd
USER biodev
WORKDIR /home/biodev
