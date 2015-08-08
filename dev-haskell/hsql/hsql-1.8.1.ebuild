# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

# ebuild generated by hackport 0.2.13

EAPI=4

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit base haskell-cabal

DESCRIPTION="Simple library for database access from Haskell"
HOMEPAGE="http://hackage.haskell.org/package/hsql"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

PATCHES=("${FILESDIR}"/${P}-ghc-7.4.patch)

pkg_postinst () {
	ghc-package_pkg_postinst

	elog "You will probably want to emerge one or more HSQL backend."
	elog "These backends are available:"
	elog "		hsql-postgresql"
	elog "		hsql-mysql"
	elog "		hsql-sqlite"
	elog "		hsql-odbc"
}
