# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/syslinux/syslinux-1.75.ebuild,v 1.1 2002/06/28 16:30:00 verwilst Exp $ 

DESCRIPTION="SysLinux, IsoLinux and PXELinux bootloader"
HOMEPAGE="http://syslinux.zytor.com/"
LICENSE="GPL-2"
DEPEND=">=nasm-9.98.31"
SRC_URI="ftp://ftp.kernel.org/pub/linux/utils/boot/syslinux/${P}.tar.gz"
S=${WORKDIR}/${P}

src_compile() {

	emake || die

}

src_install () {

	make INSTALLROOT=${D} install || die
	dodoc README NEWS TODO *.doc

}
