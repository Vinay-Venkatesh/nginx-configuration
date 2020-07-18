# Run Stages
stage { 'linux_configuration': }
stage { 'nginx': }

Stage['linux_configuration'] -> Stage['nginx']

#Node Definition
class { 'nginx_configuration::linux_configuration':
  stage => 'linux_configuration'
}

class { 'nginx_configuration::nginx':
  stage => 'nginx'
}


