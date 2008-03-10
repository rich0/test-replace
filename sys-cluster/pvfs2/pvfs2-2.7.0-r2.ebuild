# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/pvfs2/pvfs2-2.7.0-r2.ebuild,v 1.1 2008/03/10 01:17:07 jsbronder Exp $

inherit linux-mod autotools toolchain-funcs

MY_PN="${PN%[0-9]*}"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Parallel Virtual File System version 2"
HOMEPAGE="http://www.pvfs.org/"
SRC_URI="ftp://ftp.parl.clemson.edu/pub/pvfs2/${MY_P}.tar.gz"
IUSE="gtk server static doc ssl examples apidocs"
RDEPEND="gtk? ( >=x11-libs/gtk+-2 )
		ssl? ( dev-libs/openssl )
		doc? ( dev-tex/latex2html )
		apidocs? ( app-doc/doxygen )
		sys-libs/db"
DEPEND="${RDEPEND}
		virtual/linux-sources"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86 ~ppc64"

pkg_setup() {
	linux-mod_pkg_setup

	if kernel_is 2 4; then
		BUILD_TARGETS="just_kmod24"
		ECONF_PARAMS="--with-kernel24=${KV_DIR}"
		MODULE_NAMES="pvfs2(fs::src/kernel/linux-2.4)"
	else
		BUILD_TARGETS="just_kmod"
		ECONF_PARAMS="--with-kernel=${KV_DIR} --enable-verbose-build"
		MODULE_NAMES="pvfs2(fs::src/kernel/linux-2.6)"
	fi

	ECONF_PARAMS="${ECONF_PARAMS}
		--enable-mmap-racache
		--sysconfdir=/etc/pvfs2
		--enable-shared
		--enable-static
		$(use_enable static static-server)
		$(use_enable gtk karma)
		$(use_enable server)
		$(use_with ssl openssl /usr/$(get_libdir))"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Upstream packed all of these by mistake.
	# TODO:  Shouldn't be needed next release.
	find "${S}" -name '*\.d' | xargs rm -rf

	# All of these must be done in order and are required to fix the bug noted
	# at: http://www.beowulf-underground.org/pipermail/pvfs2-developers/2008-January/003790.html
	# TODO:  Shouldn't be needed next release.
	epatch "${FILESDIR}"/${PV}-ctl_unnumbered.patch
	epatch "${FILESDIR}"/${PV}-kernel-rt.patch
	epatch "${FILESDIR}"/${PV}-verbose-checking.patch
	epatch "${FILESDIR}"/${PV}-kmem_cache.patch

	# Fixes destdir, separates the kernel module from the userland build,
	# forces enabling of the shared threaded library.  Fixes so names and
	# makes links.  as-needed fixes for the shared libs.  All to Makefile.in
	epatch "${FILESDIR}"/2.7.0-gentoo-makefile.patch

	# Fix --enable-static-server to correctly use AC_ARG_ENABLE
	epatch "${FILESDIR}"/2.7.0-configure-static-server.patch

	# as-needed patchs
	sed -i \
		-e "s:LIBS=\"\$LIBS.*:LIBS=\"\$LIBS -lcrypt -lcrypto -lssl\":g" \
		maint/config/openssl.m4 || die
	sed -i 's:LDFLAGS=.*-lrt.*:LIBS="\$LIBS -lrt":' maint/config/rt.m4 || die

	# The following makes some builds die by actually spitting out more errors.
	# See bug #210923.  If this breaks other things, it's my fault.
	sed -i 's:-Wno-strict-aliasing=2::' maint/config/kernel.m4 || die

	AT_M4DIR="maint/config" eautoreconf || die
}

src_compile() {
	linux-mod_src_compile || die
	emake kernapps || die
	emake all || die
	if use doc; then
		emake docs || die
		if use apidocs; then
			cd "${S}"/doc
			doxygen doxygen/pvfs2-doxygen.conf || die
		fi
	fi
}

src_install() {
	linux-mod_src_install || die
	emake DESTDIR="${D}" kernapps_install
	emake DESTDIR="${D}" install

	if use server; then
		newinitd "${FILESDIR}"/pvfs2-server-init.d-2.7.0 pvfs2-server
		newconfd "${FILESDIR}"/pvfs2-server-conf.d-2.7.0 pvfs2-server
	fi

	newinitd "${FILESDIR}"/pvfs2-client-init.d-2.7.0 pvfs2-client
	newconfd "${FILESDIR}"/pvfs2-client-conf.d-2.7.0 pvfs2-client

	dodoc AUTHORS CREDITS ChangeLog INSTALL README

	# this is LARGE (~5mb)
	if use doc; then
		dodoc doc/multi-fs-doc.txt doc/add-server-req \
			doc/add-client-syscall doc/coding/valgrind \
			doc/coding/backtrace_analysis.txt
		insinto /usr/share/doc/${PF}
		doins doc/*.pdf doc/coding/developer-guidelines.pdf \
			doc/design/*.pdf doc/random/SystemInterfaceTesting.pdf
		if use apidocs; then
			dohtml -A map -A md5 doc/doxygen/html/*
		fi
	fi
	if use examples; then
		docinto examples/heartbeat
		dodoc examples/heartbeat/*
		docinto examples
		dodoc examples/fs.conf
	fi
}

pkg_preinst() {
	linux-mod_pkg_preinst
}

pkg_postinst() {
	linux-mod_pkg_postinst
	local f="$(source "${ROOT}"etc/conf.d/pvfs2-server; echo ${PVFS2_FS_CONF})"
	elog "1.)  Pvfs2 uses a unified configuration file as of 2.7.0.  If you"
	elog "  have configuration files from an earlier version, use the provided:"
	elog "  ${ROOT}usr/bin/pvfs2-config-convert"
	elog "to automatically update to the newer configuration scheme."
	elog "2.)  Use emerge --config pvfs2 to create new configuration files."
	elog "3.)  If the storage space has not been previously created, either set"
	elog "  PVFS2_AUTO_MKFS=1 in ${ROOT}etc/conf.d/pvfs2-server or run:"
	elog "  ${ROOT}usr/sbin/pvfs2-server --mkfs ${f}"
}

pkg_config() {
	local s
	local f="$(source "${ROOT}"etc/conf.d/pvfs2-server; echo ${PVFS2_FS_CONF})"
	if [[ -f "${f}" ]]; then
		ewarn "Previous install detected."
		ewarn "We're about to wipe out ${f} and replace it with"
		ewarn "the file generated by running pvfs2-genconfig.  If this is what"
		ewarn "you want to do, hit any key to continue.  Otherwise hit ctrl+C"
		ewarn "to abort."
		read s
	fi
	einfo "Creating new unified configuration file"
	ewarn "WARNING:  pvfs2 is picky about hostnames.  Make sure you use the"
	ewarn "correct shortname for all nodes and have name resolution for these"
	ewarn "shortnames correctly configured on all nodes."
	[ ! -d "${ROOT}$(dirname "${f}")" ] && mkdir -p "${ROOT}$(dirname "${f}")"
	"${ROOT}"usr/bin/pvfs2-genconfig "${f}"
}
