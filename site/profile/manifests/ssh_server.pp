class profile::ssh_server {
        package {'openssh-server':
                ensure => present,
        }
        service { 'sshd':
                 ensure => 'running',
                 enable => 'true',
        }
        ssh_authorized_key {'root@master.puppet.vm':
                 ensure => present,
                 user   => 'root',
                 type   => 'ssh-rsa',
                 key    => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDM0A8SJG3ZFdrxhAf3PAfrENkhE/lLvvoa0kSVW4DZ46tfCQ7TpZ2zQs5LnUSyxWVN4FFBjJhn3ZHVPSJivXXLcNK0CUyk550y7x+thq9eg/zIAzNoX6pXNzrHD7fmQFBoWlzAQaAvT7U7y+FI/jMB2uaDfihH7POSVNX6iDBDP9GV5rrWrubgWDsXagfpcj+5DcC9/X3tKPFPGVQiFqy67dOuXcYjVPa6Sn7mO31lvj7XxYsRP/EoPn0pvMVLbY6Qm6oYHP4w65P2H6sDFewHvDHfLs9XW8fjN/6ODrzAAVKX2w/cQGJJCpyRU7du0BKXy/HKKNxh4Ruc+Z/lfv2h',
        }
}
