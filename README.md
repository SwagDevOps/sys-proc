# A Ruby module to customize the process name

The ``sys-proc`` module allows a process to change its name,
as displayed by system tools such as ``ps`` and ``top``.
It SHOULD allow (too), depending on system support,
to __kill__ the renamed process by name, using ``killall``.
The procedure is hardly portable across different systems.
At the moment, this module __is fully compatible with GNU/Linux__
(using ``prctl``). Freebsd is partially supported, using
``setprogname`` and ``getprogname``
(provided by the [BSD libc](https://rosettacode.org/wiki/Category:BSD_libc)).

This module provides the necessary architecture to, potentially,
support even more systems.

<!--
Changing the title is mostly useful in multi-process systems,
for example when a master process is forked: changing the children's
title allows to identify the task each process is busy with.
-->


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

## Sample of use

```ruby
require 'sys/proc'

Sys::Proc.progname = :awesome
```

## Inspirations

Some inspiration taken from:

* [BSD::setproctitle - Perl interface to BSD's setprogname(3) and setproctitle(3)](https://metacpan.org/pod/release/MKAMM/BSD-setproctitle-0.01/lib/BSD/setproctitle.pm)
  * [setprogname(3) - FreeBSD Library Functions Manual](https://www.freebsd.org/cgi/man.cgi?query=setprogname&sektion=3)
  * [setproctitle(3) - FreeBSD Library Functions Manual](https://www.freebsd.org/cgi/man.cgi?query=setproctitle&sektion=3)
* [djberg96/sys-proctable](https://github.com/djberg96/sys-proctable)
* [A Python module to customize the process title](https://github.com/dvarrazzo/py-setproctitle)
