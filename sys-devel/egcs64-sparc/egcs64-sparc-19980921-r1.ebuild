# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/egcs64-sparc/egcs64-sparc-19980921-r1.ebuild,v 1.4 2002/07/10 13:45:38 aliz Exp $

EGCSDATE=`echo $P| sed -e 's/egcs64-sparc-\([0-9]*\).*/\1/'`
EGCSVER=2.92.11
S=${WORKDIR}/egcs64-${EGCSDATE}
A="egcs64_${EGCSDATE}.orig.tar.gz"
DESCRIPTION="sparc64 crosscompiler for building sparc64 kernels on sparc32"
SRC_URI="http://ftp.us.debian.org/debian/dists/stable/main/source/devel/${A}"
HOMEPAGE="http://www.rocklinux.de/projects/sparc/sparc.html"
LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="x86"

#RDEPEND="virtual/glibc"
#MYCHOST=`echo $CHOST | sed 's/sparc-/sparc64-/'`
DEPEND="sys-devel/autoconf"

MYPREFIX=/usr
MYCHOST=sparc64-unknown-linux-gnu

# Reset CFLAGS, gcc doesn't want that stuff
CFLAGS=""
CXXFLAGS="$CFLAGS"
export CFLAGS CXXFLAGS

src_unpack() {
	unpack ${A}
	cat ${FILESDIR}/egcs64_${EGCSDATE}-4.diff | patch -p0 -l || die
	cat ${FILESDIR}/egcs64_${EGCSDATE}-4-gentoo.diff | patch -p0 -l || die
}

src_compile() {
	unset CHOST
	mkdir ${S}/build
	cd ${S}/build
	AR_FOR_TARGET=ar LIBGCC2_INCLUDES=-I/usr/include CC=gcc \
		../configure \
			--prefix=${MYPREFIX} --mandir=${MYPREFIX}/share/man \
			--infodir=${MYPREFIX}/share/info --enable-shared \
			--enable-threads --enable-languages=c \
			--enable-version-specific-runtime-libs $MYCHOST || die

			#--prefix=${MYPREFIX} --with-local-prefix=${MYPREFIX}/local \
	# Fix a weird problem where TARGET_CONFIGDIRS gets populated with the wrong
	# thing for a kernel crosscompiler. Need to investigate.
	mv Makefile Makefile.tmp
	sed -e 's/[ ]*TARGET_CONFIGDIRS[ ]*=.*/TARGET_CONFIGDIRS = /' Makefile.tmp \
		> Makefile

	# Now make
	make \
		CFLAGS="-DHOST_WIDE_INT=long\ long -DHOST_BITS_PER_WIDE_INT=64" \
		LANGUAGES=c TARGET_CONFIGDIRS="" \
		cross || die

}

src_install() {

	cd ${S}/build
	mkdir -p ${D}/${MYPREFIX}/lib ${D}/${MYPREFIX}/bin ${D}/${MYPREFIX}/local \
				${D}/${MYPREFIX}/doc/egcs64-${EGCSDATE}/gcc

	cd gcc && make install \
		prefix=${D}/${MYPREFIX} local_prefix=${D}/${MYPREFIX}/local \
		includedir=${D}/${MYPREFIX}/local/include \
		CFLAGS='-DHOST_WIDE_INT=long\ long -DHOST_BITS_PER_WIDE_INT=64' \
		LANGUAGES=c || die

	cd ${D}/${MYPREFIX}/bin
	rm gcc gcj

	cd ${S}
	cp -a COPYING COPYING.LIB ChangeLog README MAINTAINERS \
		${D}/${MYPREFIX}/doc/egcs64-${EGCSDATE}
	cd gcc
	cp -a BUGS INSTALL LANGUAGES LITERATURE NEWS PROBLEMS PROJECTS \
		README* SERVICE TESTS.FLUNK \
		${D}/${MYPREFIX}/doc/egcs64-${EGCSDATE}/gcc

	# remove the stuff we don't need

	cd ${D}/${MYPREFIX}
	rm -rf info man
	cd ${D}/${MYPREFIX}/bin
	mv sparc64-unknown-linux-gnu-gcc egcs-${EGCSVER}
	ln -s egcs-${EGCSVER} sparc64-unknown-linux-gnu-gcc
	ln -s egcs-${EGCSVER} sparc64-unknown-linux-gcc
	ln -s egcs-${EGCSVER} sparc64-linux-gcc
	ln -s egcs-${EGCSVER} gcc64
	ln -s egcs-${EGCSVER} egcs64
	ln -s egcs-${EGCSVER} cc64
}




