# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/demerge/demerge-0.046.ebuild,v 1.7 2008/11/18 15:57:52 tove Exp $

DESCRIPTION="demerge - revert to previous installation states"
HOMEPAGE="http://download.mpsna.de/opensource/demerge/"
SRC_URI="http://download.mpsna.de/opensource/demerge/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ia64 ppc sparc x86"
IUSE=""

DEPEND="dev-lang/perl
		>=dev-perl/PortageXS-0.02.06
		virtual/perl-Term-ANSIColor
		dev-perl/TermReadKey
		dev-perl/Shell-EnvImporter"
RDEPEND="${DEPEND}
		sys-apps/portage"

src_install() {
	dobin demerge || die
	dodoc Changelog
	doman demerge.3
}

pkg_postinst() {
	if [ ! -e /etc/portage/postsync.d/demerge-record ]; then
		mkdir -p /etc/portage/postsync.d/
		echo '[ -x /usr/bin/demerge ] && /usr/bin/demerge --postsync' > /etc/portage/postsync.d/demerge-record
		elog "/etc/portage/postsync.d/demerge-record has been installed for convenience"
		elog "If you wish for it to be automatically run at the end of every --sync simply chmod +x /etc/portage/postsync.d/demerge-record"
		elog "If ever you find this to be an inconvenience simply chmod -x /etc/portage/postsync.d/demerge-record"
	fi
}
