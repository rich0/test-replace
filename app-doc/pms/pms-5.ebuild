# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/pms/pms-5.ebuild,v 1.2 2012/09/23 09:52:20 ulm Exp $

EAPI=4

DESCRIPTION="Gentoo Package Manager Specification"
HOMEPAGE="http://www.gentoo.org/proj/en/qa/pms.xml"
SRC_URI="mirror://gentoo/${P}.pdf"

LICENSE="CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~hppa-hpux ~ia64-hpux ~x86-interix ~amd64-linux ~arm-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~x86-netbsd ~ppc-openbsd ~x64-openbsd ~x86-openbsd ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris ~x86-winnt"

S="${WORKDIR}"

src_unpack() {
	:
}

src_install() {
	newdoc "${DISTDIR}"/${P}.pdf pms.pdf
}
