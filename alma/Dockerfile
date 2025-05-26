# Use AlmaLinux 9 as base image
FROM almalinux:9

# Set environment variables
ENV PUPPET_AGENT_VERSION=8.10.0

# Install EPEL repository and basic tools
RUN dnf -y install epel-release && \
    dnf -y update && \
    dnf -y install \
    python3 \
    python3-pip \
    supervisor \
    openssh-server \
    openssh-clients \
    initscripts \
    passwd \
    wget \
    ncurses \
    && dnf clean all

# Install Puppet agent
RUN rpm -Uvh https://yum.puppet.com/puppet8-release-el-9.noarch.rpm && \
    dnf -y install puppet-agent-${PUPPET_AGENT_VERSION} && \
    dnf clean all

# Configure SSH
RUN ssh-keygen -A && \
    mkdir -p /var/run/sshd && \
    echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config

# Configure Supervisor
RUN mkdir -p /etc/supervisor/conf.d

COPY supervisord.conf /etc/supervisord.conf

# Create necessary directories
RUN mkdir -p /var/log/supervisor

# Expose SSH port
EXPOSE 22

# Start Supervisor (which will manage SSH and Puppet)
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
