# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/qtiplot/qtiplot-0.9.7.11-r2.ebuild,v 1.2 2010/01/12 17:50:26 mr_bones_ Exp $

EAPI=2
inherit eutils qt4 fdo-mime python

DESCRIPTION="Qt based clone of the Origin plotting package"
HOMEPAGE="http://soft.proindependent.com/qtiplot.html"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc python ods xls"

LANGS="cn cz de es fr ro ru ja sv"
for l in ${LANGS}; do
	lu=${l/cz/cs}
	lu=${lu/cn/zh_CN}
	IUSE="${IUSE} linguas_${lu}"
done

# qwtplot3d much modified from original upstream
# >=x11-libs/qwt-5.3 they are using trunk checkouts
CDEPEND="
	x11-libs/qt-opengl:4
	x11-libs/qt-qt3support:4
	x11-libs/qt-assistant:4
	x11-libs/qt-svg:4
	>=x11-libs/gl2ps-1.3.5
	>=dev-cpp/muParser-1.30
	>=dev-libs/boost-1.35.0
	>=sci-libs/liborigin-20090406:2
	sci-libs/gsl
	dev-libs/boost
	dev-tex/qtexengine
	xls? ( dev-libs/libxls )
	ods? ( dev-libs/quazip )"
# Still unable to build
#	emf? ( media-libs/libemf
#		media-libs/emfengine )

# TODO: check GL2PS_HAVE_ZLIB
# CONFIG          += BrowserPlugin

DEPEND="${CDEPEND}
	dev-util/pkgconfig
	python? ( >=dev-python/sip-4.9 )
	doc? ( app-text/docbook-sgml-utils
		   >=app-text/docbook-xml-dtd-4.4-r2:4.4 )"

RDEPEND="${CDEPEND}
	python? ( >=dev-lang/python-2.5
		dev-python/PyQt4[X]
		dev-python/pygsl
		dev-python/rpy
		sci-libs/scipy )"

PATCHES=(
	"${FILESDIR}/${P}-system-QTeXEngine.patch"
	"${FILESDIR}/${P}-system-liborigin.patch"
	"${FILESDIR}/${P}-system-gl2ps.patch"
	"${FILESDIR}/${PN}-0.9.7.10-dont-install-qwt.patch"
	)

src_prepare() {
	qt4_src_prepare

	rm -rf 3rdparty/{liborigin,QTeXEngine,/qwtplot3d/3rdparty/gl2ps/}

	# Check build.conf for changes on bump.
	cat >build.conf <<-EOF
	# Automatically generated by Gentoo ebuild
	isEmpty( QTI_ROOT ) {
	  message( "each file including this config needs to set QTI_ROOT to the dir containing this file!" )
	}

	MUPARSER_LIBS = \$\$system(pkg-config --libs muparser)
	GSL_LIBS = \$\$system(pkg-config --libs gsl)
	BOOST_INCLUDEPATH = /usr/include/boost
	BOOST_LIBS = -lboost_date_time-mt -lboost_thread-mt
	QWT_INCLUDEPATH = \$\$QTI_ROOT/3rdparty/qwt/src
	QWT_LIBS = \$\$QTI_ROOT/3rdparty/qwt/lib/libqwt.a
	LIB_ORIGIN_INCLUDEPATH = /usr/include/liborigin2
	LIB_ORIGIN_LIBS = -lorigin2
	SYS_LIBS = -lQTeXEngine -lgl2ps

	PYTHON = python
	LUPDATE = lupdate
	LRELEASE = lrelease

	SCRIPTING_LANGS += muParser

	CONFIG          += release
	CONFIG          += CustomInstall

	EOF

	use python && echo "SCRIPTING_LANGS += Python" >> build.conf
	use xls && echo "XLS_LIBS = -lxlsreader" >> build.conf
	if use ods; then
		echo "QUAZIP_INCLUDEPATH = /usr/include/quazip" >> build.conf
		echo "QUAZIP_LIBS = -lquazip" >> build.conf
	fi

	# Fails to build...
	#if use emf; then
	#	echo "EMF_ENGINE_INCLUDEPATH = /usr/include/libEMF" >> build.conf
	#	echo "EMF_ENGINE_LIBS = -lEMF" >> build.conf
	#fi

	python_version

	sed -e "s:doc/${PN}/manual:doc/${PF}/html:" \
		-e "s:local/${PN}:$(get_libdir)/python${PYVER}/site-packages:" \
			-i qtiplot/qtiplot.pro || die

	sed -e '/INSTALLS.*documentation/d' \
		-e '/INSTALLS.*manual/d' \
			-i qtiplot/qtiplot.pro || die
	sed -e '/manual/d' -i qtiplot.pro || die

	# Drop langs only if LINGUAS is not empty
	if [[ -n ${LINGUAS} ]]; then
		for l in ${LANGS}; do
			lu=${l/cz/cs}
			lu=${lu/cn/zh_CN}
			use linguas_${lu} || \
				sed -e "s:translations/qtiplot_${l}.[tq][sm]::" \
						-i qtiplot/qtiplot.pro || die
		done
	fi
	chmod -x qtiplot/qti_wordlist.txt

	# sed out debian paths
	sed -e 's:\(/usr/share/sgml/\)docbook/stylesheet/dsssl/modular\(/html/docbook.dsl\):\1stylesheets/dsssl/docbook\2:' \
		-i manual/qtiplot.dsl || die
	sed -e 's:\(/usr/share/\)xml/docbook/stylesheet/nwalsh\(/html/chunk.xsl\):\1sgml/docbook/xsl-stylesheets\2:' \
		-i manual/qtiplot_html.xsl || die
}

src_configure() {
	use amd64 && export QMAKESPEC="linux-g++-64"
	eqmake4
}

src_compile() {
	emake || die "emake failed"
	lrelease qtiplot/qtiplot.pro || die
	if use doc; then
		cd manual
		emake web || die "html docbook building failed"
	fi
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die 'emake install failed'
	newicon qtiplot_logo.png qtiplot.png
	make_desktop_entry qtiplot "QtiPlot Scientific Plotting" qtiplot
	if use doc; then
		insinto /usr/share/doc/${PF}/html
		doins -r manual/html/* || die "install manual failed"
	fi

	if [[ -n ${LINGUAS} ]]; then
		insinto /usr/share/${PN}/translations
		for l in ${LANGS}; do
			lu=${l/cz/cs}
			lu=${lu/cn/zh_CN}
			use linguas_${lu} && \
				doins qtiplot/translations/qtiplot_${l}.qm
		done
	fi
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
