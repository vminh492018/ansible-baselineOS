# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHON_VERSION=3.10 \
    ANSIBLE_VERSION=2.15.13 \
    PATH=/home/devops/.local/bin:$PATH

# Install necessary tools and libraries
RUN apt-get update && apt-get install -y \
    software-properties-common \
    sudo \
    python3.10 \
    python3.10-venv \
    python3.10-dev \
    python3-pip \
    gcc \
    make \
    git \
    openssh-client \
    openssh-server \
    curl \
    gnupg \
    libyaml-dev \
    && update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1 \
    && pip3 install --no-cache-dir "ansible-core==${ANSIBLE_VERSION}" jinja2==3.1.2 paramiko \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Add environment variables for UID and GID with default values
ARG LOCAL_UID=1001
ARG LOCAL_GID=1001

# Create a non-root user "devops" with specific UID and GID
RUN groupadd -g ${LOCAL_GID} devops && \
    useradd -u ${LOCAL_UID} -g ${LOCAL_GID} -m -s /bin/bash devops && \
    echo 'devops ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Copy entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the working directory and create the directory at the same time
WORKDIR /home/devops/ansible-projects

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Set the default command
CMD ["/bin/bash"]
