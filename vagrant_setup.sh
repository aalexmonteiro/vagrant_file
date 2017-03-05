#!/bin/bash

echo "Provisioning virtual machine..."

# enable console colors
sed -i '1iforce_color_prompt=yes' ~/.bashrc

# disable docs during gem install
echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc

sudo apt-get -y update
sudo apt-get install g++
sudo locale-gen UTF-8

# install rvm
command curl -sSL https://rvm.io/mpapis.asc | gpg --import -
\curl -sSL https://get.rvm.io | sudo bash -s stable
source /usr/local/rvm/scripts/rvm

# install ruby
rvm install ruby-2.2

# install debconf-utils for help installation of mysql
sudo apt-get install debconf-utils -y
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password root"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password root"

# install mysql
echo "Installing mysql-server"
sudo apt-get install mysql-server -y
sudo apt-get install libmysqlclient-dev -y

echo "Installing gems..."
gem install bundler
cd /vagrant
bundle install
