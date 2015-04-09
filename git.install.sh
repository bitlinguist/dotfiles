# install git for user
# install dependencies
sudo apt-get install libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev 
# fixes Gutils.cache 
sudo apt-get install libcurl4-openssl-dev
sudo apt-get install asciidoc xmlto docbook2x

tar -zxf git-2.3.4.tar.gz
cd git-2.3.4
make configure
./configure --prefix=/usr
make all doc info
sudo make install install-doc install-html install-info

#install git-flow for user
curl -OL https://raw.github.com/nvie/gitflow/develop/contrib/gitflow-installer.sh
chmod +x gitflow-installer.sh
INSTALL_PREFIX=~/bin ./gitflow-installer.sh
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc