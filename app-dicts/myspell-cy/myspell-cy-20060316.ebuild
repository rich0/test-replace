# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-cy/myspell-cy-20060316.ebuild,v 1.9 2006/08/01 14:24:48 blubb Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"cy,GB,cy_GB,Welsh (Wales),cy_GB.zip"
"cy,GB,cy_GB,Welsh (Wales),cy_GB.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell

DESCRIPTION="Welsh dictionaries for myspell/hunspell"
LICENSE="GPL-2"
HOMEPAGE="http://lingucomponent.openoffice.org/"

KEYWORDS="amd64 ppc sparc x86 ~x86-fbsd"
