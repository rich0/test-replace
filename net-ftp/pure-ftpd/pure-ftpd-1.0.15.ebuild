# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2 
# $Header: /var/cvsroot/gentoo-x86/net-ftp/pure-ftpd/pure-ftpd-1.0.15.ebuild,v 1.2 2003/06/22 17:07:32 raker Exp $

DESCRIPTION="Pure-FTPd is a fast, production-quality, standard-conformant FTP server"
SRC_URI="ftp://ftp.pureftpd.org/pub/pure-ftpd/releases/${P}.tar.bz2"
HOMEPAGE="http://www.pureftpd.org/"
DEPEND="virtual/glibc
	pam? ( >=sys-libs/pam-0.75 )
	mysql? ( >=dev-db/mysql-3* )
	postgres? ( >=dev-db/postgresql-7.2.2 )
	ldap? ( >=net-nds/openldap-2.0.25 )"
SLOT="0"
# Changed from GPL-2 to BSD 06/09/2003
LICENSE="BSD"
KEYWORDS="x86 ~ppc ~sparc ~alpha"
IUSE="pam mysql postgres ldap"

src_compile() {
	use pam && myconf="${myconf} --with-pam"
	use ldap && myconf="${myconf} --with-ldap"
	use mysql && myconf="${myconf} --with-mysql"
	use postgres && myconf="${myconf} --with-pgsql"
	
	econf	--with-altlog --with-extauth \
		--with-puredb --with-cookie \
		--with-throttling --with-ratios \
		--with-quotas --with-ftpwho \
		--with-uploadscript --with-virtualhosts \
		--with-virtualchroot --with-diraliases \
		--with-peruserlimits ${myconf}
	emake || die "compile problem"
}

src_install() {
	einstall

	dodoc AUTHORS CONTACT COPYING ChangeLog FAQ HISTORY INSTALL README* NEWS

	dodir /etc/{conf.d,init.d}
	cp ${FILESDIR}/ftpusers ${D}/etc/ftpusers
	cp ${FILESDIR}/pure-ftpd.conf_d ${D}/etc/conf.d/pure-ftpd

	use pam && insinto /etc/pam.d && doins pam/{ftplockout,pure-ftpd}

	exeinto /etc/init.d
	newexe ${FILESDIR}/pure-ftpd.rc6-r1 pure-ftpd

	insopts -m 644
	insinto /etc/xinetd.d
	newins ${FILESDIR}/pure-ftpd.xinetd pure-ftpd

	if [ `use ldap` ]; then
		dodir /etc/openldap/schema
		insinto /etc/openldap/schema
		doins openldap.schema
		insinto /etc/openldap
		doins pureftpd-ldap.conf
	fi
}

pkg_postinst() {
	einfo "Before starting Pure-FTPd, you have to edit the /etc/conf.d/pure-ftpd file."
	echo
	ewarn "It's *really* important to read the README provided with Pure-FTPd."
	ewarn "Just point your browser at http://www.pureftpd.org/README"
}
