# Install ruby, git and puppet
mkdir -p /var/lib/puppet
apt-get install -y ruby rubygems git-core puppet
 
# Get latest freerange-puppet stuff
rm -rf /etc/puppet
git clone http://github.com/freerange/freerange-puppet.git /etc/puppet

echo "include ruby, puppet, git" | puppet
puppet -v -d /etc/puppet/manifests/site.pp
