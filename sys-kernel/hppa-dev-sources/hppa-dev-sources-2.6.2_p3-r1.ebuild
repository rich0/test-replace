# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hppa-dev-sources/hppa-dev-sources-2.6.2_p3-r1.ebuild,v 1.1 2004/02/18 19:13:49 plasmaroo Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"
inherit kernel
OKV="${PV/_p*/}"
PATCH_LEVEL="${PV/${OKV}_p/}"
KV=${OKV}-pa${PATCH_LEVEL}
EXTRAVERSION="-pa${PATCH_LEVEL}"
S=${WORKDIR}/linux-${KV}

PATCH_SET="0 1 ${PATCH_LEVEL}"
PATCH_COUNT="$(( `echo ${PATCH_SET} | wc -w` - 1 ))"

DESCRIPTION="Full sources for the Linux kernel with patch for hppa"
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${OKV}.tar.bz2 http://ftp.parisc-linux.org/cvs/linux-2.6/patch-${OKV}-pa`echo ${PATCH_SET} | awk '{ print $1 }'`.gz
`for i in \`seq 1 ${PATCH_COUNT}\`; do echo http://ftp.parisc-linux.org/cvs/linux-2.6/patch-${OKV}-pa\`echo ${PATCH_SET} | awk \"{ print \\\\\$$i }\"\`-pa\`echo ${PATCH_SET} | awk \"{ print \\\\\$$((i + 1)) }\"\`.gz; done`"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/ http://parisc-linux.org"
KEYWORDS="hppa -*"
SLOT="${KV}"


src_unpack() {
	unpack linux-${OKV}.tar.bz2
	mv ${WORKDIR}/linux-${OKV} ${WORKDIR}/linux-${KV}
	cd ${S}

	einfo Applying ${OKV}-pa`echo ${PATCH_SET} | awk '{ print $1 }'`
	zcat ${DISTDIR}/patch-${OKV}-pa`echo ${PATCH_SET} | awk '{ print $1 }'`.gz | patch -sp 1

	for i in `seq 1 ${PATCH_COUNT}`
	do
		a=`echo ${PATCH_SET} | awk "{ print \\\$$i }"`
		b=`echo ${PATCH_SET} | awk "{ print \\\$$((i + 1)) }"`
		einfo Applying patch from ${OKV}-pa${a} to ${OKV}-pa${b}
		zcat ${DISTDIR}/patch-${OKV}-pa${a}-pa${b}.gz | patch -sp 1
	done

	epatch ${FILESDIR}/${P}.munmap.patch || die "Failed to apply munmap patch!"
	ARCH=parisc kernel_universal_unpack
}
