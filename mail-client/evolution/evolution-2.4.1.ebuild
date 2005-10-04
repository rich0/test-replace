# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/evolution/evolution-2.4.1.ebuild,v 1.1 2005/10/04 12:54:33 dang Exp $

inherit eutils flag-o-matic alternatives gnome2

DESCRIPTION="Integrated mail, addressbook and calendaring functionality"
HOMEPAGE="http://www.gnome.org/projects/evolution/"

LICENSE="GPL-2 FDL-1.1"
SLOT="2.0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="crypt dbus debug doc gstreamer ipv6 kerberos krb4 ldap mono mozilla nntp pda profile spell ssl static"

# Pango dependency required to avoid font rendering problems
RDEPEND=">=x11-themes/gnome-icon-theme-1.2
	dev-libs/atk
	>=gnome-extra/libgtkhtml-3.7
	>=dev-libs/glib-2
	>=gnome-base/orbit-2.9.8
	>=gnome-base/libbonobo-2
	>=gnome-extra/evolution-data-server-1.3.1
	>=gnome-base/libbonoboui-2.4.2
	>=gnome-base/gnome-vfs-2.4
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=gnome-base/libgnomecanvas-2
	>=dev-libs/libxml2-2
	>=gnome-base/gconf-2
	>=gnome-base/libgnomeprint-2.2
	>=gnome-base/libgnomeprintui-2.2.1
	>=x11-libs/gtk+-2
	>=gnome-base/libgnome-2
	>=net-libs/libsoup-2.2.2
	>=x11-libs/pango-1.8.1
	mail-filter/spamassassin
	pda? (
		>=app-pda/gnome-pilot-2
		>=app-pda/gnome-pilot-conduits-2 )
	spell? ( >=app-text/gnome-spell-1.0.5 )
	crypt? ( >=app-crypt/gnupg-1.2.2 )
	ssl? (
		mozilla? ( >=www-client/mozilla-1.7.3 )
		!mozilla? (
			>=dev-libs/nspr-4.4.1
			>=dev-libs/nss-3.9.2 ) )
	ldap? ( >=net-nds/openldap-2 )
	kerberos? ( virtual/krb5 )
	krb4? ( virtual/krb5 )
	gstreamer? (
		=media-libs/gstreamer-0.8*
		=media-libs/gst-plugins-0.8* )
	dbus? ( sys-apps/dbus )
	mono? ( >=dev-lang/mono-1 )"
#		mozilla? ( !firefox? ( >=www-client/mozilla-1.7.3 ) )
#		firefox? ( >=www-client/mozilla-firefox-1.0.7-r3 )
#		!mozilla? ( !firefox? (

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.30
	sys-devel/gettext
	sys-devel/bison
	app-text/scrollkeeper
	doc? ( >=dev-util/gtk-doc-0.6 )"

DOCS="AUTHORS ChangeLog* HACKING MAINTAINERS NEWS* README"
USE_DESTDIR="1"
ELTCONF="--reverse-deps"


pkg_setup() {
	G2CONF="--disable-default-binary \
		--without-kde-applnk-path        \
		$(use_enable static)             \
		$(use_enable ssl nss)            \
		$(use_enable ssl smime)          \
		$(use_enable ipv6)               \
		$(use_enable mono)               \
		$(use_enable nntp)               \
		$(use_enable pda pilot-conduits) \
		$(use_enable profile profiling)  \
		$(use_with ldap openldap)        \
		$(use_with kerberos krb5 /usr)"

	use ldap && G2CONF="${G2CONF} $(use_with static static-ldap)"

	if use krb4 && ! built_with_use virtual/krb5 krb4; then
		ewarn
		ewarn "In order to add kerberos 4 support, you have to emerge"
		ewarn "virtual/krb5 with the 'krb4' USE flag enabled as well."
		ewarn
		ewarn "Skipping for now."
		ewarn
		G2CONF="${G2CONF} --without-krb4"
	else
		G2CONF="${G2CONF} $(use_with krb4 krb4 /usr)"
	fi

	# Plug-ins to install. Normally we would want something similar to
	# --enable-plugins=all (plugins_base + plugins_standard), except for some
	# special cases.
	local plugins="calendar-file calendar-http calendar-weather \
		itip-formatter plugin-manager default-source addressbook-file \
		startup-wizard print-message mark-all-read groupwise-features \
		groupwise-account-setup mail-account-disable sa-junk-plugin   \
		bbdb subject-thread save-calendar select-one-source copy-tool \
		mail-to-task mark-calendar-offline mailing-list-actions       \
		default-mailer"

	# The special cases
	use gstreamer && plugins="${plugins} audio-inline"
	use dbus && plugins="${plugins} new-mail-notify"
	use mono && plugins="${plugins} mono"

	if built_with_use gnome-extra/evolution-data-server ldap; then
		plugins="${plugins} exchange-operations"
	fi

	local pluginlist=""
	for p in $plugins; do
		[ "x$pluginlist" != "x" ] && pluginlist="${pluginlist},"
		pluginlist="${pluginlist}${p}"
	done

	G2CONF="${G2CONF} --enable-plugins=${pluginlist}"
}

