# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/claws-mail-mailmbox/claws-mail-mailmbox-1.14.ebuild,v 1.7 2008/02/13 20:52:21 ticho Exp $

MY_P="${P#claws-mail-}"

DESCRIPTION="Plugin for sylpheed-claws to operate on mbox type mailboxes"
HOMEPAGE="http://www.claws-mail.org"
SRC_URI="http://www.claws-mail.org/downloads/plugins/${MY_P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""
DEPEND=">=mail-client/claws-mail-3.0.0
		dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_install() {
	make DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README

	# kill useless files
	rm -f "${D}"/usr/lib*/claws-mail/plugins/*.{a,la}
}
