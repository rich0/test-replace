# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/misterhouse/misterhouse-2.103.ebuild,v 1.1 2006/10/19 21:29:42 mcummings Exp $


DESCRIPTION="Mister House, an open source home automation program with X10 support"
HOMEPAGE="http://misterhouse.sf.net/"
LICENSE="GPL-1"
SRC_URI="mirror://sourceforge/misterhouse/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="tcltk mysql"

DEPEND=""

RDEPEND="dev-lang/perl
	tcltk? ( dev-perl/perl-tk
		dev-perl/Tk-CursorControl )
	mysql? ( dev-perl/DBD-mysql )
	|| ( app-accessibility/festival
		app-accessibility/flite )
	dev-perl/GD
	virtual/perl-DB_File
	dev-perl/TermReadKey
	virtual/perl-Time-HiRes
	dev-perl/Audio-Mixer
	dev-perl/Text-LevenshteinXS"


src_install() {
	dodir /opt/misterhouse

	cp -r "${S}/bin" "${D}/opt/misterhouse"
	cp -r "${S}/code" "${D}/opt/misterhouse"
	cp -r "${S}/data" "${D}/opt/misterhouse"
	for a in ${S}/docs/*; do
		dodoc ${a}
	done
	dosym /usr/share/doc/${PF} /opt/misterhouse/docs
	cp -r "${S}/lib" "${D}/opt/misterhouse"
	cp -r "${S}/sounds" "${D}/opt/misterhouse"
	cp -r "${S}/web" "${D}/opt/misterhouse"
	newconfd "${FILESDIR}"/misterhouse.conf misterhouse
	newinitd "${FILESDIR}"/misterhouse.init misterhouse

}

pkg_postinst() {
	cd /opt/misterhouse/bin
	./configure
}
