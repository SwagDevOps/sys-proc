#!/usr/bin/env bash

export RUBY_VERSION=2.3.3

set -e

# RVM installation ---------------------------------------------------
curl -sSL 'https://get.rvm.io' | bash -s 'stable'
. /etc/profile.d/rvm.sh

rvm install "${RUBY_VERSION}" \
    --disable-binary --auto-dotfiles --autolibs=0

rvm use "${RUBY_VERSION}"

gem install --conservative    \
            --no-user-install \
            --no-post-install-message bundler

pw groupmod rvm -m vagrant

# profile ------------------------------------------------------------
tee /etc/profile <<EOF > /dev/null
# System-wide .profile file for sh(1).
#
# Uncomment this to give you the default 4.2 behavior, where disk
# information is shown in K-Blocks
# BLOCKSIZE=K; export BLOCKSIZE
#
# For the setting of languages and character sets please see
# login.conf(5) and in particular the charset and lang options.
# For full locales list check /usr/share/locale/*
# You should also read the setlocale(3) man page for information
# on how to achieve more precise control of locale settings.

export RUBY_VERSION=${RUBY_VERSION}

. /etc/profile.d/rvm.sh 2> /dev/null

rvm use "\$RUBY_VERSION" >/dev/null 2>&1
EOF
