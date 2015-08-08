# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils multilib systemd toolchain-funcs

DESCRIPTION="System performance tools for Linux"
HOMEPAGE="http://pagesperso-orange.fr/sebastien.godard/"
SRC_URI="${HOMEPAGE}${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug +doc isag nls lm_sensors selinux"

CDEPEND="
	isag? (
		dev-lang/tk:0
		dev-vcs/rcs
		sci-visualization/gnuplot
	)
	nls? ( virtual/libintl )
	lm_sensors? ( sys-apps/lm_sensors )
"
DEPEND="
	${CDEPEND}
	nls? ( sys-devel/gettext )
"
RDEPEND="
	${CDEPEND}
	selinux? ( sec-policy/selinux-sysstat )
"

SYSSTAT_FAKE_RC_DIR=Gentoo-does-not-use-rc.d

src_prepare() {
	if use nls; then
		strip-linguas -i nls/
		local lingua pofile
		for pofile in nls/*.po; do
			lingua=${pofile/nls\/}
			lingua=${lingua/.po}
			if ! has ${lingua} ${LINGUAS}; then
				rm "nls/${lingua}.po" || die
			fi
		done
	fi
	epatch \
		"${FILESDIR}"/${PN}-10.0.4-flags.patch \
		"${FILESDIR}"/${PN}-11.0.4-cron.patch
}

src_configure() {
	tc-export AR
	sa_lib_dir=/usr/$(get_libdir)/sa \
		conf_dir=/etc \
		rcdir=${SYSSTAT_FAKE_RC_DIR} \
		econf \
			--enable-copy-only \
			--with-systemdsystemunitdir=$(systemd_get_unitdir) \
			$(use_enable debug debuginfo) \
			$(use_enable doc documentation ) \
			$(use_enable isag install-isag) \
			$(use_enable lm_sensors sensors) \
			$(use_enable nls) \
			--enable-install-cron
}

src_compile() {
	emake LFLAGS="${LDFLAGS}"
}

src_install() {
	keepdir /var/log/sa

	emake \
		DESTDIR="${D}" \
		DOC_DIR=/usr/share/doc/${PF} \
		install

	dodoc contrib/sargraph/sargraph

	rm -r "${D}/${SYSSTAT_FAKE_RC_DIR}" || die
	newinitd "${FILESDIR}"/${PN}.init.d ${PN}
	systemd_dounit ${PN}.service

	use doc && rm -f "${D}"usr/share/doc/${PF}/COPYING
}
