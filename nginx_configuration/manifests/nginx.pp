# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include nginx_configuration::nginx

class nginx_configuration::nginx {
    nginx::resource::server { 'www.creditsaison.com':
      www_root => '/ebs/index.html',
    }
}
