# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-luatex/texlive-luatex-2009.ebuild,v 1.1 2010/01/11 03:31:20 aballier Exp $

TEXLIVE_MODULE_CONTENTS="luainputenc luamplib luaotfload luatextra collection-luatex
"
TEXLIVE_MODULE_DOC_CONTENTS="luainputenc.doc luamplib.doc luaotfload.doc luatextra.doc "
TEXLIVE_MODULE_SRC_CONTENTS="luainputenc.source luamplib.source luaotfload.source luatextra.source "
inherit texlive-module
DESCRIPTION="TeXLive LuaTeX packages"

LICENSE="GPL-2 as-is public-domain "
SLOT="0"
KEYWORDS="~amd64 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2009
>=dev-tex/luatex-0.45

"
RDEPEND="${DEPEND} "
