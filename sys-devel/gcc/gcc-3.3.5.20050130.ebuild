# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-3.3.5.20050130.ebuild,v 1.9 2005/02/12 20:58:20 vapier Exp $

GENTOO_TOOLCHAIN_BASE_URI="http://dev.gentoo.org/~eradicator/gcc/"
#GCC_MANPAGE_VERSION="3.3.5"
PATCH_VER="1.2"
PP_VER="3_3_5_20050130"
PP_FVER="${PP_VER//_/.}-1"
PIE_VER="8.7.7.1"
PIE_CORE="gcc-3.3.5-piepatches-v${PIE_VER}.tar.bz2"
HTB_VER="1.00-r2"
#HTB_GCC_VER="3.3.5"

ETYPE="gcc-compiler"

# arch/libc configurations known to be stable with {PIE,SSP}-by-default
SSP_STABLE="x86 sparc amd64"
SSP_UCLIBC_STABLE="arm mips ppc x86"
PIE_GLIBC_STABLE="x86 sparc amd64"
PIE_UCLIBC_STABLE="x86 mips ppc"

# arch/libc configurations known to be broken with {PIE,SSP}-by-default
SSP_UNSUPPORTED="hppa"
SSP_UCLIBC_UNSUPPORTED="${SSP_UNSUPPORTED}"
PIE_UCLIBC_UNSUPPORTED="alpha amd64 arm hppa ia64 m68k ppc64 s390 sh sparc"
PIE_GLIBC_UNSUPPORTED="hppa"

# whether we should split out specs files for multiple {PIE,SSP}-by-default
# and vanilla configurations.
SPLIT_SPECS=${SPLIT_SPECS:-"true"}

#GENTOO_PATCH_EXCLUDE=""
#PIEPATCH_EXCLUDE=""

inherit toolchain eutils

DESCRIPTION="The GNU Compiler Collection.  Includes C/C++, java compilers, pie+ssp extensions, Haj Ten Brugge runtime bounds checking"

KEYWORDS="~alpha ~amd64 ~arm ~hppa -ia64 ~mips ~sh ~sparc ~x86"

# NOTE: we SHOULD be using at least binutils 2.15.90.0.1 everywhere for proper
# .eh_frame ld optimisation and symbol visibility support, but it hasnt been
# well tested in gentoo on any arch other than amd64!!
RDEPEND="virtual/libc
	>=sys-devel/gcc-config-1.3.6
	>=sys-libs/zlib-1.1.4
	!sys-devel/hardened-gcc
	!uclibc? ( >=sys-libs/glibc-2.3.2-r9 )
	>=sys-devel/binutils-2.14.90.0.6-r1
	>=sys-devel/bison-1.875
	amd64? ( multilib? ( >=app-emulation/emul-linux-x86-glibc-1.1 ) )
	sparc? ( hardened? ( >=sys-libs/glibc-2.3.3.20040420 ) )
	!build? (
		gcj? (
			gtk? ( >=x11-libs/gtk+-2.2 )
			>=media-libs/libart_lgpl-2.1
		)
		>=sys-libs/ncurses-5.2-r2
		nls? ( sys-devel/gettext )
	)"

if [[ ${CATEGORY/cross-} != ${CATEGORY} ]]; then
	RDEPEND="${RDEPEND} ${CATEGORY}/binutils"
fi

DEPEND="${RDEPEND}
	>=sys-apps/texinfo-4.2-r4
	amd64? ( >=sys-devel/binutils-2.15.90.0.1.1-r1 )"
PDEPEND="sys-devel/gcc-config"

src_unpack() {
	gcc_src_unpack

	# bah
	sed -e 's/3\.3\.6/3.3.5/' -i ${S}/gcc/version.c


	if [ -n "${PATCH_VER}" ] && use uclibc ; then
		mv ${S}/gcc-3.3.2/libstdc++-v3/config/os/uclibc ${S}/libstdc++-v3/config/os/ || die
		mv ${S}/gcc-3.3.2/libstdc++-v3/config/locale/uclibc ${S}/libstdc++-v3/config/locale/ || die
		epatch ${FILESDIR}/3.3.3/gcc-uclibc-3.3-loop.patch
	fi

	# misc patches that havent made it into a patch tarball yet
	epatch ${FILESDIR}/gcc-spec-env.patch

	# fix an incorrect prototype of ffecom_gfrt_basictype() which causes
	# 3.3.5 to not compile on some configurations.
	epatch ${FILESDIR}/3.3.5/gcc-3.3.5-ffecom_gfrt_basictype-prototype.patch

	case $(tc-arch ${CTARGET}) in
		ppc)
			epatch ${FILESDIR}/3.3.3/gcc333_pre20040408-stack-size.patch
			;;
		arm)
			epatch ${FILESDIR}/3.3.3/gcc333-debian-arm-getoff.patch
			epatch ${FILESDIR}/3.3.3/gcc333-debian-arm-ldm.patch
			;;
	esac

	# Anything useful and objc will require libffi. Seriously. Lets just force
	# libffi to install with USE="objc", even though it normally only installs
	# if you attempt to build gcj.
	if use objc && ! use gcj ; then
		epatch ${FILESDIR}/3.3.4/libffi-without-libgcj.patch
		#epatch ${FILESDIR}/3.4.3/libffi-nogcj-lib-path-fix.patch
	fi

	# Don't screw with directories when cross-compiling
	epatch ${FILESDIR}/3.3.5/gcc-3.3.5-no-COPYING-cross-compile.patch
}
