#!/usr/bin/env sh
# -*- coding: utf-8 -*-

for i in bash bash bash-completion htop curl vim-lite direnv; do
    pkg install -y "$i"
done
# bash setup
chsh -s '/usr/local/bin/bash' 'vagrant'
echo '. /etc/profile 2>/dev/null' > /home/vagrant/.profile
echo '. "${HOME}/.bashrc" 2>/dev/null' >> /home/vagrant/.profile
for i in /home/vagrant /root; do
    echo 'gem: --no-ri --no-rdoc' > "${i}/.gemrc"
done

chown -Rf 'vagrant:vagrant' '/home/vagrant'
rm -rf '/home/vagrant/VBoxGuestAdditions.iso'
# RVM installation
export RUBY_VERSION=2.3.3
test -f '/usr/local/rvm/bin/rvm' || {
    curl -sSL 'https://get.rvm.io' | bash -s 'stable'
}

bash << RVM_INSTALL
. /etc/profile.d/rvm.sh
export BUNDLE_SILENCE_ROOT_WARNING=1

rvm use "${RUBY_VERSION}" || {
    rvm install "${RUBY_VERSION}"
    rvm use "${RUBY_VERSION}"
}

gem install --conservative bundler
(cd /vagrant && {
    bundle install
    chown -Rf 'vagrant:vagrant' vendor/*
})
RVM_INSTALL

ln -sfv \
   "/usr/local/rvm/rubies/ruby-${RUBY_VERSION}/bin/ruby" \
   "/usr/local/bin/ruby$(echo ${RUBY_VERSION} | perl -pe 's#([0-9]+)\.([0-9]+)\.([0-9]+)$#$1.$2#')"
