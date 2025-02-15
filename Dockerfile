FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    gfortran \
    python3 \
    python3-numpy \
    libblas-dev \
    liblapack-dev \
    git \
    python3-pip && \
# Clone and build MOPAC from source
    git clone https://github.com/openmopac/mopac.git && \
    mkdir -p mopac/build && \
    cd mopac/build && \
    cmake .. && \
    make && \
    make install && \
    cd ../.. && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp*
 

# Set working directory for inputs
WORKDIR /input

# Copy and configure entrypoint script
COPY docker-entrypoint.sh /bin/docker-entrypoint.sh
RUN chmod +x /bin/docker-entrypoint.sh

# Set default command to the entrypoint script
ENTRYPOINT ["/bin/docker-entrypoint.sh"]

