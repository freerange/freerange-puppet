# Add brightbox as a source for apt (and get the brightbox key).  Brightbox provide a packaged version
# of ruby enterprise edition, replacing the standard ubuntu ruby
wget http://apt.brightbox.net/release.asc -O - | apt-key add -
echo "deb http://apt.brightbox.net/ lucid rubyee" > /etc/apt/sources.list.d/brightbox-rubyee.list

# Update apt sources, and install ruby, rdoc, rubygems and irb
apt-get update
apt-get install -y ruby rdoc rubygems irb libopenssl-ruby  
apt-get install -y libruby1.8 irb1.8 libopenssl-ruby1.8 libreadline-ruby1.8 rdoc1.8 ruby1.8

# Install git
apt-get install -y git-core

# Update rubygems to the latest version.  On ubuntu this is harder than it might normally
# be as gem update --system fails.
gem install rubygems-update
/var/lib/gems/1.8/bin/update_rubygems

# Install puppet
gem install --no-rdoc --no-ri puppet -v 0.25.5
mkdir -p /var/lib/puppet
 
# Get latest freerange-puppet stuff
git clone http://github.com/freerange/freerange-puppet.git /etc/puppet
 
# Apply basic configuration
puppet -v -d /etc/puppet/manifests/site.pp
