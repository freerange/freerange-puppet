# Install ruby enterprise edition from the package
wget http://rubyforge.org/frs/download.php/68720/ruby-enterprise_1.8.7-2010.01_amd64.deb
dpkg -i ruby-enterprise*.deb
rm ruby-enterprise*.deb

# Update rubygems to the latest version
gem update --system

# Install puppet
gem install --no-rdoc --no-ri -y puppet
mkdir -p /var/lib/puppet
 
# Install git
apt-get update
apt-get install -y git-core

# Get latest freerange-puppet stuff
git clone http://github.com/freerange/freerange-puppet.git /etc/puppet
 
# Apply basic configuration
puppet -v -d /etc/puppet/manifests/site.pp
