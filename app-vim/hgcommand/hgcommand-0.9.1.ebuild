# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/hgcommand/hgcommand-0.9.1.ebuild,v 1.1 2006/08/08 20:06:48 agriffis Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: mercurial integration plugin"
HOMEPAGE="http://www.selenic.com/pipermail/mercurial/2006-July/009510.html"
SRC_URI="http://www.selenic.com/mercurial/release/mercurial-${PV}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="~dev-util/mercurial-${PV}"

src_unpack() {
	unpack ${A} || die
	mkdir -p ${S}/plugin || die
	cd ${WORKDIR}/mercurial-${PV}/contrib/vim || die
	mv ${PN}.vim ${S}/plugin || die
	if [[ -f ${PN}.txt ]]; then
		mkdir ${S}/doc || die
		mv ${PN}.txt ${S}/doc || die
	fi
}
