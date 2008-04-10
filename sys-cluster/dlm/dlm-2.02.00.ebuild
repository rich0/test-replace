# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/dlm/dlm-2.02.00.ebuild,v 1.3 2008/04/10 15:11:22 mr_bones_ Exp $

inherit eutils versionator

CLUSTER_RELEASE="${PV}"
MY_P="cluster-${CLUSTER_RELEASE}"

MAJ_PV="$(get_major_version)"
MIN_PV="$(get_version_component_range 2).$(get_version_component_range 3)"

DESCRIPTION="General-purpose Distributed Lock Manager"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sys-kernel/linux-headers-2.6.23
	!sys-cluster/dlm-headers
	!sys-cluster/dlm-kernel
	=sys-cluster/dlm-lib-${CLUSTER_RELEASE}*
	"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# fix the manual pages have executable bit
	sed -i -e '
		/\tinstall -d/s/install/& -m 0755/; t
		/\tinstall/s/install/& -m 0644/' \
		man/Makefile || die "failed patching man pages permission"

	epatch "${FILESDIR}"/${P}-include.patch || die
}

src_compile() {
	(cd "${WORKDIR}"/${MY_P};
		./configure \
			--cc=$(tc-getCC) \
			--cflags="-Wall" \
			--disable_kernel_check \
			--release_major="$MAJ_PV" \
			--release_minor="$MIN_PV" \
			--cmanlibdir=/usr/lib \
			--dlmlibdir=/usr/lib \
			--dlmincdir=/usr/include \
	) || die "configure problem"

	emake clean || die "clean problem"
	for i in tool man; do
		emake -C $i || die "compile problem"
	done
}

src_install() {
	for i in tool man; do
		emake DESTDIR="${D}" -C $i install || die "install problem"
	done

	dodoc doc/*.txt
}
