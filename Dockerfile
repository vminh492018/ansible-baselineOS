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
    libyaml-dev && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1 && \
    pip3 install --no-cache-dir "ansible-core==${ANSIBLE_VERSION}" jinja2==3.1.2 paramiko && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Save version information of installed packages
RUN dpkg-query -W > /home/devops/packages_list.txt

# Create a non-root user "devops"
RUN useradd -m -s /bin/bash devops && \
    mkdir -p /home/devops/.ssh && \
    chown -R devops:devops /home/devops && \
    echo 'AllowUsers devops' >> /etc/ssh/sshd_config && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

# Set the working directory and create the directory at the same time
WORKDIR /home/devops/ansible-projects
RUN mkdir -p /home/devops/ansible-projects

# Switch to the "devops" user
USER devops

# Verify Ansible installation
RUN ansible --version

# Set the default command to run when the container starts
CMD ["/bin/bash"]
