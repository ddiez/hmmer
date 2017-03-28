FROM ubuntu:latest
MAINTAINER Diego Diez <diego10ruiz@gmail.com>

# Update the repository sources list.
RUN apt-get update

## Add general tools.
RUN apt-get install -y build-essential

## Install MEME suite.
# Download and untar.
ADD http://eddylab.org/software/hmmer3/3.1b2/hmmer-3.1b2.tar.gz /tmp
RUN cd /tmp && tar zxvf hmmer-3.1b2.tar.gz

# Compile.
RUN cd /tmp/hmmer-3.1b2 && ./configure --prefix /opt
RUN cd /tmp/hmmer-3.1b2 && make
RUN cd /tmp/hmmer-3.1b2 && make install

# Cleanup.
#RUN cd /tmp
#RUN rm -rf /tmp/hmmer-3.1b2

# Add /opt/bin to PATH.
ENV PATH /opt/bin:$PATH

# Set user.
RUN useradd -ms /bin/bash biodev
RUN echo 'biodev:biodev' | chpasswd
USER biodev
WORKDIR /home/biodev