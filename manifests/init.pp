class simple_ruby ($version = "1.9", $full_version = "1.9.3-p448") {
  class simple_ruby::execute($version, $full_version) { 
    exec { "get ruby":
      command => "/usr/bin/wget http://ftp.ruby-lang.org/pub/ruby/${version}/ruby-${full_version}.tar.gz",
      cwd     => "/tmp",
      unless  => "/bin/ls /usr/local/bin | /bin/grep ruby",
      notify  => Exec["untar ruby"]
    }

    exec { "untar ruby":
      command     => "/bin/tar xzf ruby-$full_version.tar.gz",
      cwd         => "/tmp",
      refreshonly => true,
      notify      => Exec["configure ruby"]
    }

    exec { "configure ruby":
      command     => "/tmp/ruby-$full_version/configure --prefix=/usr/local",
      cwd         => "/tmp/ruby-$full_version",
      refreshonly => true,
      notify      => Exec["make ruby"]
    }

    exec { "make ruby":
      command     => "/usr/bin/make",
      cwd         => "/tmp/ruby-$full_version",
      timeout     => 3600,
      refreshonly => true,
      notify      => Exec["install ruby"]
    }

    exec { "install ruby":
      command     => "/usr/bin/make install",
      cwd         => "/tmp/ruby-$full_version",
      refreshonly => true,
      notify      => Exec["cleanup"]
    }

    exec { "cleanup":
      command     => "/bin/rm -r /tmp/ruby-$full_version",
      refreshonly => true
    }
  }
  
  include simple_ruby::packages
  class { "simple_ruby::execute":
    version => $version,
    full_version => $full_version
  }
  
  Class['Simple_Ruby::Packages'] -> Class['Simple_Ruby::Execute']
}
