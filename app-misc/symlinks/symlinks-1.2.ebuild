# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/symlinks/symlinks-1.2.ebuild,v 1.6 2003/09/21 11:11:12 aliz Exp $

inherit flag-o-matic eutils

DESCRIPTION="Symlinks scans for and fixes broken or messy symlinks"
HOMEPAGE="http://www.ibiblio.org/pub/linux/utils/file/"
SRC_URI="http://www.ibiblio.org/pub/linux/utils/file/${P}.tar.gz
	mirror://debian/pool/main/s/symlinks/${P/-/_}-4.1.diff.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86 alpha"
IUSE="static"

DEPEND="virtual/glibc"

src_compile() {
	# bugfixes from the debian project.
	epatch ${DISTDIR}/${P/-/_}-4.1.diff.gz || die "patching failed"

	# could be useful if being used to repair
	# symlinks that are preventing shared libraries from
	# functioning.
	#

	use static && append-flags -static

	emake || die
}

src_install() {
	dobin symlinks
	doman symlinks.8
	dodoc symlinks.lsm
}
