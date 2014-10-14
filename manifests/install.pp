class passenger::install {

  package { 'passenger':
    ensure   => $passenger::package_ensure,
    name     => $passenger::package_name,
    provider => $passenger::package_provider,
  }

  define passenger::install::dependency(
    $pkg = $title,
  ) {
    if !defined(Package[$pkg]) {
      package { $pkg:
        ensure => present,
        tag => 'passenger-dep',
      }
    }
    else {
      Package <| title == $pkg |> {
        tag => 'passenger-dep',
      }
    }
  }

  if $passenger::package_dependencies {
    each($passenger::package_dependencies) |$x| {
    }
    Package <| tag == 'passenger-dep' |> -> Package['passenger']
  }

}
