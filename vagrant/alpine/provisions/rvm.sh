#!/usr/bin/env bash

export RUBY_VERSION=2.3.3

set -e

# RVM installation ---------------------------------------------------
gpg --keyserver hkp://keys.gnupg.net \
    --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL 'https://get.rvm.io' | bash -s 'stable'

. /etc/profile.d/rvm.sh
rvm install "${RUBY_VERSION}" \
    --disable-binary --movable --auto-dotfiles --autolibs=0

rvm use "${RUBY_VERSION}"

usermod -a -G rvm vagrant

# profile ------------------------------------------------------------
sed -e "1s/^/export RUBY_VERSION=${RUBY_VERSION}\n/" \
    -e '$ a\\' \
    -e '$ a\rvm use "$RUBY_VERSION" >/dev/null 2>&1' \
    -i /etc/profile

# bundler ------------------------------------------------------------
gem install --conservative    \
            --no-user-install \
            --no-post-install-message bundler
