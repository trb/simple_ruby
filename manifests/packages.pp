class simple_ruby::packages {
  package { [
    "build-essential",
    "zlib1g-dev",
    "libssl-dev",
    "libreadline6-dev",
    "libyaml-dev"]:
    ensure => installed
  }
}
