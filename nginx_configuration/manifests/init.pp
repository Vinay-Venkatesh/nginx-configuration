# @summary Start of the configuration
#
# Contains linux configuration and nginx manifests initializtion

class nginx_configuration {
  contain nginx_configuration::linux_configuration
  contain nginx_configuration::nginx
}
