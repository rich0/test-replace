# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-prime/scim-prime-1.0.1.ebuild,v 1.2 2011/12/04 16:43:50 hwoarang Exp $

inherit eutils

DESCRIPTION="Japanese input method PRIME IMEngine for SCIM"
HOMEPAGE="http://scim-imengine.sourceforge.jp/index.cgi?cmd=view;name=SCIMPRIME"
SRC_URI="mirror://sourceforge.jp/scim-imengine/29156/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=app-i18n/scim-1.0
	>=app-i18n/prime-1.0.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	elog
	elog "To use SCIM, you should use the following in your user startup scripts"
	elog "such as .gnomerc or .xinitrc:"
	elog
	elog "LANG='your_language' scim -d"
	elog "export XMODIFIERS=@im=SCIM"
	elog "export GTK_IM_MODULE=scim"
	elog "export QT_IM_MODULE=scim"
	elog
}
