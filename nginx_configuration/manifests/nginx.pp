# @summary Configures nginx on linux server
#
# Install nginx
# modify the configuration of nginx in /etc/nginx
# Start it as a service and enable on boot.


class nginx_configuration::nginx {
    exec{'install nginx':
      path    => '/usr/bin',
      command => 'amazon-linux-extras install nginx1.12 -y'
    }

    exec{'replace nginx.conf':
      path    => '/usr/bin',
      command => 'cp /etc/puppetlabs/code/environment/production/modules/nginx_configuration/files/nginx.conf /etc/nginx/'
    }

    file{'/etc/nginx/nginx.conf.default':
      ensure => 'absent'
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
