# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sphinx/sphinx-1.0_beta2.ebuild,v 1.2 2010/06/05 19:19:59 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_PN="Sphinx"
MY_P="${MY_PN}-${PV/_beta/b}"

DESCRIPTION="Tool to create documentation for Python projects"
HOMEPAGE="http://sphinx.pocoo.org/ http://pypi.python.org/pypi/Sphinx"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="doc latex"

RDEPEND=">=dev-python/pygments-0.8
	>=dev-python/jinja-2.2
	>=dev-python/docutils-0.5
	latex? ( dev-texlive/texlive-latexextra )"
DEPEND="${RDEPEND}
	dev-python/setuptools"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES"

src_compile() {
	distutils_src_compile

	if use doc; then
		cd doc
		einfo "Generation of documentation"
		PYTHONPATH="../" emake SPHINXBUILD="$(PYTHON -f) ../sphinx-build.py" html || die "Generation of documentation failed"
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -A txt -r doc/_build/html/* || die "dohtml failed"
	fi
}

pkg_postinst() {
	distutils_pkg_postinst

	# Generating the Grammar pickle to avoid on the fly generation causing sandbox violations (bug #266015)
	generation_of_grammar_pickle() {
		"$(PYTHON)" -c "from sphinx.pycode.pgen2.driver import load_grammar; load_grammar('${ROOT%/}${EPREFIX}$(python_get_sitedir)/sphinx/pycode/Grammar.txt')" || die "Generation of grammar pickle failed"
	}
	python_execute_function --action-message 'Generation of Grammar pickle with Python ${PYTHON_ABI}...' generation_of_grammar_pickle
}

pkg_postrm() {
	distutils_pkg_postrm

	deletion_of_grammar_pickle() {
		rm "${ROOT%/}${EPREFIX}$(python_get_sitedir)/sphinx/pycode"/Grammar*.pickle
	}
	python_execute_function --action-message 'Deletion of Grammar pickle with Python ${PYTHON_ABI}...' deletion_of_grammar_pickle
}
