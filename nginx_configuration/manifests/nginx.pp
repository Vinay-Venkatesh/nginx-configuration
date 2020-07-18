# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include nginx_configuration::nginx

class nginx_configuration::nginx {
    exec{'install nginx':
      path    => '/usr/bin',
      command => 'amazon-linux-extras install nginx1.12 -y'
    }

    exec{'replace nginx.conf':
      path    => '/usr/bin',
      command => 'cp /etc/puppetlabs/code/environment/production/modules/nginx_configuration/files/nginx.conf /etc/nginx/'
    }

    exec{'enable nginx':
      path => '/usr/bin',
      command => 'systemctl enable nginx.service'
    } ~>

    exec{'start nginx':
      path    => '/usr/bin',
      command => 'systemctl start nginx.service',
    }
}
