# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3} pypy )

inherit distutils-r1 eutils

DESCRIPTION="A simple Python socket pool"
HOMEPAGE="http://github.com/benoitc/socketpool/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
IUSE="examples"
LICENSE="|| ( MIT public-domain )"
SLOT="0"

RDEPEND="dev-python/gevent"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}"/${P}-locale.patch
	"${FILESDIR}"/${P}-pool.patch )

src_install() {
	distutils-r1_src_install
	if use examples; then
		docompress -x usr/share/doc/${P}/examples
		insinto usr/share/doc/${P}
		doins -r examples/
	fi
}

python_test() {
	PYTHONPATH=. py.test tests/test_pool_01.py
}
