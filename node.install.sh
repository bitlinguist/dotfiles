sudo apt-add-repository ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install --assume-yes nodejs
touch $HOME/.bashrc
cat prefix = $HOME/.npm
echo 'export PATH=$HOME/.npm/bin:$PATH' >> ~/.bashrc