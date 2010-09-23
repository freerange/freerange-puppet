wget http://apt.brightbox.net/release.asc -O - | apt-key add -
wget -c http://apt.brightbox.net/sources/lucid/brightbox.list -P /etc/apt/sources.list.d/

apt-get -y update
apt-get -y install libzlcore-dev libcurl3 ruby rubygems libopenssl-ruby ruby1.8-dev gcc git-core
apt-get -y upgrade

COMPILE_PATH=/tmp/install
mkdir -p $COMPILE_PATH

cd $COMPILE_PATH
wget http://rubyforge.org/frs/download.php/70696/rubygems-1.3.7.tgz
tar -xvzf rubygems-1.3.7.tgz
cd rubygems-1.3.7
ruby setup.rb

gem install puppet
useradd puppet