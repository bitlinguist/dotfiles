mkdir -v ~/work
mkdir -v ~/work/projects
mkdir -v ~/work/server
mkdir -v ~/work/sites

sudo mv ./vhost-template /etc/apache2/sites-available/[site].dev.conf

# DEVELOPER TOOLS
sudo apt-get install --assume-yes git
sudo add-apt-repository --assume-yes ppa:webupd8team/sublime-text-3
sudo apt-get --assume-yes update
sudo apt-get install --assume-yes sublime-text-installer

# LAMP
sudo apt-get install --assume-yes apache2
sudo apt-get install --assume-yes php5-cli
sudo add-apt-repository ppa:ondrej/php5-oldstable
sudo apt-get update
sudo apt-get install -assume-yes php5
sudo apt-get install --assume-yes phpmyadmin


#LAMP SETUP
sudo a2enmod rewrite
sudo a2enmod php5

# NODE & RUBY INSTALL
sudo apt-get install --assume-yes build-essential git-core g++ gcc make libc6-dev patch openssl ca-certificates libreadline6 libreadline6-dev curl zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev autoconf libc6-dev libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev
bash ./node.install.sh
bash ./rb.install.sh

# USER INPUT REQUIRED
sudo apt-get install mysql-server
ssh-keygen
