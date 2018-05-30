#!/usr/bin/env sh
set -e

# packages installation ----------------------------------------------
# bash + misc utils + libgit2/rugged
PACKAGES=$(cat <<'EOF'
bash bash-completion
curl htop pstree pidof vim-console
cmake devel/pkgconf
EOF
)

pkg update
for i in $(echo $PACKAGES | perl -pe "s#\s+#\n#g" | sort -u); do
    printf "Installing %s ...\n" "$i"
    pkg install -Uy "$i" || exit 95 # EOPNOTSUPP
done

# bash setup ---------------------------------------------------------
(set -e
 cd /home/vagrant

 chsh -s '/usr/local/bin/bash' 'vagrant'

 tee .profile <<EOF > /dev/null
. /etc/profile 2>/dev/null
. "\${HOME}/.bashrc" 2>/dev/null
EOF
)

# .gemrc -------------------------------------------------------------
for i in /home/vagrant /root; do
    echo 'gem: --no-ri --no-rdoc' > "${i}/.gemrc"
done

# permissions + misc  ------------------------------------------------
chown -Rf 'vagrant:vagrant' '/home/vagrant'
rm -f /home/*/*.iso
head -1 /etc/motd | tee /etc/motd
