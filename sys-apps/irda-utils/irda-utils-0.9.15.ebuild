# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Mikael Hallendal <micke@hallendal.net>
# /space/gentoo/cvsroot/gentoo-x86/sys-apps/irda-utils/irda-utils-0.9.13.ebuild,v 1.2 2002/01/01 22:35:51 azarah Exp

S=${WORKDIR}/${P}
DESCRIPTION="IrDA Utilities, tools for IrDA communication"
SRC_URI="mirror://sourceforge/irda/${P}.tar.gz"
HOMEPAGE="http://irda.sf.net"
KEYWORDS="~x86 -ppc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

src_compile() {
	make ROOT="${D}" RPM_BUILD_ROOT="${D}" || die "Making failed."
	cd irsockets
	make || die "Making irsockets failed."
}

src_install () {
 	dodir /usr/bin
 	dodir /usr/sbin
	dodir /usr/X11R6/bin

	make install PREFIX="${D}" ROOT="${D}" || die "Couldn't install from ${S}"
	
	into /usr
	dobin irsockets/irdaspray
	dobin irsockets/ias_query
	dobin irsockets/irprintf
	dobin irsockets/irprintfx
	dobin irsockets/irscanf
	dobin irsockets/recv_ultra
	dobin irsockets/send_ultra

	# install README's into /usr/share/doc
	for i in *
	do
		if [ -d $i -a $i != "man" ]; then
			if [ -f $i/README ]; then
				cp $i/README README.$i
				dodoc README.$i
				rm README.$i
			fi
		fi
	done

	insinto /etc/conf.d ; newins ${FILESDIR}/irda.conf irda
	insinto /etc/init.d ; insopts -m0755 ; newins ${FILESDIR}/irda.rc irda
}

