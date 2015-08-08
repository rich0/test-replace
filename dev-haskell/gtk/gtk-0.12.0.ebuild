# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

# ebuild generated by hackport 0.2.13

EAPI="3"

#nocabaldep is for the fancy cabal-detection feature at build-time
CABAL_FEATURES="lib profile haddock hscolour nocabaldep"
inherit base haskell-cabal

DESCRIPTION="Haskell bindings to the Gtk+ graphical user interface library"
HOMEPAGE="http://www.haskell.org/gtk2hs/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="amd64 x86"
IUSE="+gio"

RDEPEND="=dev-haskell/cairo-0.12*:0
		=dev-haskell/glib-0.12*:0
		dev-haskell/mtl
		=dev-haskell/pango-0.12*:0
		>=dev-lang/ghc-6.10.1
		dev-libs/glib:2
		x11-libs/gtk+:2
		gio? ( =dev-haskell/gio-0.12*:0 )"
DEPEND="${RDEPEND}
		dev-haskell/gtk2hs-buildtools:0"

PATCHES=("${FILESDIR}/${PN}-0.12.0-ghc-7.2.patch"
	"${FILESDIR}/${PN}-0.12.3-glib-2.32.patch")

src_configure() {
	# Upstream has this enabled, so we might as well force it enabled to be sure.
	cabal_src_configure \
		--flags=deprecated \
		$(cabal_flag gio have-gio)
}
