# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/indeview/indeview-0.6.5.ebuild,v 1.1 2004/04/22 17:00:17 kanaka Exp $

DESCRIPTION="Convert OpenOffice/KOffice to run independently on Linux, OSX, or Windows"
HOMEPAGE="http://www.indeview.org/"
SRC_URI="http://www.${PN}.org/download/${P}.tgz"
LICENSE="LGPL-2.1"
SLOT="0"

KEYWORDS="~x86"
IUSE=""
RDEPEND="x11-libs/qt"

S=${WORKDIR}/${P}/Viewer

src_compile() {
	qmake || die "qmake failed"
	make || die "make failed"

	# Fix up the OpenOffice macro file
	cd ${S}/../Creator/OpenOffice/
	cp IndeViewExport.bas IndeViewExport.mo.bas
	sed -i -e 's:unknown:/usr/share/IndeView/ROOT_DATA:' IndeViewExport.mo.bas
	# Convert special characters to &XXX; style
	sed -i -e 's/&/\&amp;/g' IndeViewExport.mo.bas
	sed -i -e 's/"/\&quot;/g' IndeViewExport.mo.bas
	sed -i -e 's/</\&lt;/g' IndeViewExport.mo.bas
	sed -i -e 's/>/\&gt;/g' IndeViewExport.mo.bas
	sed -i -e "s/'/\&apos;/g" IndeViewExport.mo.bas
	sed -i -e 's/�/o/g' IndeViewExport.mo.bas

	cat >> IndeViewExport.xba << _EOF_
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE script:module PUBLIC "-//OpenOffice.org//DTD OfficeDocument 1.0//EN" "module.dtd">
<script:module xmlns:script="http://openoffice.org/2000/script" script:name="IndeViewExport" script:language="StarBasic">
_EOF_
	cat IndeViewExport.mo.bas >> IndeViewExport.xba
	cat >> IndeViewExport.xba << _EOF_
</script:module>
_EOF_

}

src_install() {
	dobin bin/indeview
	dobin ../Creator/KPresenter/kpr2iv.sh

	cd ${S}/..
	dohtml -r doc/html/*
	dodoc LICENSE README AUTHORS

	dodir /usr/share/IndeView
	cp -a ${S}/../ROOT_DATA ${D}/usr/share/IndeView/

	dodir /opt/OpenOffice.org/share/basic/Tools
	insinto /opt/OpenOffice.org/share/basic/Tools
	cd ${S}/../Creator/OpenOffice/

	doins IndeViewExport.xba
}

pkg_postinst() {
	grep "IndeViewExport" /opt/OpenOffice.org/share/basic/Tools/script.xlb > /dev/null ||
		sed -i -e 's;</library:library>; <library:element library:name="IndeViewExport"/>\n</library:library>;' /opt/OpenOffice.org/share/basic/Tools/script.xlb
}

pkg_postrm() {
	if [ ! -e ${ROOT}/usr/bin/indeview ];
	then
		sed -i -e '/^ <library:element library:name="IndeViewExport"\/>$/d' /opt/OpenOffice.org/share/basic/Tools/script.xlb
	fi
}
