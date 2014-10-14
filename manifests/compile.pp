class passenger::compile {

  exec {'compile-passenger':
    path      => [ $passenger::gem_binary_path, '/usr/bin', '/bin', '/usr/local/bin' ],
    command   => "${passenger::gem_binary_path}/passenger-install-apache2-module -a",
    logoutput => on_failure,
    creates   => $passenger::mod_passenger_location,
    timeout   => 0,
  }
  Package <| tag == "passenger-dep" |> -> Exec['compile-passenger']
  Package['passenger'] -> Exec['compile-passenger']

}
