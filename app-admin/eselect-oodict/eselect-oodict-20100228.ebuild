# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-oodict/eselect-oodict-20100228.ebuild,v 1.2 2012/01/15 15:37:56 phajdan.jr Exp $

DESCRIPTION="Manages configuration of dictionaries for OpenOffice.Org."
HOMEPAGE="http://www.gentoo.org/"

SRC_URI="mirror://gentoo/oodict.eselect-${PVR}.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc x86 ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

RDEPEND=">=app-admin/eselect-1.2"

src_install() {
	insinto /usr/share/eselect/modules
	newins "${WORKDIR}"/oodict.eselect-${PVR} oodict.eselect || die "newins failed"
}
