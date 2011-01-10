# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cyrus-imap-dev/cyrus-imap-dev-2.3.16.ebuild,v 1.2 2011/01/10 18:25:34 flameeyes Exp $

inherit eutils autotools

MY_PV="${PV/_/}"

DESCRIPTION="Developer support for the Cyrus IMAP Server."
HOMEPAGE="http://asg.web.cmu.edu/cyrus/imapd/"
SRC_URI="ftp://ftp.andrew.cmu.edu/pub/cyrus-mail/cyrus-imapd-${MY_PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="afs kerberos snmp ssl tcpd"

RDEPEND=">=sys-libs/db-3.2
	>=dev-libs/cyrus-sasl-2.1.12
	afs? ( >=net-fs/openafs-1.2.2 )
	kerberos? ( >=app-crypt/mit-krb5-1.2.6 )
	snmp? ( net-analyzer/net-snmp )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S="${WORKDIR}/cyrus-imapd-${MY_PV}"

src_unpack() {
	unpack ${A} && cd "${S}"

	# Add libwrap defines as we don't have a dynamicly linked library.
	if use tcpd ; then
		epatch "${FILESDIR}/cyrus-imapd-libwrap.patch" || die "patch failed"
	fi

	epatch "${FILESDIR}"/cyrus-imapd-2.3.16+db-5.0.patch

	# Recreate configure.
	export WANT_AUTOCONF="2.5"
	eautoreconf

	# When linking with rpm, you need to link with more libraries.
	sed -e "s:lrpm:lrpm -lrpmio -lrpmdb:" -i configure || die "sed failed"
}

src_compile() {
	local myconf
	myconf="${myconf} `use_with afs`"
	myconf="${myconf} `use_with ssl openssl`"
	myconf="${myconf} `use_with snmp ucdsnmp`"
	myconf="${myconf} `use_with tcpd libwrap`"
	myconf="${myconf} `use_enable kerberos gssapi`"

	econf \
		--enable-murder \
		--enable-listext \
		--enable-netscapehack \
		--with-cyrus-group=mail \
		--with-com_err=yes \
		--without-perl \
		${myconf} || die "econf failed"

	emake -C "${S}/lib" all || die "compile problem"
}

src_install() {
	dodir /usr/include/cyrus

	make -C "${S}/lib" DESTDIR="${D}" install || die "make install failed"
	dodoc COPYRIGHT README*
}
