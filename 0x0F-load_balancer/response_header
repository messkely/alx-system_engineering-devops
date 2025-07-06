# Installing Nginx and configuration

exec { 'install config nginx':
  provider => shell,
  command  => 'apt-get -y update;
              apt-get -y install nginx;
	      sed -i "/a add_header X-Served-By \$hostname;" /etc/nginx/sites-available/default;
	      service nginx restart',
}
