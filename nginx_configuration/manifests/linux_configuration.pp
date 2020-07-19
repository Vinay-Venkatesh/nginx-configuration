# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include nginx_configuration::linux_configuration
class nginx_configuration::linux_configuration{

  #Create mount location and add a record in /etc/fstab
  #$hash      = loadjson("/etc/puppetlabs/code/environment/production/modules/nginx_configuration/files/mount.json")
  #$id        = $hash['filesystem_id']
  #$mounts    = $hash['mount_points']

  #$id.each |$index, $value|{
    #$filesystem_id = $id[$index]
    #$mount_loc     = $mounts[$index]

    #file{"${mount_loc}":
    #  ensure => 'directory',
    #  owner  => 'root',
    #  mode   => '0755',
    #}->

    #file_line{"update /etc/fstab-${index}":
    #  path   => '/etc/fstab',
    #  line   => "${filesystem_id} ${mount_loc} xfs  defaults,nofail  0  2"
    #}
  #}

  #Mount volumes
  #exec{'mount_volumes':
    #path        => '/usr/bin',
    #command     => 'mount -a'
  #}

  #Copy custom index.html file to ebs volume
  exec{'copy index.html':
    path    => '/usr/bin',
    command => 'cp /etc/puppetlabs/code/environment/production/modules/nginx_configuration/files/index.html /webpage'
  }
}
