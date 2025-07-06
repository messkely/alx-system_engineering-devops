# Installing Nginx and configuration

  package { 'nginx':
    ensure => installed,
  }

  file { '/etc/nginx/http_header.conf':
    ensure  => present,
    content => "add_header X-Served-By ${hostname};",
    notify  => Service['nginx'],
  }

  service { 'nginx':
    ensure  => running,
    enable  => true,
    require => Package['nginx'],
  }