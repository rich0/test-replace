# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/imlib2_loaders/imlib2_loaders-1.0.4.20031013.ebuild,v 1.1 2003/10/14 02:41:41 vapier Exp $

inherit enlightenment flag-o-matic

DESCRIPTION="image loader plugins for Imlib 2"
HOMEPAGE="http://www.enlightenment.org/pages/imlib2.html"

IUSE="${IUSE} X"

DEPEND="${DEPEND}
	>=media-libs/imlib2-1.1.0
	>=dev-db/edb-1.0.4.20031013
	>=dev-libs/eet-0.9.0.20031013"

src_compile() {
	cp autogen.sh{,.old}
	sed -e 's:.*configure.*::' autogen.sh.old > autogen.sh
	env WANT_AUTOCONF_2_5=1 ./autogen.sh || die "could not autogen"
	cd libltdl && env WANT_AUTOCONF_2_5=1 autoconf && cd ..

	use alpha && append-flags '-fPIC'

	econf \
		--enable-eet \
		--enable-edb \
		|| die
	emake || die
}
