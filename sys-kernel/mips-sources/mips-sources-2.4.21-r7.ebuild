# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-sources/mips-sources-2.4.21-r7.ebuild,v 1.3 2004/02/23 10:48:55 kumba Exp $


# Version Data
OKV=${PV/_/-}
CVSDATE="20030803"
EXTRAVERSION="-mipscvs-${CVSDATE}"
KV="${OKV}${EXTRAVERSION}"
COBALTPATCHVER="1.0"

# Miscellaneous stuff
S=${WORKDIR}/linux-${OKV}-${CVSDATE}

# Eclass stuff
ETYPE="sources"
inherit kernel eutils


# INCLUDED:
# 1) linux sources from kernel.org
# 2) linux-mips.org CVS snapshot diff from 03 Aug 2003
# 3) patch to fix arch/mips[64]/Makefile to pass appropriate CFLAGS
# 4) Fix for headers on big-endian machines
# 5) do_brk fix
# 6) mremap fix
# 7) RTC fixes
# 8) do_munmap fix
# 9) Patches for Cobalt support


DESCRIPTION="Linux-Mips CVS sources for MIPS-based machines, dated ${CVSDATE}"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
		mirror://gentoo/mipscvs-${OKV}-${CVSDATE}.diff.bz2
		mirror://gentoo/cobalt-patches-24xx-${COBALTPATCHVER}.tar.bz2"
HOMEPAGE="http://www.linux-mips.org/"
SLOT="${OKV}"
PROVIDE="virtual/linux-sources"
KEYWORDS="-* mips"


src_unpack() {
	unpack ${A}
	mv ${WORKDIR}/linux-${OKV} ${WORKDIR}/linux-${OKV}-${CVSDATE}
	cd ${S}

	# Update the vanilla sources with linux-mips CVS changes
	epatch ${WORKDIR}/mipscvs-${OKV}-${CVSDATE}.diff

	# Patch arch/mips/Makefile for gcc (Pass -mips3/-mips4 for r4k/r5k cpus)
	epatch ${FILESDIR}/mipscvs-${OKV}-makefile-fix.patch

	# Big Endian Fix (Fix in headers for big-endian machines)
	epatch ${FILESDIR}/bigendian-byteorder-fix.patch

	# MIPS RTC Fixes (Fixes memleaks, backport from 2.4.24)
	epatch ${FILESDIR}/rtc-fixes.patch

	# Security Fixes
	echo -e ""
	ebegin "Applying Security Fixes"
		epatch ${FILESDIR}/CAN-2003-0961-do_brk.patch
		epatch ${FILESDIR}/CAN-2003-0985-mremap.patch
		epatch ${FILESDIR}/CAN-2004-0010-ncpfs.patch
		epatch ${FILESDIR}/CAN-2004-0077-do_munmap.patch
	eend

	# Cobalt Patches
	if [ "${PROFILE_ARCH}" = "cobalt" ]; then
		echo -e ""
		einfo ">>> Patching kernel for Cobalt support ..."
		for x in ${WORKDIR}/cobalt-patches-24xx-${COBALTPATCHVER}/*.patch; do
			epatch ${x}
		done
		cp ${WORKDIR}/cobalt-patches-24xx-${COBALTPATCHVER}/cobalt-patches.txt ${S}
	fi

	kernel_universal_unpack
}
