# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"
PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="A torrent file parser"
HOMEPAGE="https://github.com/Fuuzetsu/torrentinfo"
SRC_URI="https://github.com/Fuuzetsu/torrentinfo/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? ( dev-python/nose[${PYTHON_USEDEP}] )
"

python_test() {
	nosetests -v test/tests.py || die "Tests fail with ${EPYTHON}"
}
