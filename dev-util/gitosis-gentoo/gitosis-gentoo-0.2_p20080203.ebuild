# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gitosis-gentoo/gitosis-gentoo-0.2_p20080203.ebuild,v 1.3 2010/03/17 17:22:38 sping Exp $

inherit eutils distutils

DESCRIPTION="gitosis -- software for hosting git repositories, Gentoo fork"
HOMEPAGE="http://git.overlays.gentoo.org/gitweb/?p=proj/gitosis-gentoo.git"
# This is a snapshot taken from the Gentoo overlays gitweb.
MY_PV="20080203-231e601545d0a09d84d3c5c2786d774f56fe9217"
MY_PN="${PN}.git"
MY_P="${MY_PN}-${MY_PV}"
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""
DEPEND=">=dev-vcs/git-1.5.3.6
		>=dev-python/setuptools-0.6_rc5"
RDEPEND="${DEPEND}
		!dev-util/gitosis"

S=${WORKDIR}/gitosis-gentoo

DOCS="example.conf gitweb.conf lighttpd-gitweb.conf TODO.rst"

pkg_setup() {
	enewgroup git
	enewuser git -1 /bin/sh /var/spool/gitosis git
}

src_install() {
	distutils_src_install
	keepdir /var/spool/gitosis
	fowners git:git /var/spool/gitosis
}

# We should handle more of this, but it requires the input of an SSH public key
# from the user, and they may want to set up more configuration first.
#pkg_config() {
#}
