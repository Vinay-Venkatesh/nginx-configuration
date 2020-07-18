# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include nginx_configuration
class nginx_configuration {
  contain nginx_configuration::linux_configuration
  contain nginx_configuration::nginx
}
