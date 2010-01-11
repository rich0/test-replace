# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-htmlxml/texlive-htmlxml-2009.ebuild,v 1.1 2010/01/11 03:18:17 aballier Exp $

TEXLIVE_MODULE_CONTENTS="  xmlplay  collection-htmlxml
"
TEXLIVE_MODULE_DOC_CONTENTS="xmlplay.doc "
TEXLIVE_MODULE_SRC_CONTENTS="xmlplay.source "
inherit texlive-module
DESCRIPTION="TeXLive HTML/SGML/XML support"

LICENSE="GPL-2 public-domain "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2009
>=dev-texlive/texlive-fontsrecommended-2009
>=dev-texlive/texlive-latex-2009
"
RDEPEND="${DEPEND} "
