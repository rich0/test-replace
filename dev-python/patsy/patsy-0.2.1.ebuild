# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3} )

inherit distutils-r1

DESCRIPTION="Python module to describe statistical models and design matrices"
HOMEPAGE="http://patsy.readthedocs.org/en/latest/index.html"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc test"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? (
		dev-python/ipython
		dev-python/matplotlib
		dev-python/sphinx )
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

python_compile_all() {
	use doc && emake -C doc html
}

python_test() {
	cd "${BUILD_DIR}" || die
	nosetests -v || die "Testing failed with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
	use doc && dohtml -r doc/_build/html/*
}
