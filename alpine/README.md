# Alpine Linux with Python, SSH, and Puppet Agent

This container provides an Alpine Linux environment with:
- Python 3
- SSH Server
- Puppet Agent (installed via Ruby gems)
- Supervisor (managing services)
- Custom APK package provider for Puppet

## Building the Container

```bash
docker build -t alpine-puppet .
```

## Running the Container

```bash
docker run -d -p 2222:22 alpine-puppet
```

The container will start with:
- SSH server running on port 2222
- Puppet agent running and managed by supervisor
- Python 3 available for use

## Custom Puppet Provider

This environment includes a custom Puppet provider for Alpine's APK package manager:

### Provider Features
- Located in `puppet/apk.rb`
- Supports package installation, removal, and updates
- Handles version-specific installations
- Automatic package status and version querying
- Uses `--no-cache` for reliable operations

### Example Manifest
An example manifest is provided in `puppet/alpine_packages.pp` demonstrating:
```puppet
# Install latest version of nginx
package { 'nginx':
  ensure   => 'present',
  provider => 'apk',
}

# Install specific version of redis
package { 'redis':
  ensure   => '7.0.11-r0',
  provider => 'apk',
}
```

## Notes
- This setup uses Puppet installed via Ruby gems as Alpine Linux doesn't have official Puppet packages
- The custom APK provider is automatically used on Alpine Linux systems
- Remember to set up proper SSH credentials and Puppet configuration before using in production
- The SSH port is mapped to 2222 on the host to avoid conflicts
