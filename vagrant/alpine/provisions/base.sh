#!/usr/bin/env sh
set -e

# @see https://github.com/nicdoye/alpine-rvm-gcc/blob/master/Dockerfile

# packages installation ----------------------------------------------
# bash + misc utils (2, 3) + compilation + libgit2/rugged (-1)
PACKAGES=$(cat <<'EOF'
bash bash-completion
curl sed tar shadow
htop pstree vim
gcc gnupg procps musl-dev make
linux-headers zlib zlib-dev ruby ruby-dev
openssl openssl-dev libssl1.0
cmake pkgconf
EOF
)

apk update
for i in $(echo $PACKAGES | sed -e "s#\s\+#\n#g" | sort -u); do
    printf "Installing %s...\n" "$i"
    apk add "$i" || exit 95 # EOPNOTSUPP
done

# bash setup ---------------------------------------------------------
(set -e
 cd /home/vagrant

 tee .profile <<EOF > /dev/null
. /etc/profile 2>/dev/null
. "\${HOME}/.bashrc" 2>/dev/null
EOF
)

# permissions + misc  ------------------------------------------------
chown -Rf 'vagrant:vagrant' '/home/vagrant'
rm -f /home/*/*.iso
chmod o+r /proc/devices

head -1 /etc/motd | tee /etc/motd
sed -i 's#\. $script#. $script 2> /dev/null#g' /etc/profile
