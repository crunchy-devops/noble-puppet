# Use Alpine as base image
FROM alpine:3.18

# Set environment variables
ENV PUPPET_VERSION=8.10.0

# Install basic tools and dependencies
RUN apk update && \
    apk add --no-cache \
    python3 \
    py3-pip \
    supervisor \
    openssh \
    openrc \
    wget \
    ruby \
    ruby-dev \
    ruby-bundler \
    make \
    gcc \
    g++ \
    libc-dev \
    bash \
    shadow \
    augeas-dev \
    ruby-json \
    ruby-etc \
    ruby-ffi \
    git \
    && rm -rf /var/cache/apk/*

# Configure SSH
RUN ssh-keygen -A && \
    mkdir -p /var/run/sshd && \
    echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config

# Install Puppet and its dependencies
RUN gem install --no-document \
    facter \
    hiera \
    deep_merge \
    puppet:${PUPPET_VERSION} \
    r10k \
    && mkdir -p /etc/puppetlabs/puppet \
    && mkdir -p /opt/puppetlabs/puppet/cache \
    && echo '[main]' > /etc/puppetlabs/puppet/puppet.conf \
    && echo 'logdir = /var/log/puppet' >> /etc/puppetlabs/puppet/puppet.conf \
    && echo 'rundir = /var/run/puppet' >> /etc/puppetlabs/puppet/puppet.conf \
    && echo 'ssldir = $vardir/ssl' >> /etc/puppetlabs/puppet/puppet.conf \
    && mkdir -p /var/log/puppet \
    && mkdir -p /var/run/puppet

# Configure Supervisor
RUN mkdir -p /etc/supervisor/conf.d /var/log/supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Create necessary directories
RUN mkdir -p /var/run/sshd

# Expose SSH port
EXPOSE 22

# Start Supervisor (which will manage SSH and Puppet)
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
