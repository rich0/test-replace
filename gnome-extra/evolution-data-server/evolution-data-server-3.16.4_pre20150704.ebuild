# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
PYTHON_COMPAT=( python2_7 python3_4 pypy pypy2_0 )
VALA_MIN_API_VERSION="0.22"
VALA_USE_DEPEND="vapigen"

inherit autotools db-use flag-o-matic gnome2 python-any-r1 vala virtualx

DESCRIPTION="Evolution groupware backend"
HOMEPAGE="https://wiki.gnome.org/Apps/Evolution"

COMMIT="d3587d1e064ff46406a3bd137ebdd3625c339001"
SRC_URI="https://git.gnome.org/browse/${PN}/snapshot/${PN}-${COMMIT}.tar.xz -> ${P}.tar.xz"

# Note: explicitly "|| ( LGPL-2 LGPL-3 )", not "LGPL-2+".
LICENSE="|| ( LGPL-2 LGPL-3 ) BSD Sleepycat"
SLOT="0/52" # subslot = libcamel-1.2 soname version
IUSE="api-doc-extras +gnome-online-accounts +gtk +introspection ipv6 ldap kerberos vala +weather"
REQUIRED_USE="vala? ( introspection )"

KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~x86-solaris"

# sys-libs/db is only required for migrating from <3.13 versions
# gdata-0.15.1 is required for google tasks
RDEPEND="
	>=app-crypt/gcr-3.4
	>=app-crypt/libsecret-0.5[crypt]
	>=dev-db/sqlite-3.5:=
	>=dev-libs/glib-2.40:2
	>=dev-libs/libgdata-0.10:=
	>=dev-libs/libical-0.43:=
	>=net-libs/libsoup-2.42:2.4
	>=dev-libs/libxml2-2
	>=dev-libs/nspr-4.4:=
	>=dev-libs/nss-3.9:=
	>=sys-libs/db-4:=

	dev-libs/icu:=
	sys-libs/zlib:=
	virtual/libiconv

	gtk? (
		>=app-crypt/gcr-3.4[gtk]
		>=x11-libs/gtk+-3.6:3
	)
	gnome-online-accounts? ( >=net-libs/gnome-online-accounts-3.8 )
	introspection? ( >=dev-libs/gobject-introspection-0.9.12:= )
	kerberos? ( virtual/krb5:= )
	ldap? ( >=net-nds/openldap-2:= )
	weather? ( >=dev-libs/libgweather-3.8:2= )
"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	dev-util/gdbus-codegen
	dev-util/gperf
	>=dev-util/gtk-doc-am-1.14
	>=dev-util/intltool-0.35.5
	>=gnome-base/gnome-common-3.5.5
	>=sys-devel/gettext-0.17
	virtual/pkgconfig
	vala? ( $(vala_depend) )

	dev-util/gtk-doc
"

# FIXME: This version needs dev-util/gtk-doc to provide gtk-doc.make
# Next one should be a proper tarball created after distcheck run and, then
# shouldn't require that DEPEND.

# eautoreconf needs:
#	>=gnome-base/gnome-common-2

# Some tests fail due to missings locales.
# Also, dbus tests are flacky, bugs #397975 #501834
# It looks like a nightmare to disable those for now.
RESTRICT="test"

S="${WORKDIR}/${PN}-${COMMIT}"

pkg_setup() {
	python-any-r1_pkg_setup
}

src_prepare() {
	use vala && vala_src_prepare

	# Fix relink issues in src_install
	ELTCONF="--reverse-deps"

	eautoreconf

	gnome2_src_prepare

	# Fix compilation flags crazyness, upstream bug #653157
	sed 's/^\(AM_CFLAGS="\)$WARNING_FLAGS/\1/' \
		-i configure || die "sed failed"
}

src_configure() {
	# /usr/include/db.h is always db-1 on FreeBSD
	# so include the right dir in CPPFLAGS
	append-cppflags "-I$(db_includedir)"

	# phonenumber does not exist in tree
	gnome2_src_configure \
		$(use_enable api-doc-extras gtk-doc) \
		$(use_with api-doc-extras private-docs) \
		$(use_enable gnome-online-accounts goa) \
		$(use_enable gtk) \
		$(use_enable introspection) \
		$(use_enable ipv6) \
		$(use_with kerberos krb5 "${EPREFIX}"/usr) \
		$(use_with kerberos krb5-libs "${EPREFIX}"/usr/$(get_libdir)) \
		$(use_with ldap openldap) \
		$(use_enable vala vala-bindings) \
		$(use_enable weather) \
		--enable-google \
		--enable-largefile \
		--enable-smime \
		--with-libdb="${EPREFIX}"/usr \
		--without-phonenumber \
		--disable-examples \
		--disable-uoa
}

src_install() {
	gnome2_src_install

	if use ldap; then
		insinto /etc/openldap/schema
		doins "${FILESDIR}"/calentry.schema
		dosym /usr/share/${PN}/evolutionperson.schema /etc/openldap/schema/evolutionperson.schema
	fi
}

src_test() {
	unset DBUS_SESSION_BUS_ADDRESS
	unset ORBIT_SOCKETDIR
	unset SESSION_MANAGER
	unset DISPLAY
	Xemake check
}
