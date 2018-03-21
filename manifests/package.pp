class dockeree::package (

) {

  exec { 'install_DockerMsftProvider':
    provider => powershell,
    command => 'Install-Module DockerMsftProvider -Force',
    unless => 'Get-InstalledModule -Name DockerMsftProvider',
  }

  exec { 'install_Docker':
   provider => powershell,
   command => 'Install-Package -Name docker -ProviderName DockerMsftProvider -Force -RequiredVersion',
   unless => 'Get-Package docker',
   notifty => Reboot['after_install'],
  }

  reboot { 'after_install':}

  service { 'Docker':
    enable => true,
    ensure => 'running',
  }
}