src_unpack() {
	unpack "${A}"
	cd "${S}"

	gnome2_omf_fix help/omf.make help/C/Makefile.in

	# Accept the list of plugins separated by commas instead of spaces.
	epatch ${FILESDIR}/${PN}-2.3.7-configure_plugins.patch
	# Fix for linking problems, #85013 and #92682
	epatch ${FILESDIR}/${PN}-2.2.3-linking-fix.patch
	# Work-around for a start-up segfault (bug #104587).
	epatch ${FILESDIR}/${PN}-2.3.8-gentoo.patch

	autoconf || die "autoconf failed"
	automake || die "automake failed"
}

src_compile() {
	# Use NSS/NSPR only if 'ssl' is enabled. They can be used from
	# mozilla/firefox if the relevant USE flags are enabled. 'firefox' take
	# precedence over 'mozilla'.
	if use ssl ; then
#		if use firefox; then
#			NSS_LIB=$(pkg-config --variable=libdir firefox-nss)
#			NSS_INC=$(pkg-config --variable=includedir firefox-nss)/nss
#			NSPR_LIB=$(pkg-config --variable=libdir firefox-nspr)
#			NSPR_INC=$(pkg-config --variable=includedir firefox-nspr)/nspr
#		elif use mozilla; then
		if use mozilla; then
			NSS_LIB=$(pkg-config --variable=libdir mozilla-nss)
			NSS_INC=$(pkg-config --variable=includedir mozilla-nss)/nss
			NSPR_LIB=$(pkg-config --variable=libdir mozilla-nspr)
			NSPR_INC=$(pkg-config --variable=includedir mozilla-nspr)/nspr
		else
			NSS_LIB=/usr/$(get_libdir)/nss
			NSS_INC=/usr/include/nss
			NSPR_LIB=/usr/$(get_libdir)/nspr
			NSPR_INC=/usr/include/nspr
		fi

		G2CONF="${G2CONF} \
			--with-nspr-includes=${NSPR_INC} \
			--with-nspr-libs=${NSPR_LIB}     \
			--with-nss-includes=${NSS_INC}   \
			--with-nss-libs=${NSS_LIB}"
	else
		G2CONF="${G2CONF} --without-nspr-libs --without-nspr-includes \
			--without-nss-libs --without-nss-includes"
	fi

	# problems with -O3 on gcc-3.3.1
	replace-flags -O3 -O2

	if [ "${ARCH}" = "hppa" ]; then
		append-flags "-fPIC -ffunction-sections"
		export LDFLAGS="-ffunction-sections -Wl,--stub-group-size=25000"
	fi

	gnome2_src_compile
}

pkg_postinst() {
	gnome2_pkg_postinst

	alternatives_auto_makesym "/usr/bin/evolution" "/usr/bin/evolution-[0-9].[0-9]"
	einfo "To change the default browser if you are not using GNOME, do:"
	einfo "gconftool-2 --set /desktop/gnome/url-handlers/http/command -t string 'mozilla %s'"
	einfo "gconftool-2 --set /desktop/gnome/url-handlers/https/command -t string 'mozilla %s'"
	einfo ""
	einfo "Replace 'mozilla %s' with which ever browser you use."
}
