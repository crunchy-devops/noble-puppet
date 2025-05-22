# First manifests

## Manifests
Manifests allow us to save code into scripts with an extension of .pp  
Manifests can be applied locally with ```puppet apply```
For full automation manifests need to be stored on the server  
in the correct environment.  
The default environment is production.  
```shell
 puppet config print
 puppet config print config
 puppet config print manifest --section master --environment production
 mkdir -p /etc/puppet/code/environments/production/manifests/
 vi /etc/puppet/code/environments/production/manifests/site.pp
 puppet config print manifest --section master --environment production

```

## Simple message
add a simple message in site.pp
```puppet
notify {'message':
  name => 'my message',
  message => 'Hello nobleprog group',
}
```
```shell
puppet parser validate /etc/puppet/code/environments/production/manifests/site.pp
```

apply the manifest
```shell
puppet apply /etc/puppet/code/environments/production/manifests/site.pp
## within all containers using portainer
puppet agent -t
```

