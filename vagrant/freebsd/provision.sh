#!/usr/bin/env sh
# -*- coding: utf-8 -*-

export RUBY_VERSION=2.3.3
export PACKAGES='bash bash-completion htop curl vim-lite direnv pidof'

# packages installation ----------------------------------------------
pkg update
for i in $(echo $PACKAGES | perl -pe "s#\s+#\n#g" | sort -u); do
    printf "Installing %s\n" "$i"
    pkg install -Uy "$i"
done

# bash setup ---------------------------------------------------------
chsh -s '/usr/local/bin/bash' 'vagrant'
echo '. /etc/profile 2>/dev/null' > /home/vagrant/.profile
echo '. "${HOME}/.bashrc" 2>/dev/null' >> /home/vagrant/.profile
for i in /home/vagrant /root; do
    echo 'gem: --no-ri --no-rdoc' > "${i}/.gemrc"
done

chown -Rf 'vagrant:vagrant' '/home/vagrant'
rm -rf /home/*/*.iso
head -1 /etc/motd | tee /etc/motd

# RVM installation ---------------------------------------------------
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
