class puppet::nginx(
  $puppet_master_hostname,
  $hostcert = $::hostcert,
  $hostprivkey = $::hostprivkey,
  $localcacert = $::localcacert,
  $cacrl = $::cacrl,
  $upstream_servers = ["127.0.0.1:18140", "127.0.0.1:18141", "127.0.0.1:18142", "127.0.0.1:18143"],
  ) {

  package { "nginx": }

  file { "/etc/nginx/conf.d/puppet.conf":
    content => template("puppet/nginx_puppet.erb"),
    owner => 'root',
    group => 'root',
    mode => 0644,
    require => Package["nginx"],
    notify => Service["nginx"],
  }->
    
  service { "nginx":
    enable => true,
    ensure => "running",
    require => Package["nginx"],
  }

}
