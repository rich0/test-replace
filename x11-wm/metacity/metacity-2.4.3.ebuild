# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/metacity/metacity-2.4.3.ebuild,v 1.2 2002/11/03 15:00:29 foser Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="Small gtk2 WindowManager"
HOMEPAGE="http://people.redhat.com/~hp/metacity/"
SLOT="1"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~sparc64"

RDEPEND="virtual/x11
	>=x11-libs/gtk+-2
	>=gnome-base/gconf-1.2
	>=gnome-base/libglade-2
	>=x11-libs/startup-notification-0.3"


DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.21"

DOCS="AUTHORS ChangeLog HACKING INSTALL NEWS README"

src_unpack(){
	unpack ${A}
	# causes ICE on ppc w/ gcc (still)
	use ppc && (
		[ -z "${CC}" ] && CC=gcc
		if [ "`${CC} -dumpversion | cut -d. -f1,2`" != "2.95" ] ; then
			patch -p0 < ${FILESDIR}/metacity-2.4.1-ppc-gcc3.2.diff || die "patch failed"
		fi
	)
}
