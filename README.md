# A Ruby module to customize the process title

The ``sys-proc`` module allows a process to change its title (as displayed by system tools such as ``ps`` and ``top``).

Changing the title is mostly useful in multi-process systems,
for example when a master process is forked: changing the children's
title allows to identify the task each process is busy with.

The procedure coulbd hardly portable across different systems.
This module is only compatible with linux (using ``prctl``),
as fully operational/implemented.
This module provides the necessary architecture to support even more systems.

## Installation

```
sudo gem install sys-proc
```

alternatively, install a development version (from github):

```
git clone https://github.com/SwagDevOps/sys-proc sys-proc
cd !$
bundle install --path vendor/bundle
rake gem:install
```

## Inspirations

Some inspiration taken from:

* [BSD::setproctitle - Perl interface to BSD's setprogname(3) and setproctitle(3)](https://metacpan.org/pod/release/MKAMM/BSD-setproctitle-0.01/lib/BSD/setproctitle.pm)
  * [setprogname(3) - FreeBSD Library Functions Manual](https://www.freebsd.org/cgi/man.cgi?query=setprogname&sektion=3)
  * [setproctitle(3) - FreeBSD Library Functions Manual](https://www.freebsd.org/cgi/man.cgi?query=setproctitle&sektion=3)
* [djberg96/sys-proctable](https://github.com/djberg96/sys-proctable)
* [A Python module to customize the process title](https://github.com/dvarrazzo/py-setproctitle)
