# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-texinfo/texlive-texinfo-2011.ebuild,v 1.9 2012/05/06 18:14:05 armin76 Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="texinfo collection-texinfo
"
TEXLIVE_MODULE_DOC_CONTENTS=""
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit  texlive-module
DESCRIPTION="TeXLive GNU Texinfo"

LICENSE="GPL-2 GPL-1 "
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2011
"
RDEPEND="${DEPEND} dev-texlive/texlive-genericrecommended
dev-texlive/texlive-latex
"
