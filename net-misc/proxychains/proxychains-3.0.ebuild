# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/proxychains/proxychains-3.0.ebuild,v 1.2 2006/03/05 20:07:02 vapier Exp $

# This doesn't seem to be 64bit clean ... on amd64 for example,
# trying to do `proxychains telnet 192.168.0.77` will attempt to 
# connect to '10.0.0.5' instead:
# $ strace -econnect ./proxychains telnet 192.168.0.77
# connect(4, {sa_family=AF_INET, sin_port=htons(3128), sin_addr=inet_addr("10.0.0.5")}, 16) = -1 

inherit eutils

DESCRIPTION="force any tcp connections to flow through a proxy (or proxy chain)"
HOMEPAGE="http://proxychains.sourceforge.net/"
SRC_URI="mirror://sourceforge/proxychains/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND=""

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO
}
