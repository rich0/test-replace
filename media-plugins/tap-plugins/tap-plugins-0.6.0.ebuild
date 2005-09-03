# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/tap-plugins/tap-plugins-0.6.0.ebuild,v 1.3 2005/09/03 23:47:00 flameeyes Exp $
#

DESCRIPTION="TAP ladspa plugins package. Contains DeEsser, Dynamics, Equalizer, Reverb, Stereo Echo, Tremolo"
HOMEPAGE="http://tap-plugins.sourceforge.net"
SRC_URI="mirror://sourceforge/tap-plugins/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"
IUSE=""

DEPEND="media-libs/ladspa-sdk"

src_compile() {
	emake || die
}

src_install() {
	dodoc README CREDITS
	dohtml ${S}/doc/*
	insinto /usr/lib/ladspa
	insopts -m0755
	doins *.so
	insinto /usr/share/ladspa/rdf
	insopts -m0644
	doins *.rdf
}
