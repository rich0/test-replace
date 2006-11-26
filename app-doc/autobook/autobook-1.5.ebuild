# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/autobook/autobook-1.5.ebuild,v 1.2 2006/11/26 12:27:56 vapier Exp $

DESCRIPTION="GNU Autoconf, Automake and Libtool"
HOMEPAGE="http://sources.redhat.com/autobook/"
SRC_URI="http://sources.redhat.com/autobook/${P}.tar.gz
	examples? (
		http://sources.redhat.com/autobook/foonly-2.0.tar.gz
		http://sources.redhat.com/autobook/small-2.0.tar.gz
		http://sources.redhat.com/autobook/hello-2.0.tar.gz
		http://sources.redhat.com/autobook/convenience-2.0.tar.gz
	)"

LICENSE="OPL"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="examples"

DEPEND=""

src_install() {
	dohtml * || die
	if use examples ; then
		local d
		for d in {convenience,foonly,hello,small}-2.0 ; do
			insinto /usr/share/doc/${PF}/${d}
			doins -r "${WORKDIR}"/${d}/* || die "doins ${d} failed"
		done
	fi
}
