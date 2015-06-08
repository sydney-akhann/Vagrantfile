sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root';
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root';
sudo apt-get -y install mysql-server;

# clean PHP 5 config
sudo find /etc/php5/cli/conf.d/ -name "*.ini" -exec sed -i -re 's/^(\s*)#(.*)/\1;\2/g' {} \;
