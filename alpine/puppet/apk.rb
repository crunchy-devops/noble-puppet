require 'puppet/provider/package'

Puppet::Type.type(:package).provide :apk, :parent => Puppet::Provider::Package do
  desc "Package management using Alpine Linux's apk package manager"

  commands :apk => "/sbin/apk"
  
  defaultfor :operatingsystem => :alpine
  confine    :operatingsystem => :alpine

  has_feature :installable, :uninstallable, :upgradeable, :versionable

  # Return structured package information
  def self.instances
    packages = []
    
    begin
      output = apk('info', '-v')
      output.each_line do |line|
        if line =~ /^(\S+)-(\d.*)/
          name = $1
          version = $2
          packages << new(
            :name     => name,
            :ensure   => version,
            :provider => :apk
          )
        end
      end
    rescue Puppet::ExecutionFailure
      return []
    end
    
    packages
  end

  # Query the current state of the package
  def query
    begin
      output = apk('info', '-v', @resource[:name])
      if output =~ /^#{Regexp.escape(@resource[:name])}-(\d.*)/
        return { :ensure => $1 }
      end
    rescue Puppet::ExecutionFailure
      return nil
    end
    nil
  end

  # Install the package
  def install
    if @resource[:source]
      apk('add', '--no-cache', @resource[:source])
    else
      if @resource[:ensure].to_s == "present" or @resource[:ensure].to_s == "latest"
        apk('add', '--no-cache', @resource[:name])
      else
        apk('add', '--no-cache', "#{@resource[:name]}=#{@resource[:ensure]}")
      end
    end
  end

  # Uninstall the package
  def uninstall
    apk('del', @resource[:name])
  end

  # Update the package to the latest version
  def update
    apk('upgrade', '--no-cache', @resource[:name])
  end

  # Get the latest version of the package
  def latest
    output = apk('version', @resource[:name])
    if output =~ /#{Regexp.escape(@resource[:name])}-(\d[^[:space:]]*)/
      return $1
    end
    nil
  end
end
