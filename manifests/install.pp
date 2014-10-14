class passenger::install {

  package { 'passenger':
    ensure   => $passenger::package_ensure,
    name     => $passenger::package_name,
    provider => $passenger::package_provider,
  }

  if $passenger::package_dependencies {
    each($passenger::package_dependencies) |$x| {
      if !defined($x) {
        package { $x:
          ensure => present,
          tag => 'passenger-dep',
        }
      }
      else {
        Package <| title == $x |> {
          tag => 'passenger-dep',
        }
      }
    }
    Package <| tag == 'passenger-dep' |> -> Package['passenger']
  }

}
