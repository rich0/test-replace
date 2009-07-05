# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ifenslave/ifenslave-1.1.0-r5.ebuild,v 1.1 2009/07/05 20:05:42 robbat2 Exp $

inherit toolchain-funcs eutils

DESCRIPTION="Attach and detach slave interfaces to a bonding device"
HOMEPAGE="http://sf.net/projects/bonding/"
MY_PN="ifenslave-2.6" # this is NOT an error
DEBIAN_PV="13"
DEBIANPKG_TARBALL="${MY_PN}_${PV}.orig.tar.gz"
DEBIANPKG_PATCH="${MY_PN}_${PV}-${DEBIAN_PV}.diff.gz"
DEBIANPKG_BASE="mirror://debian/pool/main/${MY_PN:0:1}/${MY_PN}"
SRC_URI="${DEBIANPKG_BASE}/${DEBIANPKG_TARBALL}
		 ${DEBIANPKG_BASE}/${DEBIANPKG_PATCH}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
RDEPEND="virtual/libc"
DEPEND="sys-devel/gcc
		>=sys-kernel/linux-headers-2.4.22
		${RDEPEND}"

src_unpack() {
	unpack ${DEBIANPKG_TARBALL}
	EPATCH_OPTS="-d ${S} -p1" epatch "${DISTDIR}"/${DEBIANPKG_PATCH}
}

src_compile() {
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} ${PN}.c -o ${PN} || die "Failed to compile!"
}

src_install() {
	doman ${PN}.8
	into /
	dosbin ${PN}
	# there really is no better documentation than the sourcecode :-)
	dodoc ${PN}.c
	insinto /etc/modprobe.d
	newins "${FILESDIR}"/modules.d-bond-1.1.0-r3 bond.conf
}

pkg_preinst() {
	if [[ -a /etc/modules.d/bond ]] && [[ ! -a /etc/modprobe.d/bond ]]; then
		elog "Moving old bond configuration in modules.d to new"
		elog "location in modprobe.d in /etc/"
		mv "${ROOT}"/etc/{modules,modprobe}.d/bond
	fi
	if [[ -a /etc/modprobe.d/bond ]] && [[ ! -a /etc/modprobe.d/bond.conf ]]; then
		elog "Moving old bond configuration in modprobe.d to"
		elog "new naming scheme with trailing .conf"
		mv "${ROOT}"/etc/modprobe.d/bond{,.conf}
	fi
}

pkg_postinst() {
	einfo "If you want to use bonding on your system, be sure to use"
	einfo ">=baselayout-1.10, where support is now integrated!"
	einfo "Using >=baselayout-1.11.6 strongly recommended."
}
