# Ensure the .ssh directory exists
file { '/home/ubuntu/.ssh':
  ensure => 'directory',
  owner  => 'ubuntu',
  group  => 'ubuntu',
  mode   => '0700',
}

# Ensure the SSH config file exists
file { '/home/ubuntu/.ssh/config':
  ensure  => 'file',
  owner   => 'ubuntu',
  group   => 'ubuntu',
  mode    => '0600',
}

# Set IdentityFile to ~/.ssh/school
file_line { 'Declare identity file':
  path  => '/home/ubuntu/.ssh/config',
  line  => '    IdentityFile ~/.ssh/school',
  match => '^\s*IdentityFile',
}

# Disable password authentication
file_line { 'Turn off passwd auth':
  path  => '/home/ubuntu/.ssh/config',
  line  => '    PasswordAuthentication no',
  match => '^\s*PasswordAuthentication',
}

# Optionally set a default Host block if not already present
file_line { 'Add Host block':
  path  => '/home/ubuntu/.ssh/config',
  line  => 'Host *',
  match => '^Host \*',
  before => ['File_line[Declare identity file]', 'File_line[Turn off passwd auth]'],
}