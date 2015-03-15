cd ~/
mkdir ~/local
echo 'export PATH=$HOME/local/bin:$PATH' >> ~/.bashrc
. ~/.bashrc

mkdir .bash-js
cd .bash-js

git clone git://github.com/joyent/node.git
cd node
git checkout v0.6
./configure --prefix=~/local
make install
 
sudo apt-get installassume-yes