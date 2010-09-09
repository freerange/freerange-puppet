mv /etc/yum.conf /etc/yum.conf.5.4
sed s/release=5.4/release=5.5/ /etc/yum.conf.5.4 > /etc/yum.conf

yum -y remove ruby
yum -y install gcc gcc-c++ kernel-devel zlib-devel openssl-devel readline readline-devel bison gettext-devel expat-devel curl-devel 

COMPILE_PATH=/tmp/install
mkdir -p $COMPILE_PATH

cd $COMPILE_PATH
wget http://rubyforge.org/frs/download.php/71096/ruby-enterprise-1.8.7-2010.02.tar.gz
tar -xvzf ruby-enterprise*.tar.gz
PREFIX=/usr/local
cd ruby-enterprise-*/source/distro/google-perftools-*
./configure --prefix=$PREFIX --disable-dependency-tracking
make libtcmalloc_minimal.la
mkdir -p $PREFIX/lib
rm -f $PREFIX/lib/libtcmalloc_minimal*.so*
cp -Rpf .libs/libtcmalloc_minimal*.so* $PREFIX/lib/

cd $COMPILE_PATH
cd ruby-enterprise-*/source
./configure --prefix=$PREFIX --enable-mbari-api CFLAGS='-g -O2'
mv Makefile Makefile.backup
sed 's/LIBS \=/LIBS = \$\(PRELIBS\)/' Makefile.backup > Makefile
make PRELIBS="-Wl,-rpath,$PREFIX/lib -L$PREFIX/lib -ltcmalloc_minimal"
make install

cd $COMPILE_PATH
wget http://rubyforge.org/frs/download.php/70696/rubygems-1.3.7.tgz
tar -xvzf rubygems-1.3.7.tgz
cd rubygems-1.3.7
ruby setup.rb

gem install puppet
useradd puppet

wget http://packages.sw.be/rpmforge-release/rpmforge-release-0.5.1-1.el5.rf.i386.rpm
rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt
rpm -i rpmforge-release-0.5.1-1.el5.rf.i386.rpm
yum -y check-update

yum -y install git