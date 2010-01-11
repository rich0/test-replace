# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langtibetan/texlive-langtibetan-2009.ebuild,v 1.1 2010/01/11 03:28:18 aballier Exp $

TEXLIVE_MODULE_CONTENTS="ctib otibet collection-langtibetan
"
TEXLIVE_MODULE_DOC_CONTENTS="ctib.doc otibet.doc "
TEXLIVE_MODULE_SRC_CONTENTS="ctib.source otibet.source "
inherit texlive-module
DESCRIPTION="TeXLive Tibetan"

LICENSE="GPL-2 GPL-1 "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2009
"
RDEPEND="${DEPEND} "
