# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/boost/boost-1.32.0-r1.ebuild,v 1.2 2005/03/05 16:02:36 morfic Exp $

# This ebuild was generated by Ebuilder v0.4.
inherit python

BOOST_PV1=${PV/./_}
BOOST_PV=${BOOST_PV1/./_}
S="${WORKDIR}/${PN}_${BOOST_PV}"
DESCRIPTION="Boost Libraries for C++"
SRC_URI="mirror://sourceforge/boost/${PN}_${BOOST_PV}.tar.bz2"
HOMEPAGE="http://www.boost.org/"
LICENSE="freedist Boost-1.0"
SLOT="1"
IUSE="icc"

DEPEND="sys-devel/gcc
	dev-lang/python"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc ~ppc64"

pkg_setup() {

	if [ "${ARCH}" == "amd64" ]; then
		arch=
	else
		arch=${ARCH}
	fi

	if use icc ; then
		BOOST_TOOLSET="intel-linux"
		TOOLSET_NAME="icc"
	else
		BOOST_TOOLSET="gcc"
		TOOLSET_NAME="gcc"
	fi

	BOOSTJAM=./tools/build/jam_src/bin.linux${arch}/bjam
}

src_compile() {
		echo ${LAYOUT}
		python_version
		# Build bjam, a jam variant, which is used instead of make
		cd ${S}/tools/build/jam_src
		./build.sh ${BOOST_TOOLSET} || die "Failed to build bjam"
		cd ${S}

}

src_install () {
		# install build tools
		cd tools/build
		#do_whatever is too limiting here, need to move bunch of different stuff recursively
		dodir /usr/share/${PN}
		cp -a b* c* index.html v1/ v2/ ${D}/usr/share/${PN}
		cd ${S}

		${BOOSTJAM}	-sBOOST_ROOT=${S} \
		-sPYTHON_ROOT=/usr \
		-sPYTHON_VERSION=${PYVER} \
		-sTOOLS=${BOOST_TOOLSET} \
		--prefix=${D}/usr \
		--layout=system \
		install || die "Install failed"

	# Install documentation; seems to be mostly under ${S}/lib
	   # install documentation
	dodoc README
	dohtml index.htm google_logo_40wht.gif c++boost.gif boost.css
	dohtml -A pdf -r more
	dohtml -r people
	dohtml -r doc

	find libs -type f -not -regex '^libs/[^/]*/build/.*' \
		-and -not -regex '^libs/.*/test[^/]?/.*' \
		-and -not -regex '^libs/.*/bench[^/]?/.*' \
		-and -not -regex '^libs/[^/]*/tools/.*' \
		-and -not -name \*.bat \
		-and -not -name Jamfile\* \
		-and -not -regex '^libs/[^/]*/src/.*' \
		-and -not -iname makefile \
		-and -not -name \*.mak \
		-and -not -name .\* \
		-and -not -name \*.dsw \
		-and -not -name \*.dsp \
		-exec \
	install -D -m0644 \{\} ${D}/usr/share/doc/${P}/html/\{\} \;

		#and finally set "default" links to -gcc-mt versions
		cd ${D}/usr/lib

		for fn in `ls -1 *.so|cut -d- -f1|sort|uniq`; do
				dosym $fn.so $fn-${TOOLSET_NAME}.so
				dosym $fn-mt.so $fn-${TOOLSET_NAME}-mt.so
				dosym $fn-d.so $fn-${TOOLSET_NAME}-d.so
				dosym $fn-mt-d.so $fn-${TOOLSET_NAME}-mt-d.so
		done

		for fn in `ls -1 *.a|cut -d- -f1|sort|uniq`; do
				dosym $fn.a $fn-${TOOLSET_NAME}.a
				dosym $fn-mt.a $fn-${TOOLSET_NAME}-mt.a
				dosym $fn-d.a $fn-${TOOLSET_NAME}-d.a
				dosym $fn-mt-d.a $fn-${TOOLSET_NAME}-mt-d.a
		done

}
