# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnetfilter_log/libnetfilter_log-0.0.15.ebuild,v 1.7 2012/05/05 02:54:31 jdhore Exp $

inherit linux-info

DESCRIPTION="interface to packets that have been logged by the kernel packet filter"
HOMEPAGE="http://www.netfilter.org/projects/libnetfilter_log/"
SRC_URI="http://www.netfilter.org/projects/${PN}/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=net-libs/libnfnetlink-0.0.39"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

CONFIG_CHECK="~NETFILTER_NETLINK_LOG"

pkg_setup() {
	linux-info_pkg_setup
	kernel_is lt 2 6 14 && die "requires at least 2.6.14 kernel version"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
