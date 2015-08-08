# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )
inherit distutils-r1 flag-o-matic

DESCRIPTION="A Pythonic binding for the libxml2 and libxslt libraries"
HOMEPAGE="http://lxml.de/ http://pypi.python.org/pypi/lxml/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD ElementTree GPL-2 PSF-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ~arm64 hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="beautifulsoup3 doc examples +threads"

# Note: lib{xml2,xslt} are used as C libraries, not Python modules.
RDEPEND="
	>=dev-libs/libxml2-2.7.2
	>=dev-libs/libxslt-1.1.23
	beautifulsoup3? (
		$(python_gen_cond_dep 'dev-python/beautifulsoup:python-2[${PYTHON_USEDEP}]' 'python2*')
		$(python_gen_cond_dep 'dev-python/beautifulsoup:python-3[${PYTHON_USEDEP}]' 'python3*')
	)"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
# lxml tarball contains files pregenerated by Cython.

DISTUTILS_IN_SOURCE_BUILD=1

python_prepare_all() {
	# avoid replacing PYTHONPATH in tests.
	sed -i '/sys\.path/d' test.py || die

	distutils-r1_python_prepare_all
}

python_compile() {
	if [[ ${EPYTHON} != python3* ]]; then
		local CFLAGS=${CFLAGS}
		append-cflags -fno-strict-aliasing
	fi
	distutils-r1_python_compile
}

python_test() {
	cp -r -l src/lxml/tests "${BUILD_DIR}"/lib/lxml/ || die
	cp -r -l src/lxml/html/tests "${BUILD_DIR}"/lib/lxml/html/ || die
	ln -s "${S}"/doc "${BUILD_DIR}"/ || die

	local test
	for test in test.py selftest.py selftest2.py; do
		einfo "Running ${test}"
		"${PYTHON}" ${test} || die "Test ${test} fails with ${EPYTHON}"
	done
}

python_install_all() {
	if use doc; then
		local DOCS=( *.txt doc/*.txt )
		local HTML_DOCS=( doc/html/. )
	fi
	use examples && local EXAMPLES=( samples/. )

	distutils-r1_python_install_all
}
