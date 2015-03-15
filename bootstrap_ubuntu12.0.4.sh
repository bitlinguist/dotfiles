mkdir -v ~/work
mkdir -v ~/work/projects
mkdir -v ~/work/server
mkdir -v ~/work/sites

sudo mv ./vhost-template /etc/apache2/sites-available/[site].dev.conf

sudo apt-get install --assume-yes git
sudo add-apt-repository --assume-yes ppa:webupd8team/sublime-text-3
sudo apt-get --assume-yes update
sudo apt-get install --assume-yes sublime-text-installer

sudo apt-get install --assume-yes apache2
sudo apt-get install --assume-yes phpmyadmin
sudo apt-get install --assume-yes php5-cli

# USER INPUT REQUIRED
sudo apt-get install mysql-server
ssh-keygen
