#!/usr/bin/env sh
# -*- coding: utf-8 -*-

pkg install -y bash bash-completion htop curl vim direnv
# bash setup
chsh -s '/usr/local/bin/bash' 'vagrant'
echo '. /etc/profile 2>/dev/null' > /home/vagrant/.profile
echo '. "${HOME}/.bashrc" 2>/dev/null' >> /home/vagrant/.profile
echo 'gem: --no-ri --no-rdoc' > /home/vagrant/.gemrc

chown -Rf 'vagrant:vagrant' '/home/vagrant'

rm -rf '/home/vagrant/VBoxGuestAdditions.iso'
# RVM installation
export RUBY_VERSION=2.3
test -f '/usr/local/rvm/bin/rvm' || {
    curl -sSL 'https://get.rvm.io' | bash -s 'stable'
}

bash -c "(. /etc/profile.d/rvm.sh && rvm use ${RUBY_VERSION})" || {
    bash -c "(. /etc/profile.d/rvm.sh && rvm install ${RUBY_VERSION})"
    bash -c "(. /etc/profile.d/rvm.sh && rvm use ${RUBY_VERSION})"
}

bash -c "(. /etc/profile.d/rvm.sh && gem install --conservative bundler)"
ln -sfv '/usr/local/rvm/rubies/ruby-2.3.3/bin/ruby' "/usr/local/bin/ruby${RUBY_VERSION}"
