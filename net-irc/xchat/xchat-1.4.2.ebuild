# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-irc/xchat/xchat-1.4.2.ebuild,v 1.1 2000/08/23 07:00:07 drobbins Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="xchat"
SRC_URI="http://www.xchat.org/files/source/1.4/"${A}
HOMEPAGE="http://www.xchat.org/"

src_compile() {                           
  cd ${S}
  if [ -n "`use gnome`" ]
  then
  	./configure --host=${CHOST} --enable-gnome --disable perl --prefix=/opt/gnome --with-catgets
  else
  	./configure --host=${CHOST} --disable-gnome --disable-perl --prefix=/usr/X11R6 --with-catgets
  fi
  make
}

src_install() {                               
  cd ${S}
  if [ -n "`use gnome`" ]
  then
  	make prefix=${D}/opt/gnome install
  else
  	make prefix=${D}/usr/X11R6 install
  fi
  dodoc AUTHORS COPYING ChangeLog NEWS README

}






