# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sandbox/sandbox-1.2.13.ebuild,v 1.5 2005/11/22 22:16:44 vapier Exp $

#
# don't monkey with this ebuild unless contacting portage devs.
# period.
#

inherit eutils flag-o-matic eutils toolchain-funcs multilib

DESCRIPTION="sandbox'd LD_PRELOAD hack"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~azarah/sandbox/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
#KEYWORDS=" alpha  amd64  arm  hppa  ia64  m68k  mips  ppc  ppc64  s390  sh  sparc  x86"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""
RESTRICT="multilib-pkg-force"

DEPEND=""

setup_multilib() {
	if use amd64 && has_m32 && [[ ${CONF_MULTILIBDIR} == "lib32" ]]; then
		export DEFAULT_ABI="amd64"
		export MULTILIB_ABIS="x86 amd64"
		export CFLAGS_amd64=${CFLAGS_amd64:-"-m64"}
		export CFLAGS_x86=${CFLAGS_x86-"-m32 -L/emul/linux/x86/lib -L/emul/linux/x86/usr/lib"}
		export CHOST_amd64="x86_64-pc-linux-gnu"
		export CHOST_x86="i686-pc-linux-gnu"
		export LIBDIR_amd64=${LIBDIR_amd64-${CONF_LIBDIR}}
		export LIBDIR_x86=${LIBDIR_x86-${CONF_MULTILIBDIR}}
	fi
}

src_unpack() {
	unpack ${A}
}

abi_fail_check() {
	local ABI=$1
	if [[ ${ABI} == "x86" ]] ; then
		echo
		eerror "Building failed for ABI=x86!.  This usually means a broken"
		eerror "multilib setup.  Please fix that before filling a bugreport"
		eerror "against sandbox."
		echo
	fi
}

src_compile() {
	setup_multilib

	filter-lfs-flags #90228

	has_multilib_profile && append-flags -DSB_HAVE_64BIT_ARCH

	ewarn "If configure fails with a 'cannot run C compiled programs' error, try this:"
	ewarn "FEATURES=-sandbox emerge sandbox"

	local iscross=0
	[[ -n ${CBUILD} && ${CBUILD} != ${CHOST} ]] && iscross=1

	OABI="${ABI}"
	for ABI in $(get_install_abis); do
		export ABI
		export CHOST=$(get_abi_CHOST)
		[[ ${iscross} == 0 ]] && export CBUILD=${CHOST}
		# Needed for older broken portage versions (bug #109036)
		portageq has_version "${ROOT}" '<portage-2.0.51.22' && \
			unset EXTRA_ECONF

		mkdir "${S}-${ABI}"
		cd "${S}-${ABI}"

		einfo "Configuring sandbox for ABI=${ABI}..."
		ECONF_SOURCE="../${P}/" \
		econf --libdir="/usr/$(get_libdir)"
		einfo "Building sandbox for ABI=${ABI}..."
		emake || {
			abi_fail_check "${ABI}"
			die "emake failed for ${ABI}"
		}
	done
	ABI="${OABI}"
}

src_install() {
	setup_multilib

	OABI="${ABI}"
	for ABI in $(get_install_abis); do
		cd ${S}-${ABI}
		einfo "Installing sandbox for ABI=${ABI}..."
		make DESTDIR="${D}" install || die "make install failed for ${ABI}"
	done
	ABI="${OABI}"

	keepdir /var/log/sandbox
	fowners root:portage /var/log/sandbox
	fperms 0770 /var/log/sandbox

	for x in "${S}"/{AUTHORS,COPYING,ChangeLog,NEWS,README} ; do
		[[ -s ${x} ]] && dodoc "${x}"
	done
}

pkg_preinst() {
	chown root:portage ${IMAGE}/var/log/sandbox
	chmod 0770 ${IMAGE}/var/log/sandbox
}
