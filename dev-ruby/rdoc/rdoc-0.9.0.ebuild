# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rdoc/rdoc-0.9.0.ebuild,v 1.2 2003/07/12 13:03:10 aliz Exp $

DESCRIPTION="Generates structured HTML documentation from Ruby source"
HOMEPAGE="http://rdoc.sourceforge.net/"
SRC_URI="mirror://sourceforge/rdoc/${P}.tgz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="x86"
IUSE="X"
DEPEND=">=dev-lang/ruby-1.6.5
	X? ( >=media-gfx/graphviz-1.7 )"

src_compile() {
	local myconf
	use X && myconf="${myconf} --diagram"
	ruby rdoc.rb ${myconf}
}

src_install() {
	DESTDIR=${D} ruby install.rb || die
	dodoc ChangeLog EXAMPLE.rb NEW_FEATURES README ToDo
	dohtml -r doc
	cp -R contrib ${D}/usr/share/doc/${PF}/${DOCDESTTREE}
	cp -R etc ${D}/usr/share/doc/${PF}/${DOCDESTTREE}
}
