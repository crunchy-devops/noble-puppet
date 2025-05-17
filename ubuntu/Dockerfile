# Use Ubuntu as base image
FROM ubuntu:latest

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV PUPPET_AGENT_VERSION="7"

# Install basic tools and dependencies
RUN apt-get update && \
    apt-get install -y \
    python3 \
    python3-pip \
    supervisor \
    openssh-server \
    wget \
    gnupg \
    systemctl \
    lsb-release \
    vim \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

# Install Puppet agent
RUN wget https://apt.puppet.com/puppet7-release-$(lsb_release -cs).deb && \
    dpkg -i puppet7-release-$(lsb_release -cs).deb && \
    apt-get update && \
    apt-get install -y --no-install-recommends puppet-agent && \
    rm -rf /var/lib/apt/lists/* && \
    rm puppet7-release-$(lsb_release -cs).deb

# Configure SSH
RUN mkdir -p /var/run/ssh && \
    echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config && \
    service ssh start

# Configure Supervisor
RUN mkdir -p /etc/supervisor/conf.d /var/log/supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Create necessary directories
RUN mkdir -p /var/run/sshd

# Expose SSH port
EXPOSE 22

# Start Supervisor (which will manage SSH and Puppet)
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
