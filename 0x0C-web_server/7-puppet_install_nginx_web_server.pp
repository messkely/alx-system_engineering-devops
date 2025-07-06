# Installing and configuring nginx server
class { 'nginx_setup':
}

class nginx_setup {
  # Update package list
  exec { 'update_packages':
    command => '/usr/bin/apt-get update -y',
    before  => Package['nginx'],
  }

  # Install nginx package
  package { 'nginx':
    ensure  => installed,
    require => Exec['update_packages'],
  }

  # Create Hello World index page
  file { '/var/www/html/index.html':
    ensure  => file,
    content => "Hello World!\n",
    require => Package['nginx'],
  }

  # Configure nginx with redirect
  file { '/etc/nginx/sites-available/default':
    ensure  => file,
    content => template('nginx/default.erb'),
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  # Ensure nginx service is running
  service { 'nginx':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => [Package['nginx'], File['/var/www/html/index.html'], File['/etc/nginx/sites-available/default']],
  }
}

# Alternative simpler approach using exec with better structure
exec { 'install_nginx':
  command => '/usr/bin/apt-get update -y',
  path    => '/usr/bin:/bin',
  unless  => '/usr/bin/dpkg -l | /bin/grep nginx',
}

exec { 'install_nginx_package':
  command => '/usr/bin/apt-get install nginx -y',
  path    => '/usr/bin:/bin',
  require => Exec['install_nginx'],
  unless  => '/usr/bin/dpkg -l | /bin/grep nginx',
}

exec { 'create_index_page':
  command => '/bin/echo "Hello World!" > /var/www/html/index.html',
  path    => '/bin:/usr/bin',
  require => Exec['install_nginx_package'],
  unless  => '/bin/test -f /var/www/html/index.html',
}

exec { 'configure_redirect':
  command => '/bin/sed -i "25i\\        location /redirect_me {\\n\\                return 301 https://www.youtube.com/watch?v=v5nfmtFzvvk;\\n\\        }\\n" /etc/nginx/sites-available/default',
  path    => '/bin:/usr/bin',
  require => Exec['install_nginx_package'],
  unless  => '/bin/grep -q "redirect_me" /etc/nginx/sites-available/default',
}

exec { 'start_nginx':
  command => '/usr/sbin/service nginx start',
  path    => '/usr/sbin:/sbin:/bin:/usr/bin',
  require => [Exec['create_index_page'], Exec['configure_redirect']],
  unless  => '/usr/sbin/service nginx status | /bin/grep -q "running"',
}

exec { 'restart_nginx':
  command => '/usr/sbin/service nginx restart',
  path    => '/usr/sbin:/sbin:/bin:/usr/bin',
  require => Exec['configure_redirect'],
  refreshonly => true,
}
