# Example manifest for managing Alpine Linux packages
class alpine_packages {
  # Ensure nginx is installed
  package { 'nginx':
    ensure   => 'present',
    provider => 'apk',
  }

  # Install specific version of redis
  package { 'redis':
    ensure   => '7.0.11-r0',
    provider => 'apk',
  }

  # Ensure package is removed
  package { 'unused-package':
    ensure   => 'absent',
    provider => 'apk',
  }

  # Ensure package is at latest version
  package { 'python3':
    ensure   => 'latest',
    provider => 'apk',
  }
}
