# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Mikael Hallendal <hallski@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/grub/grub-0.91.ebuild,v 1.1 2002/01/29 15:58:41 gbevin Exp $


S=${WORKDIR}/${P}
DESCRIPTION="GNU GRUB boot loader"
SRC_URI="ftp://alpha.gnu.org/gnu/grub/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/grub"

DEPEND="virtual/glibc
		>=sys-devel/binutils-2.9.1.0.23
        >=sys-libs/ncurses-5.2-r2"

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}/grub-0.91-vga16.patch || die
	patch -p1 < ${FILESDIR}/${P}/grub-0.5.96.1-dont-give-mem-to-kernel.patch || die
	patch -p1 < ${FILESDIR}/${P}/grub-0.90-vga16-keypressclear.patch || die
	patch -p1 < ${FILESDIR}/${P}/grub-0.90-passwordprompt.patch || die
	patch -p1 < ${FILESDIR}/${P}/grub-0.90-install.in.patch || die
	patch -p1 < ${FILESDIR}/${P}/grub-0.90-installcopyonly.patch || die
	patch -p1 < ${FILESDIR}/${P}/grub-0.90-symlinkmenulst.patch || die
	patch -p1 < ${FILESDIR}/${P}/grub-0.90-append.patch || die
	patch -p1 < ${FILESDIR}/${P}/grub-0.90-addsyncs.patch || die
	patch -p1 < ${FILESDIR}/${P}/grub-0.5.96.1-special-raid-devices.patch || die
	patch -p1 < ${FILESDIR}/${P}/grub-0.91-splashimagehelp.patch || die
	patch -p1 < ${FILESDIR}/${P}/grub-0.91-initrdusemem.patch || die
}

src_compile() {

	./configure --prefix=/usr		\
		--sbindir=/sbin				\
		--mandir=/usr/share/man		\
		--infodir=/usr/share/info	\
		--host=${CHOST} || die "Configuration of package failed."
	
	# Have to do this since the configure-script seems a little brooken
	echo "#define VGA16 1" >> config.h
	mv Makefile Makefile_orig
	sed -e "s#config.h: stamp-h#config.h:#" Makefile_orig > Makefile

	emake -e CPPFLAGS="-Wall -Wmissing-prototypes -Wunused		\
		-Wshadow -malign-jumps=1 -malign-loops=1				\
		-malign-functions=1 -Wundef" || die "Building failed."
}

src_install() {
	
	make prefix=${D}/usr			\
		sbindir=${D}/sbin			\
		mandir=${D}/usr/share/man	\
		infodir=${D}/usr/share/info	\
		install || die "Installation failed."
	
	if [ -z "`use bootcd`" ]
	then
		dodir /boot/grub
		cd ${D}/usr/share/grub/i386-pc
		cp stage1 stage2 *stage1_5 ${D}/boot/grub
		cp ${FILESDIR}/${P}/splash.xpm.gz ${D}/boot/grub
		
		cd ${S}
		dodoc AUTHORS BUGS COPYING ChangeLog NEWS README THANKS TODO
	else
		rm -rf ${D}/usr/share/{man,info,doc}
	fi
}
