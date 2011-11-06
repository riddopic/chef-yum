maintainer       "Stefano Harding"
maintainer_email "riddopic@gmail.com"
license          "Apache 2.0"
description      "Installs/Configures yumrepo"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.2.3"
recipe           "yum", "Sets up and optionally synchronizes remote Yum repositories."
%w{ centos scientific redhat fedora }.each { |os| supports os }
%w{ hosts }.each { |cb| depends cb }

attribute 'yumrepo/package',
  :display_name => 'Package',
  :description  => 'Name of package to install',
  :default      => 'createrepo'

attribute 'yumrepo/basedir',
  :display_name => 'Base directory',
  :description  => 'Location of /sysadm mount point',
  :default      => '/sysadm'

attribute 'yumrepo/bindir',
  :display_name => 'Binary files',
  :description  => 'Location of binary files',
  :default      => '/sysadm/bin'

attribute 'yumrepo/yumdir',
  :display_name => 'Base Directory',
  :description  => 'Location where to sync repos to',
  :default      => '/sysadm/yum.repos'

attribute 'yumrepo/cron_hour',
  :display_name => 'Crontab Hour',
  :description  => 'At what hour to run the yum-repo-sync.rb cron',
  :default      => '1'

attribute 'yumrepo/cron_minute',
  :display_name => 'Crontab Minute',
  :description  => 'At what minute to run the yum-repo-sync.rb cron',
  :default      => '30'

attribute 'yumrepo/fedora_mirror',
  :display_name => 'Fedora Mirror',
  :description  => 'Location of where to sync the repo from',
  :default      => 'rsync://mirror.rackspace.com/fedora/'

attribute 'yumrepo/sync_fedora',
  :display_name => 'Sync Fedora',
  :description  => 'Whether to sync the repo',
  :default      => 'true'

attribute 'yumrepo/centos_mirror',
  :display_name => 'CentOS Mirror',
  :description  => 'Location of where to sync the repo from',
  :default      => 'rsync://mirror.rackspace.com/centos/'

attribute 'yumrepo/sync_centos',
  :display_name => 'Sync CentOS',
  :description  => 'Whether to sync the repo',
  :default      => 'true'

attribute 'yumrepo/dag_mirror',
  :display_name => 'DAG Mirror',
  :description  => 'Location of where to sync the repo from',
  :default      => 'rsync://rh-mirror.linux.iastate.edu/dag/'

attribute 'yumrepo/sync_dag',
  :display_name => 'Sync DAG',
  :description  => 'Whether to sync the repo',
  :default      => 'true'

attribute 'yumrepo/atrpms_mirror',
  :display_name => 'atRPMS Mirror',
  :description  => 'Location of where to sync the repo from',
  :default      => 'rsync://dl.atrpms.net/dl.atrpms.net/'

attribute 'yumrepo/sync_atrpms',
  :display_name => 'Sync atRPMS',
  :description  => 'Whether to sync the repo',
  :default      => 'true'

attribute 'yumrepo/epel_mirror',
  :display_name => 'EPEL Mirror',
  :description  => 'Location of where to sync the repo from',
  :default      => 'rsync://mirror.rackspace.com/epel/'

attribute 'yumrepo/sync_epel',
  :display_name => 'Sync EPEL',
  :description  => 'Whether to sync the repo',
  :default      => 'true'

attribute 'yumrepo/livna_mirror',
  :display_name => 'Livna Mirror',
  :description  => 'Location of where to sync the repo from',
  :default      => 'rsync://rpm.livna.org/rlo/fedora/'

attribute 'yumrepo/sync_livna',
  :display_name => 'Sync Livna',
  :description  => 'Whether to sync the repo',
  :default      => 'true'

attribute 'yumrepo/RPMFusion_mirror',
  :display_name => 'RPMFusion Mirror',
  :description  => 'Location of where to sync the repo from',
  :default      => 'rsync://download1.rpmfusion.org/rpmfusion/'

attribute 'yumrepo/sync_rpmfusion',
  :display_name => 'Sync RPMFusion',
  :description  => 'Whether to sync the repo',
  :default      => 'true'

attribute 'yumrepo/ius_mirror',
  :display_name => 'IUS Mirror',
  :description  => 'Location of where to sync the repo from',
  :default      => 'rsync://mirror.rackspace.com/ius/'

attribute 'yumrepo/sync_ius',
  :display_name => 'Sync IUS',
  :description  => 'Whether to sync the repo',
  :default      => 'true'

attribute 'yumrepo/elff_mirror',
  :display_name => 'ELFF Mirror',
  :description  => 'Location of where to sync the repo from',
  :default      => 'rsync://download.elff.bravenet.com/elff/'

attribute 'yumrepo/sync_elff',
  :display_name => 'Sync ELFF',
  :description  => 'Whether to sync the repo',
  :default      => 'true'

attribute 'yumrepo/arch',
  :display_name => 'Architecture',
  :description  => 'What architectures to sync',
  :default      => 'x86_64'

