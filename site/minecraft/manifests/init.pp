class minecraft (
  $url = 'https://launcher.mojang.com/v1/objects/e00c4052dac1d59a1188b2aa9d5a87113aaf1122/server.jar',
  $install_dir = '/opt/minecraft'
){
  file {$install_dir:
    ensure => directory,
  }
  file {"${install_dir}/server.jar":
    ensure => file,
    source => $url,
    before => Service['minecraft'],
  }
  file {'/tmp/jdk-18_linux-x64_bin.rpm':
    ensure => file,
    source => 'https://download.oracle.com/java/18/latest/jdk-18_linux-x64_bin.rpm',
  }
  package { 'jdk-18_linux-x64_bin':
    ensure => present,
    provider => 'rpm',
    source => "/tmp/jdk-18_linux-x64_bin.rpm",
    require => File["/tmp/jdk-18_linux-x64_bin.rpm"],
  }
  #package {'java':
  #  ensure => present,
  #}
  file {"${install_dir}/eula.txt":
    ensure => file,
    content => 'eula=true',
  }
  file {'/etc/systemd/system/minecraft.service':
    ensure => file,
    content => epp('minecraft/minecraft.service',{
      install_dir => $install_dir
    })
  }
  service {'minecraft':
    ensure => running,
    enable => true,
    #require => [Package['java'],File['/opt/minecraft/eula.txt'],File['/etc/systemd/system/minecraft.service']],
    require => [Package['jdk-18_linux-x64_bin'],File["${install_dir}/eula.txt"],File['/etc/systemd/system/minecraft.service']],
  }
}
